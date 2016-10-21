//
//  EveryDayModel.h
//  Travel
//
//  Created by 申浩光 on 15/9/19.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EveryDayModel : NSObject

@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *comments_count;
@property (nonatomic, copy) NSString *cover_image;
@property (nonatomic, copy) NSString *cover_image_1600;
@property (nonatomic, copy) NSString *cover_image_s;
@property (nonatomic, copy) NSString *cover_image_w640;
@property (nonatomic, copy) NSString *index_title;
@property (nonatomic, copy) NSString *index_cover;
@property (nonatomic, copy) NSString *date_tour;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *date_added;
@property (nonatomic, copy) NSString *dateadded;
@property (nonatomic, copy) NSString *date_complete;
@property (nonatomic, copy) NSString *extra1;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, retain) NSDictionary *center_point;
@property (nonatomic, copy) NSString *popularity;
@property (nonatomic, copy) NSString *spot_region;
@property (nonatomic, copy) NSString *timezone;
@property (nonatomic, copy) NSString *recommendations_count;
@property (nonatomic, copy) NSString *primary;
@property (nonatomic, copy) NSString *secondary;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *spot_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *trip_id;
@property (nonatomic, retain) NSDictionary *user;
@property (nonatomic, copy) NSString *view_count;
@property (nonatomic, copy) NSString *day_count;
@property (nonatomic, copy) NSString *first_day;
@property (nonatomic, copy) NSString *last_day;
@property (nonatomic, copy) NSString *last_modified;
@property (nonatomic, copy) NSString *mileage;
@property (nonatomic, copy) NSString *recommendations;
@property (nonatomic, copy) NSString *waypoints;
@property (nonatomic, copy) NSString *popular_place_str;
@property (nonatomic, copy) NSString *location_alias;

+ (EveryDayModel *)shareJsonWithDictionary:(NSDictionary *)dictionary;

@end

