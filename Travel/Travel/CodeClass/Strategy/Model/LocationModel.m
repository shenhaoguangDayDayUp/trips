//
//  LocationModel.m
//  Travel
//
//  Created by lanou on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel

- (void)dealloc
{
    [_address release];
    [_goneCnt release];
    [_ID release];
    [_intro release];
    [_likeCnt release];
    [_name release];
    [_score release];
    [_wantCnt release];
    [_path release];
    [_wiki release];
    [super dealloc];
}
+ (LocationModel *)setModelWithDic:(NSDictionary *)dic {
    LocationModel *model = [[[LocationModel alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
