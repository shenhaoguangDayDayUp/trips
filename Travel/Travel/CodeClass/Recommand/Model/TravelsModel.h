//
//  TravelsModel.h
//  Travel
//
//  Created by 申浩光 on 15/9/25.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelsModel : NSObject
@property (nonatomic, copy) NSString *first_day;
@property (nonatomic, copy) NSString *last_day;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, retain) NSNumber *day_count;
@property (nonatomic, copy) NSString *first_timezone;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, retain) NSNumber *mileage;
@property (nonatomic, retain) NSNumber *view_count;
@property (nonatomic, copy) NSString *trackpoints_thumbnail_image;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, retain) NSNumber *recommendations;
@property (nonatomic, copy) NSString *cover_image;
+ (TravelsModel *)shareJsonWithDictionary:(NSDictionary *)dictionary;
@end

