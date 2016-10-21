//
//  SearchSightModel.m
//  Travel
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "SearchSightModel.h"

@implementation SearchSightModel
-(void)dealloc{
    [_ID release];
    [_name release];
    [_type release];
    [_country release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"type"]) {
        self.type = [NSString stringWithFormat:@"%@",value];
    }
}

+ (SearchSightModel *)shareJsonWithDictonary:(NSDictionary *)dictionary
{
    SearchSightModel *model = [[[SearchSightModel alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}
@end
