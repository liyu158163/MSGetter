//
//  DataTools.h
//  MSLazyCode
//
//  Created by MelissaShu on 2017/10/28.
//  Copyright © 2017年 MelissaShu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTools : NSObject

+ (DataTools *)sharedInstance;

//获取协议代码
- (NSString *)getNSCodingResult:(NSString *)originStr;

#pragma mark - 接口字段转属性
- (NSString *)getPropertyResult:(NSString *)originStr;

#pragma mark - 懒加载
- (NSString *)getLazyResult:(NSString *)originStr;

@end
