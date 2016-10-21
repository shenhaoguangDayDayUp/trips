//
//  SightModel.h
//  Travel
//
//  Created by lanou3g on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SightModel : NSObject
@property (nonatomic,retain) NSString *ID;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *type;
@property (nonatomic,retain) NSString *visited_count;
@property (nonatomic,retain) NSString *wish_to_go_count;
@property (nonatomic,retain) NSString *slug_url;
@property (nonatomic,retain) NSString *Description;
@property (nonatomic,retain) NSString *address;
@property (nonatomic,retain) NSString *arrival_type;
@property (nonatomic,retain) NSString *cover;
@property (nonatomic,retain) NSString *tel;
@property (nonatomic,retain) NSString *opening_time;
@property (nonatomic,retain) NSDictionary *Location;
@property (nonatomic,retain) NSString *photo;
@property (nonatomic,retain) NSString *recommended_reason;


+(SightModel*)shareJsonWithDictionary:(NSDictionary *)dictionry;
@end
