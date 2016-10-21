//
//  NewStrategyModel.h
//  Travel
//
//  Created by lanou on 15/9/19.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewStrategyModel : NSObject
@property (nonatomic, retain) NSDictionary *banners;
@property (nonatomic, copy) NSString *coverpic;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSNumber *type;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pathstr;
@property (nonatomic, copy) NSString *itemid;
@property (nonatomic, copy) NSNumber *upid;
+ (NewStrategyModel *)setModelWithDic:(NSDictionary *)dic;

/**
 *  banners =     {
 img = "http://img.117go.com/timg/pgcBanner/150908/Bnrblr_4DlXrcTTaPptlvYQ.jpg";
 "img_high" = "http://img.117go.com/timg/pgcBanner/150908/BnrHigh_4DlXriVPoK2Qlb5f.jpg";
 imgip6 = "http://img.117go.com/timg/pgcBanner/150908/Bnrblr_4DlXrcdxK2LC7xGN.jpg";
 "imgip6_high" = "http://img.117go.com/timg/pgcBanner/150908/BnrHigh_4DlXriqXazFKT1Kj.jpg";
 imgip6p = "http://img.117go.com/timg/pgcBanner/150908/Bnrblr_4DlXrcyPr0krrunJ.jpg";
 "imgip6p_high" = "http://img.117go.com/timg/pgcBanner/150908/BnrHigh_4DlXriyMJqZizCL4.jpg";
 };
 coverpic = "150908/pgc_4DlXqoPgKwEtX3ep.jpg";
 id = 55ee4677538689722b8b4584;
 intro = "";
 link = "http://www.117go.com/article/The-Finnish-winter-tourism?refer=DiscoverHome";
 logo = "";
 picdomain = "http://img.117go.com/timg/";
 subtitle = "\U7ea6\U4f1a\U82ac\U5170\U6700\U7f8e\U7684\U51ac\U5b63";
 title = "\U8d70\U5230\U51b0\U5929\U96ea\U5730\U53bb";
 */

@end
