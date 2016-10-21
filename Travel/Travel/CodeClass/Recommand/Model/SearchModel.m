//
//  SearchModel.m
//  Travel
//
//  Created by 申浩光 on 15/10/7.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

- (void)dealloc {
    
    [_name release];
    [_name_en release];
    [_name_orig release];
    [_name_zh release];
    [_rating release];
    [_rating_users release];
    [_ID release];
    [_type release];
    [_visited_count release];
    [_wish_to_go_count release];
    [_url release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}


+(SearchModel *)shareJasonWithDictionary:(NSDictionary *)dictionary {
    SearchModel *model = [[[SearchModel alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}

@end
