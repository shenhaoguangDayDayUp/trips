//
//  DaysModel.m
//  Travel
//
//  Created by 申浩光 on 15/9/25.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "DaysModel.h"

@implementation DaysModel

- (void)dealloc {
    [_date release];
    [_day release];
    [_photo release];
    [_photo_1600 release];
    [_timezone release];
    [_trip_id release];
    [_ID release];
    [_city release];
    [_privacy release];
    [_comments release];
    [_photo_webtrip release];
    [_location release];
    [_text release];
    [_province release];
    [_photo_s release];
    [_date_added release];
    [_photo_w640 release];
    [_local_time release];
    [_recommendations release];
    [_model release];
    [_photo_info release];
    [super dealloc];
}

+ (DaysModel *)shareJsonWithDictionary:(NSDictionary *)dictionary {
    DaysModel *model = [[[DaysModel alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}

@end
