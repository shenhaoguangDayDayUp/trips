//
//  DetailList.m
//  Travel
//
//  Created by 申浩光 on 15/9/22.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "DetailList.h"

@implementation DetailList

- (void)dealloc {
    [_detail_id release];
    [_photo release];
    [_photo_1600 release];
    [_photo_date_created release];
    [_photo_height release];
    [_photo_s release];
    [_photo_w640 release];
    [_photo_width release];
    [_text release];
    [_timezone release];
    [_type release];
    [super dealloc];
}

+ (DetailList *)shareJasonWithdictionary:(NSDictionary *)dictionary {
    DetailList *model = [[[DetailList alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"detail_id"]) {
        self.detail_id = [NSString stringWithFormat:@"%@",value];
    } else if ([key isEqualToString:@"photo_height"]) {
        self.photo_height = [NSString stringWithFormat:@"%@",value];
    } else if ([key isEqualToString:@"photo_width"]) {
        self.photo_width = [NSString stringWithFormat:@"%@",value];
    } else if ([key isEqualToString:@"type"]) {
        self.type = [NSString stringWithFormat:@"%@",value];
    }
}



@end
