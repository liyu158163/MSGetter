//
//  ViewController.m
//  MSLazyCode
//
//  Created by MelissaShu on 17/8/18.
//  Copyright © 2017年 MelissaShu. All rights reserved.
//

#import "ViewController.h"

#import "MSPropertyModel.h"
#import "PayWindowController.h"
#import "DataTools.h"

@interface ViewController()<NSTextViewDelegate>

@property (weak) IBOutlet NSButton *clearBtn;
@property (weak) IBOutlet NSButton *resultCopyBtn;

@property (weak) IBOutlet NSButton *helpBtn;

@property (weak) IBOutlet NSButton *lazyBtn;
@property (weak) IBOutlet NSButton *codBtn;
@property (weak) IBOutlet NSButton *propBtn;


@property (unsafe_unretained) IBOutlet NSTextView *originTxView;
@property (unsafe_unretained) IBOutlet NSTextView *resultTxView;

@property (nonatomic,strong) PayWindowController *payWindowC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)textViewDidChangeTypingAttributes:(NSNotification *)notification{
    
    NSString *result =[self.originTxView.string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.originTxView.string = result;
    self.originTxView.backgroundColor = [NSColor whiteColor];
    
}

- (IBAction)donateBtnOnClick:(id)sender {
    
    [self.payWindowC.window makeKeyAndOrderFront:nil];
}

- (void)setUI{
    
    for (NSButton *btn in self.view.subviews) {
        if ([btn isKindOfClass:[NSButton class]]) {
            
            if (btn != self.helpBtn) {
                btn.bezelStyle =  NSRoundedBezelStyle;
                [btn setButtonType:NSButtonTypeMomentaryPushIn];
            }
        }
    }
    self.originTxView.delegate = self;
    self.originTxView.font = [NSFont systemFontOfSize:18];
    self.originTxView.textContainerInset = CGSizeMake(10, 10);

    self.resultTxView.font = [NSFont systemFontOfSize:18];
    self.resultTxView.textContainerInset = CGSizeMake(10, 10);

}

- (void)showResult:(NSString *)allResult{
    
    self.resultTxView.string = allResult;
    
    NSPasteboard *paste = [NSPasteboard generalPasteboard];
    [paste clearContents];
    [paste writeObjects:@[self.resultTxView.string]];
}

- (IBAction)copyAction:(id)sender {
    
    NSPasteboard *paste = [NSPasteboard generalPasteboard];
    [paste clearContents];
    [paste writeObjects:@[self.resultTxView.string]];
    
}


- (IBAction)transformBtnOnClick:(id)sender {

    NSString *result = [[DataTools sharedInstance] getLazyResult:self.originTxView.string];
    
    [self showResult:result];
}


//实现NSCoding协议
- (IBAction)tansform2Action:(id)sender {
  
    NSString *result = [[DataTools sharedInstance] getNSCodingResult:self.originTxView.string];
    [self showResult:result];
    
}

//接口字段转属性
- (IBAction)transform3Action:(id)sender {
    
    NSString *result = [[DataTools sharedInstance] getPropertyResult:self.originTxView.string];
    
    [self showResult:result];
    
}

#pragma mark - Getter

- (PayWindowController *)payWindowC
{
    if(!_payWindowC){
        _payWindowC = [[PayWindowController alloc] init];
    }
    return _payWindowC;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
