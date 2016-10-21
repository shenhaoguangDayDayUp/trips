//
//  DateModel.h
//  Travel
//
//  Created by 申浩光 on 15/10/2.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModel : NSObject

@property (nonatomic, retain) NSString *html_url;
@property (nonatomic, retain) NSString *image_url;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, retain) NSNumber *day;
+ (DateModel *)shareJsonWithDictionary:(NSDictionary *)dictionary;
@end
