//
//  StrategyDataBase.h
//  Travel
//
//  Created by lanou on 15/10/5.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "SightModel.h"
#import "ZDetailModel.h"
#import "EveryDayModel.h"
#import "TravelsModel.h"
@interface StrategyDataBase : NSObject
@property (nonatomic, readonly) FMDatabase *dataBase;
+ (StrategyDataBase *)shareDataBase;

//详情界面
- (void)createSqliteStrategy;
- (void)insertStrategyCollectionWithTitle:(NSString *)title ZDetailModel:(ZDetailModel *)model itemId:(NSString *)itemId  tourId:(NSString *)tourId url:(NSString *)url picUrl:(NSString *)picUrl subTitle:(NSString *)subTitle;
- (BOOL)jugdeIsCollectedWithTitle:(NSString *)title ItemId:(NSString *)itemId  tourId:(NSString *)tourId;
- (void)deleteWebCollectionWithTitle:(NSString *)title ItemId:(NSString *)itemId  tourId:(NSString *)tourId;
- (NSMutableArray *)allStrategyCollection;


//目的地详情界面

// 建表
- (void)creatSightListListWithName;
// 插入一条数据
- (void)insertModel:(SightModel *)sight;

// 获取所有数据
- (NSMutableArray *)selectedAll;

// 删除景点
- (void)deleteSightModelWithname:(NSString *)name;

//是否收藏
- (BOOL)isfavorite:(NSString *)name;


// 游记和精彩故事

// 建表
- (void)createSqliteWithRecommend;

// 插入数据
- (void)insertRecommendCollectWithModel:(EveryDayModel *)model travel:(TravelsModel *)travel soptID:(NSString *)spotID ID:(NSString *)ID picUrl:(NSString *)picUrl;

// 获取所有数据
- (NSMutableArray *)getAllRecommendCollecttion;

// 删除数据
- (void)deleteRecommendCollectionWithTitle:(NSString *)title spotId:(NSString *)spotId ID:(NSString *)ID;

// 判断是否收藏
- (BOOL) isCollectRecommendWithTitle:(NSString *)title spotId:(NSString *)spotId ID:(NSString *)ID content:(NSString *)content;

//登录
- (void)createSqliteWithLogin;
- (void)loginWithUserID:(NSString *)userID uerName:(NSString *)name;
- (BOOL)isLogin;
- (void)logOut;
- (NSString *)getUserID;
- (NSString *)getUserName;

//引导图
- (void)createSqliteGuider;
- (BOOL)isFirstGuide;

- (void)deleteAllCollection;
@end
