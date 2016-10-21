//
//  StrategyModel.m
//  Travel
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "StrategyModel.h"

@implementation StrategyModel

- (void)dealloc
{
    [_tourId release];
    [_cntcmt release];
    [_cntFav release];
    [_cntMember release];
    [_coverpic release];
    [_days release];
    [_foreword release];
    [_likeCnt release];
    [_startdate release];
    [_tags release];
    [_timestamp release];
    [_title release];
    [_viewCnt release];
    [_owner release];
    [super dealloc];
}

+ (StrategyModel *)setStrategyModelWithDic:(NSDictionary *)dic {
    StrategyModel *model = [[[StrategyModel alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dic];
    model.tourId = dic[@"id"];
    model.coverpic = [NSString stringWithFormat:@"http://img.117go.com/timg/p750/%@", model.coverpic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
