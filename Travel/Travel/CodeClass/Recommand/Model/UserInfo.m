//
//  UserInfo.m
//  Travel
//
//  Created by 申浩光 on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

-(void)dealloc {
    [_avatar_l release];
    [_avatar_m release];
    [_avatar_s release];
    [_cover release];
    [_custom_url release];
    [_gender release];
    [_ID release];
    [_name release];
    [_user_desc release];
    [super dealloc];
}

+ (UserInfo *)shareJasonWithDictionary:(NSDictionary *)dictionary {
    UserInfo *model = [[[UserInfo alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"gender"]) {
        self.gender = [NSString stringWithFormat:@"%@", value];
    }
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}

@end
