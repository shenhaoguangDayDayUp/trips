//
//  LPhotoModel.h
//  Travel
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPhotoModel : NSObject
@property (nonatomic,retain) NSString *photo;
@property (nonatomic,retain) NSString *text;
@property (nonatomic,retain) NSDictionary *poi;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *local_time;
@property (nonatomic,retain) NSString *trip_name;
@property (nonatomic,retain) NSString *w;
@property (nonatomic,retain) NSString *h;

+(LPhotoModel*)shareJsonWithDictionary:(NSDictionary *)dictionry;
@end
