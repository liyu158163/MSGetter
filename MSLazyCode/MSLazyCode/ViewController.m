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

//    NSLog(@"原：%@",self.originTxView.string);
    
    NSString *result =[self.originTxView.string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *allResult=@"";
    NSArray *newArr=[result componentsSeparatedByString:@"@"];
    
    for (NSString *output in newArr) {
        NSLog(@"output : %@",output);
        if(output==nil||[output isEqualToString:@""])
        {
            continue;
        }
        // NSLog(@"%@\n....",[self formatGetter:output]);
        NSString *spaceStr=[NSString stringWithFormat:@"%@\n",[self formatGetter:output]];
        allResult=[allResult stringByAppendingString:spaceStr];
    }
    
    self.resultTxView.string = allResult;
    
}


-(NSString*)formatGetter:(NSString*)sourceStr
{
    NSString *myResult;
    NSRange rangLeft  = [sourceStr rangeOfString:@")"];
    NSRange rangRight = [sourceStr rangeOfString:@"*"];
    NSRange rangEnd   = [sourceStr rangeOfString:@";"];
    
    if(rangLeft.location==NSNotFound||rangRight.location==NSNotFound || rangEnd.location == NSNotFound)
    {
        NSLog(@"错误的格式或者对象");
        return @"";
    }
    //类型名
    NSRange typePoint=NSMakeRange(rangLeft.location+1, rangRight.location-rangLeft.location);
    NSString *typeName=[sourceStr substringWithRange:typePoint];
    typeName=[typeName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //属性名
    NSRange unamePoint=NSMakeRange(rangRight.location+1, rangEnd.location - rangRight.location - 1);
    NSString *uName=[sourceStr substringWithRange:unamePoint];
    uName=[uName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSLog(@"%@  %@",typeName,uName);
    
    NSString *strFirst=[NSString stringWithFormat:@"\n- (%@)%@",typeName,uName];
    myResult=[strFirst stringByAppendingString:@"\n{"];
    NSString *underLineName=[NSString stringWithFormat:@"_%@",uName];
    
    NSString *tempSecion=[NSString stringWithFormat:@"\n    if(!%@)",underLineName];
    myResult=[myResult stringByAppendingString:tempSecion];
    myResult=[myResult stringByAppendingString:@"\n    {"];
    
    NSString *noxinghaoStr=[typeName stringByReplacingOccurrencesOfString:@"*" withString:@""];
    
    NSString *tempThird=[NSString stringWithFormat:@"\n        %@=[[%@ alloc]init];",underLineName,noxinghaoStr];
    myResult=[myResult stringByAppendingString:tempThird];
    myResult=[myResult stringByAppendingString:@"\n    }"];
    
    NSString *tempFour=[NSString stringWithFormat:@"\n    return %@;",underLineName];
    myResult=[myResult stringByAppendingString:tempFour];
    myResult=[myResult stringByAppendingString:@"\n}"];
    return myResult;
}






- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
