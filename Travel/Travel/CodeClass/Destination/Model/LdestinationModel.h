//
//  LdestinationModel.h
//  Travel
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LdestinationModel : UIImageView
//标头标题
@property (nonatomic,retain) NSString *title;
//图片
@property (nonatomic,retain) NSString *cover;
//城市名或国家名
@property (nonatomic,retain) NSString *name;
//用于拼接出下个接口
@property (nonatomic,retain) NSString *type;
//用于拼接出下个接口
@property (nonatomic,retain) NSString *ID;
@property (nonatomic,retain) NSString *slug_url;
@property (nonatomic,retain) NSString *Description;
@property (nonatomic,retain) NSString *address;
@property (nonatomic,retain) NSString *arrival_type;
@property (nonatomic,retain) NSString *tel;
@property (nonatomic,retain) NSString *opening_time;
@property (nonatomic,retain) NSDictionary *Location;
+(LdestinationModel*)shareJsonWithDictionary:(NSDictionary *)dictionry;
@end
