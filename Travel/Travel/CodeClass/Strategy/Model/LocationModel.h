//
//  LocationModel.h
//  Travel
//
//  Created by lanou on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModel : NSObject
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *goneCnt;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *likeCnt;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *wantCnt;
@property (nonatomic, copy) NSArray *path;
@property (nonatomic, copy) NSArray *wiki;

+ (LocationModel *)setModelWithDic:(NSDictionary *)dic;

@end
