//
//  DateModel.m
//  Travel
//
//  Created by 申浩光 on 15/10/2.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "DateModel.h"

@implementation DateModel
- (void)dealloc {
    [_date release];
    [_day release];
    [_image_url release];
    [_html_url release];
    [super dealloc];
}

+ (DateModel *)shareJsonWithDictionary:(NSDictionary *)dictionary {
    DateModel *model = [[[DateModel alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

@end
