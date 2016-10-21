//
//  NewStrategyModel.m
//  Travel
//
//  Created by lanou on 15/9/19.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "NewStrategyModel.h"
@implementation NewStrategyModel
- (void)dealloc
{
    [_type release];
    [_banners release];
    [_coverpic release];
    [_link release];
    [_subtitle release];
    [_title release];
    [_describe release];
    [_name release];
    [_pathstr release];
    [_itemid release];
    [super dealloc];
}

+ (NewStrategyModel *)setModelWithDic:(NSDictionary *)dic {
    NewStrategyModel *model = [[[NewStrategyModel alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dic];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    model.itemid = [formatter stringFromNumber:dic[@"itemid"]];
    [formatter release];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


@end
