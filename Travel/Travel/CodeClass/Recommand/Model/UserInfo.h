//
//  UserInfo.h
//  Travel
//
//  Created by 申浩光 on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, copy) NSString *avatar_l;
@property (nonatomic, copy) NSString *avatar_m;
@property (nonatomic, copy) NSString *avatar_s;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *custom_url;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *user_desc;

+ (UserInfo *)shareJasonWithDictionary:(NSDictionary *)dictionary;

@end






