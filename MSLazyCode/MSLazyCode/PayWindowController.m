//
//  PayWindowController.m
//  MSLazyCode
//
//  Created by MelissaShu on 17/8/21.
//  Copyright © 2017年 MelissaShu. All rights reserved.
//

#import "PayWindowController.h"
#import "PayViewController.h"

@interface PayWindowController ()

@end

@implementation PayWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    [self.window setFrame:NSMakeRect(0, 0, 200, 200) display:YES];
    
    
    PayViewController *payVC = [[PayViewController alloc]initWithNibName:@"PayViewController" bundle:nil];
    self.contentViewController = payVC;
    
    
}

@end
