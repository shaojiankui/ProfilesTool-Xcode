//
//  DragOutlineView.m
//  ProfilesTool
//
//  Created by Jakey on 15/5/6.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#import "DragOutlineView.h"

@implementation DragOutlineView
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerForDraggedTypes:@[NSFilenamesPboardType]];

    }
    
    return self;
}
- (void)awakeFromNib {
    [self registerForDraggedTypes:@[NSFilenamesPboardType]];
}

-(NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender{
    NSPasteboard *pboard = [sender draggingPasteboard];
    
    if ([[pboard types] containsObject:NSFilenamesPboardType]) {
        return NSDragOperationCopy;
    }
    if(_didEnterDraging){
        _didEnterDraging();
    }
    return NSDragOperationNone;
}

- (void)draggingEnded:(id <NSDraggingInfo>)sender{
    NSPasteboard *zPasteboard = [sender draggingPasteboard];
    NSArray *list = [zPasteboard propertyListForType:NSFilenamesPboardType];
    if(_didDragEnd){
        _didDragEnd([list firstObject],self);
    }

}
-(void)didDragEndBlock:(DidDragEnd)didDragEnd{
    _didDragEnd = [didDragEnd copy];
}
-(void)didEnterDragingBlock:(DidEnterDraging)didEnterDraging{
    _didEnterDraging  = [didEnterDraging copy];
}
- (void)rightMouseDown:(NSEvent *)theEvent {
    [super rightMouseDown:theEvent];
    if (_rightMouseDown) {
        _rightMouseDown(theEvent);
    }
}
-(void)rightMouseDownBlock:(RightMouseDown)rightMouseDown{
    _rightMouseDown = [rightMouseDown copy];
}
-(NSMenu *)menuForEvent:(NSEvent *)event
{
    NSPoint pt = [self convertPoint:[event locationInWindow] fromView:nil];
    NSInteger row = [self rowAtPoint:pt];
    if (row >= 0) {
        NSTableRowView* rowView = [self rowViewAtRow:row makeIfNecessary:NO];
        if (rowView) {
            NSInteger col = [self columnAtPoint:pt];
            if (col >= 0) {
                NSTableCellView* cellView = [rowView viewAtColumn:col];
                NSMenu* cellMenu = cellView.menu;
                if(cellMenu) {
                    return cellMenu;
                }
            }
            NSMenu* rowMenu = rowView.menu;
            if (rowMenu) {
                return rowMenu;
            }
        }
    }else{
        return self.menu;
    }
    return [super menuForEvent:event];
}

@end
