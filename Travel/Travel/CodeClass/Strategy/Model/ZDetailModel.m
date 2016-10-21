//
//  ZDetailModel.m
//  Travel
//
//  Created by lanou on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "ZDetailModel.h"

@implementation ZDetailModel
- (void)dealloc
{
    [_records release];
    [_PathMap release]  ;
    [_title release]    ;
    [_foreword release];
    [_days release];
    [_cntP release];
    [_startdate release];
    [_tags release];
    [_coverpic release];
    [_cntcmt release];
    [_cntFav release];
    [_owner release];
    [super dealloc];
}

+ (ZDetailModel *)setModelWithDic:(NSDictionary *)dic {
    ZDetailModel *model = [[[ZDetailModel alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dic];    
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
