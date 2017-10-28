//
//  AppDelegate.m
//  MSLazyCode
//
//  Created by MelissaShu on 17/8/18.
//  Copyright © 2017年 MelissaShu. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTitleView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

-(BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
    return YES;
}

//- (void)changeColor{
//    
//    NSRect boundsRect = [[[_window contentView] superview] bounds];
//    MyTitleView * titleview = [[MyTitleView alloc] initWithFrame:boundsRect];
//    [titleview setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
//    [[[_window contentView] superview] addSubview:titleview positioned:NSWindowBelow relativeTo:[[[[_window contentView] superview] subviews] objectAtIndex:0]];
//}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
