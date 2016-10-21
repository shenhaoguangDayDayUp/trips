//
//  SearchSightModel.h
//  Travel
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchSightModel : NSObject
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *ID;
@property (nonatomic,retain) NSString *type;
@property (nonatomic,retain) NSDictionary *country;
+ (SearchSightModel *)shareJsonWithDictonary:(NSDictionary *)dictionary;
@end
