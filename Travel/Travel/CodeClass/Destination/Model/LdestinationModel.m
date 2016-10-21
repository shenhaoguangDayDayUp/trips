//
//  LdestinationModel.m
//  Travel
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LdestinationModel.h"

@implementation LdestinationModel
-(void)dealloc {
    [_name release];
    [_cover release];
    [_type release];
    [_ID release];
    [_title release];
    [_Description release];
    [_address release];
    [_opening_time release];
    [_tel release];
    [_arrival_type release];
    [_Location release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"type"]) {
        self.type = [NSString stringWithFormat:@"%@",value];
    }
}

+(LdestinationModel*)shareJsonWithDictionary:(NSDictionary *)dictionry{
    LdestinationModel *destModel = [[[LdestinationModel alloc] init] autorelease];
    [destModel setValuesForKeysWithDictionary:dictionry];
    return destModel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
