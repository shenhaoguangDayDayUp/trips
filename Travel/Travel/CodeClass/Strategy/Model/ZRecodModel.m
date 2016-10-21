//
//  ZRecodModel.m
//  Travel
//
//  Created by lanou on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "ZRecodModel.h"

@implementation ZRecodModel

- (void)dealloc
{
    [_picid release];
    [_tourid release];
    [_userid release];
    [_location release] ;
    [_picfile release];
    [_words release];
    [_timestamp release];
    [_pictime release];
    [_likeCnt release];
    [_cntcmt release];
    [_picw release];
    [_pich release];
    [_picTag release];
    [_dispCity release];
    [_tourtitle release];
    [super dealloc];
}

+ (ZRecodModel *)setModelWithDic:(NSDictionary *)dic {
    ZRecodModel *model = [[[ZRecodModel alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dic];
    return  model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}



@end
