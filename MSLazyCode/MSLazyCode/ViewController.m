//
//  ViewController.m
//  MSLazyCode
//
//  Created by MelissaShu on 17/8/18.
//  Copyright © 2017年 MelissaShu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()

@property (unsafe_unretained) IBOutlet NSTextView *originTxView;
@property (unsafe_unretained) IBOutlet NSTextView *resultTxView;


@property (weak) IBOutlet NSButton *transformBtn;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (IBAction)transformBtnOnClick:(id)sender {

    NSLog(@"原：%@",self.originTxView.string);
    
//    NSString *str = self.originTxView.
    
}




- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
