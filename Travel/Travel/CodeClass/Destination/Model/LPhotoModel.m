//
//  LPhotoModel.m
//  Travel
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LPhotoModel.h"

@implementation LPhotoModel
-(void)dealloc{
    [_text release];
    [_photo release];
    [_poi release];
    [_local_time release];
    [_name release];
    [_trip_name release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"w"]){
        self.w = [NSString stringWithFormat:@"%@",value];
        
    }
    if ([key isEqualToString:@"h"]) {
        self.h = [NSString stringWithFormat:@"%@",value];
    }

}
+(LPhotoModel*)shareJsonWithDictionary:(NSDictionary *)dictionry{
    LPhotoModel *model = [[[LPhotoModel alloc] init] autorelease];
    [model setValuesForKeysWithDictionary:dictionry];
    return model;
}
@end
