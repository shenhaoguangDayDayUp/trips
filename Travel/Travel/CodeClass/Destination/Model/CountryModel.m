//
//  CountryModel.m
//  Travel
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "CountryModel.h"

@implementation CountryModel
-(void)dealloc{
    [_visited_count release];
    [_cover release];
    [_title release];
    [_name release];
    [_type release];
    [_slug_url release];
    [_wish_to_go_count release];
    [super dealloc];
}
//属性中没有对应的key;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }

}


//属性中有对应的key;
- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    
    //visited_count对应的值是NSNumber 类型
    if([key isEqualToString:@"visited_count"]){
        self.visited_count = [NSString stringWithFormat:@"%@",value];
    
    }
    if ([key isEqualToString:@"wish_to_go_count"]) {
        self.wish_to_go_count = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"type"]) {
        self.type = [NSString stringWithFormat:@"%@",value];
    }

}

+(CountryModel*)shareJsonWithDictionary:(NSDictionary *)dictionry{
    CountryModel *countryModel = [[[CountryModel alloc] init] autorelease];
    [countryModel setValuesForKeysWithDictionary:dictionry];
    return countryModel;
}
@end
