//
//  SearchModel.h
//  Travel
//
//  Created by 申浩光 on 15/10/7.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *name_en;
@property (nonatomic, copy) NSString *name_orig;
@property (nonatomic, copy) NSString *name_zh;
@property (nonatomic, retain) NSNumber *rating;
@property (nonatomic, retain) NSNumber *rating_users;
@property (nonatomic, retain) NSNumber *type;
@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSNumber *visited_count;
@property (nonatomic, retain) NSNumber *wish_to_go_count;
@property (nonatomic, copy) NSString *url;

+ (SearchModel *)shareJasonWithDictionary:(NSDictionary *)dictionary;

@end
