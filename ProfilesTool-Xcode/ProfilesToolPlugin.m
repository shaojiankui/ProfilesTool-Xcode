//
//  ProfilesToolPlugin.m
//  ProfilesTool
//
//  Created by Jakey on 16/4/19.
//  Copyright © 2016年 Jakey. All rights reserved.
//

#import "ProfilesToolPlugin.h"
#import <Cocoa/Cocoa.h>
@implementation ProfilesToolPlugin
+(void)pluginDidLoad:(NSBundle *)plugin {
    NSLog(@"插件运行了!");
    [ProfilesToolPlugin sharedInstance];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return  self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    [self hookXcodeMenu];
}
-(void)hookXcodeMenu{
    NSMenuItem *wMenuItem = [[NSApp mainMenu] itemWithTitle:@"Window"];
    if (wMenuItem) {
        [[wMenuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:@"ProfilesTool" action:@selector(show) keyEquivalent:@""];
        [menuItem setTarget:self];
        [[wMenuItem submenu] addItem:menuItem];
    }
}
- (void)show
{
    self.profilesToolController = [[ProfilesToolController alloc] initWithWindowNibName:@"ProfilesToolController"];
    [self.profilesToolController showWindow:self.profilesToolController];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}
@end
