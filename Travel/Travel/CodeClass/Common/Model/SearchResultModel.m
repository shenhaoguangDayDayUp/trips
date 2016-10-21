//
//  SearchResultModel.m
//  Travel
//
//  Created by 申浩光 on 15/10/8.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "SearchResultModel.h"

@implementation SearchResultModel

- (void)dealloc {
    [_mileage release];
    [_waypoints release];
    [_day_count release];
    [_last_modified release];
    [_date_complete release];
    [_date_added release];
    [_recommendations release];
    [_ID release];
    [_version release];
    [_name release];
    [_cover_image_1600 release];
    [_cover_image_w640 release];
    [_cover_image release];
    [_cover_image_default release];
    [super dealloc];
}

+(SearchResultModel *)shareJsonWithDictonary:(NSDictionary *)dictionary {
    SearchResultModel *model = [[[SearchResultModel alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
