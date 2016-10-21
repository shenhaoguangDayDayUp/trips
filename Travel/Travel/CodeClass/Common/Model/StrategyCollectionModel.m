//
//  StrategyCollectionModel.m
//  Travel
//
//  Created by lanou on 15/10/5.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "StrategyCollectionModel.h"

@implementation StrategyCollectionModel

- (void)dealloc
{
    [_subTitle release];
    [_title release];
    [_itemId release];
    [_tourId release];
    [_url release];
    [_picUrl release];
    [super dealloc];
}

@end
