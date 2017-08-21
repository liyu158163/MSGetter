//
//  ViewController.m
//  MSLazyCode
//
//  Created by MelissaShu on 17/8/18.
//  Copyright © 2017年 MelissaShu. All rights reserved.
//

#import "ViewController.h"

#import "MSPropertyModel.h"


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

- (IBAction)copyAction:(id)sender {
    
    NSPasteboard *paste = [NSPasteboard generalPasteboard];
    [paste clearContents];
    [paste writeObjects:@[self.resultTxView.string]];
    
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

//实现NSCoding协议
- (IBAction)tansform2Action:(id)sender {
    
    NSString *result =[self.originTxView.string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    NSMutableString *coderResult = [NSMutableString stringWithString:@"- (id)initWithCoder:(NSCoder *)aCoder {\n "];
    NSMutableString *enCoderResult = [NSMutableString stringWithString:@"- (void)encodeWithCoder:(NSCoder *)aDecoder {\n "];
    
    NSArray *newArr=[result componentsSeparatedByString:@"@"];
    
    for (NSString *output in newArr) {
        NSLog(@"output : %@",output);
        
        if(output==nil||[output isEqualToString:@""])
        {
            continue;
        }
        
        NSString *sourceStr = [output stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        MSPropertyModel *model = [self getPropertyWith:sourceStr];
        
        NSString *str1 = [self getCoderWithModel:model];
        NSString *str2 = [self getEnCoderWithModel:model];
        
        
        [coderResult appendString:@"        "];
        [enCoderResult appendString:@"      "];
        
        [coderResult appendString:str1];
        [enCoderResult appendString:str2];
        
        
        [coderResult appendString:@"\n"];
        [enCoderResult appendString:@"\n"];
    }
    
    [coderResult appendString:@"}\n"];
    [enCoderResult appendString:@"}\n"];
    
    self.resultTxView.string = [NSString stringWithFormat:@"%@ \n %@",coderResult,enCoderResult];
    
    
}

- (NSString *)getEnCoderWithModel:(MSPropertyModel *)model{
    
    
    NSString *typeName = model.typeName.lowercaseString;
    NSString *uName = model.propertyName;
    
    NSString *class0 = NSStringFromClass([NSString class]).lowercaseString;
    NSString *class1 = NSStringFromClass([NSArray class]).lowercaseString;
    NSString *class2 = NSStringFromClass([NSMutableArray class]).lowercaseString;
    
    NSArray *objClassArray = @[class0,class1,class2];
    
    NSString *result = @"";
    
    if ([objClassArray containsObject:typeName]) {
        
        result = [NSString stringWithFormat:@"[aDecoder encodeObject:self.%@ forKey:@\"%@\"];",uName,uName];
    }
    
    if ([typeName isEqualToString:@"bool"]) {
        
        result = [NSString stringWithFormat:@"[aDecoder encodeBool:self.%@ forKey:@\"%@\"];",uName,uName];
    }
    
    
    if ([typeName isEqualToString:@"int"]) {
        
        result = [NSString stringWithFormat:@"[aDecoder encodeInt:self.%@ forKey:@\"%@\"];",uName,uName];
    }
    
    if ([typeName isEqualToString:@"cgfloat"]) {
        
        result = [NSString stringWithFormat:@"[aDecoder encodeFloat:self.%@ forKey:@\"%@\"];",uName,uName];
    }
    
    if ([typeName isEqualToString:@"double"]) {
        
        result = [NSString stringWithFormat:@"[aDecoder encodeDouble:self.%@ forKey:@\"%@\"];",uName,uName];
    }
    
 
    return result;
}


- (NSString *)getCoderWithModel:(MSPropertyModel *)model{
   
    NSString *typeName = model.typeName.lowercaseString;
    NSString *uName = model.propertyName;
    
    NSString *class0 = NSStringFromClass([NSString class]).lowercaseString;
    NSString *class1 = NSStringFromClass([NSArray class]).lowercaseString;
    NSString *class2 = NSStringFromClass([NSMutableArray class]).lowercaseString;
    
    NSArray *objClassArray = @[class0,class1,class2];
    
    NSString *result = @"";
    
    if ([objClassArray containsObject:typeName]) {
        
        result = [NSString stringWithFormat:@"self.%@ = [aCoder decodeObjectForKey:@\"%@\"] ;",uName,uName];
    }
    
    if ([typeName isEqualToString:@"bool"]) {
        
        result = [NSString stringWithFormat:@"self.%@ = [aCoder decodeBoolForKey:@\"%@\"] ;",uName,uName];
    }
    
    
    if ([typeName isEqualToString:@"int"]) {
        
        result = [NSString stringWithFormat:@"self.%@ = [aCoder decodeIntForKey:@\"%@\"] ;",uName,uName];
    }
    
    if ([typeName isEqualToString:@"cgfloat"]) {
        
        result = [NSString stringWithFormat:@"self.%@ = [aCoder decodeFloatForKey:@\"%@\"] ;",uName,uName];
    }
    
    if ([typeName isEqualToString:@"double"]) {
        
        result = [NSString stringWithFormat:@"self.%@ = [aCoder decodeDoubleForKey:@\"%@\"] ;",uName,uName];
    }
    
    
    return result;

}

//接口字段转属性
- (IBAction)transform3Action:(id)sender {
     NSString *result =[self.originTxView.string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    self.originTxView.string = result;
    self.originTxView.backgroundColor = [NSColor whiteColor];
    self.originTxView.font = [NSFont systemFontOfSize:16];
    
    NSString *allResult=@"";
    NSArray *newArr=[result componentsSeparatedByString:@"\n"];
    
    for (NSString *output in newArr) {
        NSLog(@"output : %@",output);
        if(output==nil||[output isEqualToString:@""])
        {
            continue;
        }
        // NSLog(@"%@\n....",[self formatGetter:output]);
        NSString *spaceStr=[NSString stringWithFormat:@"%@\n",[self addProperty:output]];
        allResult=[allResult stringByAppendingString:spaceStr];
    }
    
    self.resultTxView.string = allResult;
    
}


- (NSString *)addProperty:(NSString *)sourceStr{

    sourceStr = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSArray *strArray=[sourceStr componentsSeparatedByString:@" "];
    NSString *nameStr = strArray.firstObject;
    
    NSString *decStr = [sourceStr substringWithRange:NSMakeRange(nameStr.length, sourceStr.length - nameStr.length)];
    
    NSString *resultStr = [NSString stringWithFormat:@"@property (nonatomic,copy) NSString *%@;     //%@",nameStr,decStr];
    
    return resultStr;
   
    
}



-(NSString*)formatGetter:(NSString*)sourceStr
{
    
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    MSPropertyModel *model = [self getPropertyWith:sourceStr];
    NSString *myResult;
   
    NSString *typeName = model.typeName;
    NSString *uName = model.propertyName;
    
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


- (MSPropertyModel *)getPropertyWith:(NSString *)sourceStr{
    
    MSPropertyModel *model = [[MSPropertyModel alloc]init];
    
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSRange rangLeft  = [sourceStr rangeOfString:@")"];
    NSRange rangRight = [sourceStr rangeOfString:@"*"];
    NSRange rangEnd   = [sourceStr rangeOfString:@";"];
    
    if(rangLeft.location==NSNotFound || rangEnd.location == NSNotFound)
    {
        NSLog(@"错误的格式或者对象");
        return model;
    }
    
    if (rangRight.location != NSNotFound) { //包含 *
        model.typeName = [sourceStr substringWithRange:NSMakeRange(rangLeft.location+1, rangRight.location-rangLeft.location - 1)];
        model.propertyName = [sourceStr substringWithRange:NSMakeRange(rangRight.location+1, rangEnd.location - rangRight.location - 1)];
        
        return model;
    }
    
    if ([sourceStr.lowercaseString containsString:@"bool"]) {
        model.typeName = @"BOOL";
        rangRight = [sourceStr.lowercaseString rangeOfString:model.typeName.lowercaseString];
        model.propertyName = [sourceStr substringWithRange:NSMakeRange(rangRight.location+rangRight.length, rangEnd.location - rangRight.location - rangRight.length)];
    }
    
    if ([sourceStr containsString:@"int"]) {
        model.typeName = @"int";
        rangRight = [sourceStr.lowercaseString rangeOfString:model.typeName.lowercaseString];
         model.propertyName = [sourceStr substringWithRange:NSMakeRange(rangRight.location+rangRight.length, rangEnd.location - rangRight.location - rangRight.length)];
    }
    
    if ([sourceStr.lowercaseString containsString:@"cgfloat"]) {
        model.typeName = @"CGFloat";
        rangRight = [sourceStr.lowercaseString rangeOfString:model.typeName.lowercaseString];
        model.propertyName = [sourceStr substringWithRange:NSMakeRange(rangRight.location+rangRight.length, rangEnd.location - rangRight.location - rangRight.length)];
    }
    
    if ([sourceStr.lowercaseString containsString:@"nsinteger"]) {
        model.typeName = @"NSInteger";
        rangRight = [sourceStr.lowercaseString rangeOfString:model.typeName.lowercaseString];
        model.propertyName = [sourceStr substringWithRange:NSMakeRange(rangRight.location+rangRight.length, rangEnd.location - rangRight.location - rangRight.length)];
    }
    
    
    
    return model;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
