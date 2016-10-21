//
//  ZRecodModel.h
//  Travel
//
//  Created by lanou on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRecodModel : NSObject
@property (nonatomic, copy) NSString *picid;
@property (nonatomic, copy) NSString *tourid;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, retain) NSDictionary *location;
@property (nonatomic, copy) NSString *picfile;
@property (nonatomic, copy) NSString *words;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *pictime;
@property (nonatomic, copy) NSString *likeCnt;
@property (nonatomic, copy) NSString *cntcmt;
@property (nonatomic, copy) NSString *picw;
@property (nonatomic, copy) NSString *pich;
@property (nonatomic, retain) NSNumber *picTag;
@property (nonatomic, copy) NSString *dispCity;
@property (nonatomic, copy) NSString *tourtitle;

+ (ZRecodModel *)setModelWithDic:(NSDictionary *)dic;
/**
 *   "UUID": "",
 "manualState": "0",
 "showState": "2",
 "showState2": "2",
 "picid": "4420905",
 "tourid": "1163792",
 "userid": "710213",
 "location": {},
 "owner": {},
 "picdomain": "http://img.117go.com/timg/",
 "picfile": "130622/5e04ef3b5b.jpg",
 "pcolor": 10067647,
 "words": "我们去吃饭的餐馆，店员号霸气的摩托车~~",
 "tag": "位置|",
 "tagArr": [ ],
 "timestamp": "2013-04-08 20:00:00",
 "pictime": "2013-04-08 14:00:00 +0200",
 "lastedit": "2013-07-07 00:04:35",
 "cntcmt": "0",
 "likeCnt": "13",
 "tourOwnerId": "710213",
 "mtime": "14153476621892",
 "isPrivate": "0",
 "picw": "1024",
 "pich": "683",
 "picTag": 1,
 "dispCity": "希腊 阿提卡 雅典",
 "tourtitle": "圣城雅典",
 "isLiked": false,
 "isSticker": 0,
 "sticker_id": "0",
 "stickerTags": "",
 "stickerTagsArr": [ ],
 "video_file_640": "",
 "dispDest": "",
 "day": 1
 */

@end
