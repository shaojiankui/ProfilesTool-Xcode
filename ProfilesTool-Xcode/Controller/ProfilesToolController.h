//
//  ProfilesToolController.h
//  ProfilesTool-Xcode
//
//  Created by Jakey on 16/4/19.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "DragOutlineView.h"
#import "ProfilesNode.h"


@interface ProfilesToolController : NSWindowController<NSOutlineViewDataSource,NSOutlineViewDelegate,NSMenuDelegate>
{
    NSString *_profileDir;
    NSArray *_profileNames;
    NSMutableArray *_profilePaths;
    NSMutableArray *_profileDatas;
    
    NSMenu *_itemMenu;
    NSMenu *_mainMenu;
    ProfilesNode *_rootNode;
    
}
@property (weak) IBOutlet DragOutlineView *treeView;

@end
