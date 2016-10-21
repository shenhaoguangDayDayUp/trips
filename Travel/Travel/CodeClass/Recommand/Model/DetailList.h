//
//  DetailList.h
//  Travel
//
//  Created by 申浩光 on 15/9/22.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailList : NSObject

@property (nonatomic, retain) NSString *detail_id;
@property (nonatomic, retain) NSString *photo;
@property (nonatomic, retain) NSString *photo_1600;
@property (nonatomic, retain) NSString *photo_date_created;
@property (nonatomic, retain) NSString *photo_height;
@property (nonatomic, retain) NSString *photo_s;
@property (nonatomic, retain) NSString *photo_w640;
@property (nonatomic, retain) NSString *photo_width;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *timezone;
@property (nonatomic, retain) NSString *type;


+ (DetailList *)shareJasonWithdictionary:(NSDictionary *)dictionary;

@end

