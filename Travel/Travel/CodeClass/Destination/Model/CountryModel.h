//
//  CountryModel.h
//  Travel
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryModel : NSObject
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *cover;
@property (nonatomic,retain) NSString *ID;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *type;
@property (nonatomic,retain) NSString *visited_count;
@property (nonatomic,retain) NSString *wish_to_go_count;
@property (nonatomic,retain) NSString *slug_url;
+(CountryModel*)shareJsonWithDictionary:(NSDictionary *)dictionry;
@end
