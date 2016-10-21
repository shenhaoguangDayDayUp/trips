//
//  SightModel.m
//  Travel
//
//  Created by lanou3g on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "SightModel.h"

@implementation SightModel
-(void)dealloc{
    [_visited_count release];
    [_name release];
    [_type release];
    [_slug_url release];
    [_opening_time release];
    [_cover release];
    [_Description release];
    [_wish_to_go_count release];
    [_address release];
    [_arrival_type release];
    [_photo release];
    [super dealloc];
}
//属性中没有对应的key;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.Description = value;
    }
    if ([key isEqualToString:@"location"]) {
        self.Location = value;
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
//    if([key isEqualToString:@"lat"]){
//        self.lat = [NSString stringWithFormat:@"%@",value];
//    }
//    if ([key isEqualToString:@"lng"]) {
//        self.lng = [NSString stringWithFormat:@"%@",value];
//    }
}

+(SightModel*)shareJsonWithDictionary:(NSDictionary *)dictionry{
    SightModel *sightModel = [[[SightModel alloc] init] autorelease];
    [sightModel setValuesForKeysWithDictionary:dictionry];
    return sightModel;
}
@end
