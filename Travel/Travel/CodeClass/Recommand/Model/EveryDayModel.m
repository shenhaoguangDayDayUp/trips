//
//  EveryDayModel.m
//  Travel
//
//  Created by 申浩光 on 15/9/19.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "EveryDayModel.h"

@implementation EveryDayModel

- (void)dealloc {
    [_lat release];
    [_lng release];
    [_comments_count release];
    [_cover_image release];
    [_cover_image_1600 release];
    [_cover_image_s release];
    [_cover_image_w640 release];
    [_index_title release];
    [_index_cover release];
    [_date_tour release];
    [_address release];
    [_category release];
    [_currency release];
    [_date_added release];
    [_dateadded release];
    [_date_complete release];
    [_extra1 release];
    [_ID release];
    [_center_point release];
    [_popularity release];
    [_spot_region release];
    [_timezone release];
    [_recommendations_count release];
    [_primary release];
    [_secondary release];
    [_share_url release];
    [_spot_id release];
    [_name release];
    [_text release];
    [_trip_id release];
    [_user release];
    [_view_count release];
    [_day_count release];
    [_first_day release];
    [_last_day release];
    [_last_modified release];
    [_mileage release];
    [_recommendations release];
    [_waypoints release];
    [_popular_place_str release];
    [_location_alias release];
    [super dealloc];
}

+(EveryDayModel *)shareJsonWithDictionary:(NSDictionary *)dictionary {
    EveryDayModel *model = [[[EveryDayModel alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"lat"]) {
        self.lat = [NSString stringWithFormat:@"%@", value];
    } else if ([key isEqualToString:@"lng"]) {
        self.lng = [NSString stringWithFormat:@"%@", value];
    } else if ([key isEqualToString:@"comments_count"]) {
        self.comments_count = [NSString stringWithFormat:@"%@", value];

    } else if ([key isEqualToString:@"category"]) {
        self.category = [NSString stringWithFormat:@"%@", value];

    } else if ([key isEqualToString:@"date_complete"]) {
        self.date_complete = [NSString stringWithFormat:@"%@", value];

    } else if ([key isEqualToString:@"popularity"]) {
        self.popularity = [NSString stringWithFormat:@"%@", value];

    } else if ([key isEqualToString:@"recommendations_count"]) {
        self.recommendations_count = [NSString stringWithFormat:@"%@", value];

    } else if ([key isEqualToString:@"spot_id"]) {
        self.spot_id = [NSString stringWithFormat:@"%@", value];

    } else if ([key isEqualToString:@"trip_id"]) {
        self.trip_id = [NSString stringWithFormat:@"%@", value];

    } else if ([key isEqualToString:@"view_count"]) {
        self.view_count = [NSString stringWithFormat:@"%@", value];

    } else if ([key isEqualToString:@"day_count"]) {
        self.day_count = [NSString stringWithFormat:@"%@", value];

    } else if ([key isEqualToString:@"last_modified"]) {
        self.last_modified = [NSString stringWithFormat:@"%@", value];

    } else if ([key isEqualToString:@"mileage"]) {
        self.mileage = [NSString stringWithFormat:@"%@", value];

    } else if ([key isEqualToString:@"waypoints"]) {
        self.waypoints = [NSString stringWithFormat:@"%@", value];
    }
    
}

@end
