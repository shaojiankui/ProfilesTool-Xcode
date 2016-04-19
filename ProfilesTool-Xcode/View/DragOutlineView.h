//
//  DragOutlineView.h
//  ProfilesTool
//
//  Created by Jakey on 15/5/6.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#import <Cocoa/Cocoa.h>
typedef void (^DidDragEnd)(NSString *result,NSOutlineView *view);
typedef void (^DidEnterDraging)();
typedef void (^RightMouseDown)(NSEvent *event);

@interface DragOutlineView : NSOutlineView
{
    DidDragEnd _didDragEnd;
    DidEnterDraging _didEnterDraging;
    RightMouseDown _rightMouseDown;
}
-(void)didDragEndBlock:(DidDragEnd)didDragEnd;
-(void)didEnterDragingBlock:(DidEnterDraging)didEnterDraging;
-(void)rightMouseDownBlock:(RightMouseDown)rightMouseDown;

@end
