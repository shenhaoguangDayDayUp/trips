//
//  ZDetailModel.h
//  Travel
//
//  Created by lanou on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDetailModel : NSObject
@property (nonatomic, retain) NSArray *records;
@property (nonatomic, retain) NSArray *PathMap;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *foreword;
@property (nonatomic, copy) NSString *days;
@property (nonatomic, copy) NSString *cntP;
@property (nonatomic, copy) NSString *startdate;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *coverpic;
@property (nonatomic, copy) NSString *cntcmt;
@property (nonatomic, copy) NSString *cntFav;
@property (nonatomic, retain) NSDictionary *owner;

+ (ZDetailModel *)setModelWithDic:(NSDictionary *)dic;
@end

/**
 *  "records": [],
 "PathMap": [],
 "products": [ ],
 "day_header": true,
 "tagsArr": [],
 "members": [],
 "myRole": "0",
 "priority": "0",
 "id": "1163792",
 "title": "圣城雅典",
 "foreword": "圣斗士，雅典娜，八零后的童年对这里充满了幻想。",
 "startdate": "2013-04-08",
 "cntP": "35",
 "days": "2",
 "tags": "美食 度假 穷游 户外 摄影 ",
 "picdomain": "http://img.117go.com/timg/",
 "coverpic": "130622/004c0e288a.jpg",
 "pcolor": 9805759,
 "subtype": "2",
 "cntcmt": "29",
 "timestamp": "2013-07-07 01:01:02",
 "cntFav": "660",
 "isPrivate": "0",
 "cntMember": "0",
 "isTeam": "0",
 "likeCnt": "660",
 "mtime": "14426593322417",
 "recmtime": "14410131425098",
 "UUID": "",
 "dispCities": [],
 "owner": {},
 "isCurrTrip": false,
 "isMyFav": false,
 "isLiked": false,
 "viewCnt": "66143",
 "equipments": [],
 "recMore": "0",
 "recType": 0,
 "otherTours": []
 */
