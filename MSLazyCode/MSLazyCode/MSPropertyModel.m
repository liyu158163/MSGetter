//
//  MSPropertyModel.m
//  MSLazyCode
//
//  Created by MelissaShu on 17/8/21.
//  Copyright © 2017年 MelissaShu. All rights reserved.
//

#import "MSPropertyModel.h"

@implementation MSPropertyModel

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.typeName = @"";
        self.propertyName = @"";
    }
    return self;
}

@end
