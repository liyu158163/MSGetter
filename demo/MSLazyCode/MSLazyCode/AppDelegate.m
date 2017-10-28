//
//  AppDelegate.m
//  MSLazyCode
//
//  Created by MelissaShu on 2017/10/28.
//  Copyright © 2017年 MelissaShu. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWindowController.h"

@interface AppDelegate ()

@property (nonatomic,strong) MainWindowController *mainWindowC;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self.mainWindowC.window center];
    [self.mainWindowC.window makeKeyAndOrderFront:nil];
}

-(BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{
    
    [self.mainWindowC.window makeKeyAndOrderFront:nil];
    return YES;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(MainWindowController *)mainWindowC{
    if (!_mainWindowC) {
        _mainWindowC = [[MainWindowController alloc]initWithWindowNibName:@"MainWindowController"];
    }
    return _mainWindowC;
}

@end
