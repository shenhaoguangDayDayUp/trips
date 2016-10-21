//
//  SearchResultModel.h
//  Travel
//
//  Created by 申浩光 on 15/10/8.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultModel : NSObject

@property (nonatomic, retain) NSNumber *mileage;
@property (nonatomic, retain) NSNumber *waypoints;
@property (nonatomic, retain) NSNumber *day_count;
@property (nonatomic, retain) NSNumber *last_modified;
@property (nonatomic, retain) NSNumber *date_complete;
@property (nonatomic, retain) NSNumber *date_added;
@property (nonatomic, retain) NSNumber *recommendations;
@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSNumber *version;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cover_image_1600;
@property (nonatomic, copy) NSString *cover_image_w640;
@property (nonatomic, copy) NSString *cover_image;
@property (nonatomic, copy) NSString *cover_image_default;

+ (SearchResultModel *)shareJsonWithDictonary:(NSDictionary *)dictionary;

@end
