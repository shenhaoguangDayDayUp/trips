//
//  TravelsModel.m
//  Travel
//
//  Created by 申浩光 on 15/9/25.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "TravelsModel.h"

@implementation TravelsModel

- (void)dealloc {
    [_first_day release];
    [_last_day release];
    [_ID release];;
    [_city release];
    [_day_count release];
    [_first_timezone release];
    [_province release];
    [_mileage release];
    [_view_count release];
    [_trackpoints_thumbnail_image release];
    [_name release];
    [_country release];
    [_recommendations release];
    [_cover_image release];
    [super dealloc];
}


+ (TravelsModel *)shareJsonWithDictionary:(NSDictionary *)dictionary {
    
    TravelsModel *model = [[[TravelsModel alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}

@end
