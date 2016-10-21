//
//  StrategyModel.h
//  Travel
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StrategyModel : NSObject
@property (nonatomic, copy) NSString *cntcmt;
@property (nonatomic, copy) NSString *cntFav;
@property (nonatomic, copy) NSString *cntMember;
@property (nonatomic, copy) NSString *coverpic;
@property (nonatomic, copy) NSString *days;
@property (nonatomic, copy) NSString *foreword;
@property (nonatomic, copy) NSString *likeCnt;
@property (nonatomic, copy) NSString *startdate;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *viewCnt;
@property (nonatomic, retain) NSDictionary *owner;
@property (nonatomic, copy) NSString *tourId;

+ (StrategyModel *)setStrategyModelWithDic:(NSDictionary *)dic;
@end
