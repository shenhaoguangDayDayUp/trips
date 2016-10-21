//
//  DaysModel.h
//  Travel
//
//  Created by 申浩光 on 15/9/25.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DaysModel : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, retain) NSNumber *day;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *photo_1600;
@property (nonatomic, copy) NSString *timezone;
@property (nonatomic, retain) NSNumber *trip_id;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, retain) NSNumber *privacy;
@property (nonatomic, retain) NSNumber *comments;
@property (nonatomic, copy) NSString *photo_webtrip;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *photo_s;
@property (nonatomic, retain) NSNumber *date_added;
@property (nonatomic, copy) NSString *photo_w640;
@property (nonatomic, copy) NSString *local_time;
@property (nonatomic, copy) NSString *recommendations;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, retain) NSDictionary *photo_info;

+ (DaysModel *)shareJsonWithDictionary:(NSDictionary *)dictionary;





@end
