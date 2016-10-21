//
//  StrategyDataBase.m
//  Travel
//
//  Created by lanou on 15/10/5.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "StrategyDataBase.h"
#import "StrategyCollectionModel.h"
@implementation StrategyDataBase
static StrategyDataBase *shareDB;

+ (StrategyDataBase *)shareDataBase {
    if (!shareDB) {
        shareDB = [[StrategyDataBase alloc] init];
    }
    return shareDB;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbpath = [docsdir stringByAppendingPathComponent:@"strategyDB.db"];
        //NSLog(@"%@", dbpath);
        _dataBase = [[FMDatabase databaseWithPath:dbpath] retain];

    }
    return self;
}

- (FMDatabase *) connect {
    if ([_dataBase open]) {
        return _dataBase;
    }
    //NSLog(@"fail to open db…");
    return nil;
}

- (void) clearDB {
    dispatch_async(dispatch_get_main_queue(), ^{
        if([_dataBase close]) {
            _dataBase = nil;
        }
    });
}


#pragma mark ------攻略详情收藏数据表操作------

- (void)createSqliteStrategy{
    [[StrategyDataBase shareDataBase] connect];
    BOOL executeUpdate = [_dataBase executeUpdate:@"CREATE TABLE strategy(title TEXT PRIMARY KEY,itemId TEXT, tourId TEXT, picUrl TEXT, url TEXT, subTitle TEXT)"];
    if (executeUpdate) {
        //NSLog(@"攻略建表成功");
    }else {
        //NSLog(@"攻略建表失败");
    }
    [_dataBase close];
}

- (void)insertStrategyCollectionWithTitle:(NSString *)title ZDetailModel:(ZDetailModel *)model itemId:(NSString *)itemId  tourId:(NSString *)tourId url:(NSString *)url picUrl:(NSString *)picUrl  subTitle:(NSString *)subTitle{
    [[StrategyDataBase shareDataBase] connect];
    BOOL insertWeb;
    
    if (model) {
        NSString *sql = [NSString stringWithFormat:@"insert into strategy(title, itemId, tourId, picUrl, subTitle) values(?,?,?,?,?)"];
        insertWeb = [_dataBase executeUpdate:sql, model.title, itemId, tourId, [NSString stringWithFormat:@"http://img.117go.com/timg/p750/%@", model.coverpic], model.foreword];
    }else{
        NSString *sql = [NSString stringWithFormat:@"insert into strategy(title, url, picUrl, subTitle) values(?,?,?,?)"];
        insertWeb = [_dataBase executeUpdate:sql,title, url, picUrl, subTitle];
    }
    
    if (insertWeb) {
        //NSLog(@"插入成功");
    }else
    {
        //NSLog(@"插入失败");
    }
    [_dataBase close];
}

- (BOOL)jugdeIsCollectedWithTitle:(NSString *)title ItemId:(NSString *)itemId  tourId:(NSString *)tourId {
    [[StrategyDataBase shareDataBase] connect];
    
    if (itemId) {
        NSString *sql = @"select * from strategy where itemId = ? and tourId = ?";
        FMResultSet *rs = [_dataBase executeQuery:sql, itemId, tourId];
        while ([rs next]) {
            NSString *rsItemId = [rs stringForColumn:@"itemId"];
            NSString *rsTourId = [rs stringForColumn:@"tourId"];

            if ([rsItemId isEqualToString:itemId] && [rsTourId isEqualToString:tourId]) {
                [_dataBase close];
                //NSLog(@"已收藏");
                return YES;
            }
        }
    }else{
        NSString *sql = @"select * from strategy where title = ?";
        FMResultSet *rs = [_dataBase executeQuery:sql, title];
        while ([rs next]) {
            NSString *rsTitle = [rs stringForColumn:@"title"];
            if ([rsTitle isEqualToString:title]) {
                [_dataBase close];
                //NSLog(@"已收藏");
                return YES;
            }
        }
    }
    
    [_dataBase close];
    return NO;
}

- (void)deleteWebCollectionWithTitle:(NSString *)title ItemId:(NSString *)itemId  tourId:(NSString *)tourId {
    [[StrategyDataBase shareDataBase] connect];
    
    BOOL delete;
    
    if (itemId) {
        delete = [_dataBase executeUpdate:@"delete from strategy where title = ? and itemId = ? and tourId = ? ", title,itemId, tourId];
    }else{
        delete = [_dataBase executeUpdate:@"delete from strategy where title = ?", title];
    }
    if (delete) {
        //NSLog(@"删除成功");
    }else{
        //NSLog(@"删除失败");
    }
    [_dataBase close];
}

- (NSMutableArray *)allStrategyCollection{
    NSMutableArray *strategyArray = [NSMutableArray array];
    [[StrategyDataBase shareDataBase] connect];
    NSString *sql = @"select * from strategy";
    FMResultSet *rs = [_dataBase executeQuery:sql];
    while ([rs next]) {
        StrategyCollectionModel *model = [[StrategyCollectionModel alloc] init];
        model.title = [rs stringForColumn:@"title"];
        model.itemId = [rs stringForColumn:@"itemId"];
        model.tourId = [rs stringForColumn:@"tourId"];
        model.url = [rs stringForColumn:@"url"];
        model.picUrl = [rs stringForColumn:@"picUrl"];
        model.subTitle = [rs stringForColumn:@"subTitle"];
        [strategyArray insertObject:model atIndex:0];
        [model release];
    }
    return strategyArray;
}

#pragma mark ------目的地详情--------
- (void)creatSightListListWithName{
    [[StrategyDataBase shareDataBase] connect];
    BOOL executeUpdate = [_dataBase executeUpdate:@"CREATE TABLE destination(ID TEXT PRIMARY KEY,name TEXT, photo TEXT,type TEXT)"];
    if (executeUpdate) {
        //NSLog(@"目的地建表成功");
    }else {
        //NSLog(@"目的地建表失败");
    }
    [_dataBase close];
}



- (void)insertModel:(SightModel *)sight{
    [[StrategyDataBase shareDataBase] connect];
    NSString *sql = [NSString stringWithFormat:@"insert into destination(ID, name, photo,type) values(?,?,?,?)"];
    BOOL executeUpdate = [_dataBase executeUpdate:sql,sight.ID, sight.name, sight.photo,sight.type];
    if (executeUpdate) {
        //NSLog(@"插入成功");
    }else
    {
        //NSLog(@"插入失败");
    }
    [_dataBase close];

}

- (NSMutableArray *)selectedAll {
    
    NSMutableArray *sightModelArr = [NSMutableArray array];
    [[StrategyDataBase shareDataBase] connect];
    NSString *sql = @"select *from destination";
    
    FMResultSet *rs = [_dataBase executeQuery:sql];
    while ([rs next]) {
        SightModel *sightModel = [[SightModel alloc] init];
        sightModel.ID = [rs stringForColumn:@"ID"];
        sightModel.name = [rs stringForColumn:@"name"];
        sightModel.photo = [rs stringForColumn:@"photo"];
        sightModel.type = [rs stringForColumn:@"type"];
        [sightModelArr addObject:sightModel];
        [sightModel release];
    }
    
    return sightModelArr;
}

- (void)deleteSightModelWithname:(NSString *)name{
[[StrategyDataBase shareDataBase] connect];
    NSString *sql = [NSString stringWithFormat:@"delete from destination where name = ?"];
    
    BOOL executeDelete = [_dataBase executeUpdate:sql, [NSString stringWithFormat:@"%@", name]];
    
    if (executeDelete) {
        //NSLog(@"删除成功");
        
    } else {
        //NSLog(@"删除失败");
    }

}

- (BOOL)isfavorite:(NSString *)name{
    [[StrategyDataBase shareDataBase] connect];
    NSString *sql = @"select * from destination where name = ?";
    FMResultSet *rs = [_dataBase executeQuery:sql,name];
    while ([rs next]) {
        NSString *rsId = [rs stringForColumn:@"name"];
        if ([rsId isEqualToString:name]) {
            [_dataBase close];
            return YES;
        }
    }
    [_dataBase close];
    return NO;
}



#pragma mark --------------- 游记和精彩故事 ----------------


- (void)createSqliteWithRecommend {
    [[StrategyDataBase shareDataBase] connect];
    BOOL executeUpdate = [_dataBase executeUpdate:@"CREATE TABLE Recommend(title TEXT PRIMARY KEY,spotID TEXT, ID TEXT, picUrl TEXT, content TEXT,time TEXT)"];
    if (executeUpdate) {
        //NSLog(@"推荐建表成功");
    }else {
        //NSLog(@"推荐建表失败");
    }
    [_dataBase close];
}

- (void)insertRecommendCollectWithModel:(EveryDayModel *)model travel:(TravelsModel *)travel soptID:(NSString *)spotID ID:(NSString *)ID picUrl:(NSString *)picUrl {
    
    [[StrategyDataBase shareDataBase] connect];
    
    BOOL insertData = NO;
    
    if (spotID) {
        NSString *sql = [NSString stringWithFormat:@"insert into Recommend(title, spotID, picUrl, content) values(?,?,?,?)"];
        insertData = [_dataBase executeUpdate:sql, model.name, spotID, model.cover_image_w640, model.text];
    } else if (ID){
        NSString *sql = [NSString stringWithFormat:@"insert into Recommend(title, ID, picUrl, time) values(?,?,?,?)"];
        insertData = [_dataBase executeUpdate:sql,travel.name, ID, picUrl, [travel.first_day stringByReplacingOccurrencesOfString:@"-" withString:@"."]];
    }
    
    if (insertData) {
        //NSLog(@"插入成功");
    } else {
        //NSLog(@"插入失败");
    }
    
    [_dataBase close];
    
}

- (NSMutableArray *)getAllRecommendCollecttion {
    
    NSMutableArray *recommendArr = [NSMutableArray array];
    [[StrategyDataBase shareDataBase] connect];
    NSString *sql = @"select * from Recommend";
    FMResultSet *rs = [_dataBase executeQuery:sql];
    while ([rs next]) {
        EveryDayModel *model = [[EveryDayModel alloc] init];
        model.name = [rs stringForColumn:@"title"];
        model.spot_id = [rs stringForColumn:@"spotID"];
        model.ID = [rs stringForColumn:@"ID"];
        model.cover_image_w640 = [rs stringForColumn:@"picUrl"];
        model.first_day = [rs stringForColumn:@"time"];
        model.text = [rs stringForColumn:@"content"];
        [recommendArr addObject:model];
        [model release];
    }
    return recommendArr;
}

- (void)deleteRecommendCollectionWithTitle:(NSString *)title spotId:(NSString *)spotId ID:(NSString *)ID {
    
    [[StrategyDataBase shareDataBase] connect];
    
    BOOL delete = NO;
    
    if (spotId) {
        delete = [_dataBase executeUpdate:@"delete from Recommend where spotID = ?", spotId];
    } else if (ID){
        delete = [_dataBase executeUpdate:@"delete from Recommend where ID = ?", ID];
    }
    if (delete) {
        //NSLog(@"删除成功");
    }else{
        //NSLog(@"删除失败");
    }
    [_dataBase close];
    
}

- (BOOL)isCollectRecommendWithTitle:(NSString *)title spotId:(NSString *)spotId ID:(NSString *)ID content:(NSString *)content {
    
    [[StrategyDataBase shareDataBase] connect];
    
    if (spotId) {
        
        NSString *sql = @"select * from Recommend where spotID = ?";
        FMResultSet *rs = [_dataBase executeQuery:sql, spotId];
        
        while ([rs next]) {
            
            NSString *rsItemId = [rs stringForColumn:@"spotID"];
            
            if ([rsItemId isEqualToString:spotId]) {
                [_dataBase close];
                //NSLog(@"已收藏");
                return YES;
            }
        }
    } else {
        NSString *sql = @"select * from Recommend where ID = ?";
        FMResultSet *rs = [_dataBase executeQuery:sql, ID];
        while ([rs next]) {
            NSString *rsTitle = [rs stringForColumn:@"ID"];
            if ([rsTitle isEqualToString:ID]) {
                [_dataBase close];
                //NSLog(@"已收藏");
                return YES;
            }
        }
    }

    [_dataBase close];
    return NO;
}

#pragma mark ------登录------
- (void)createSqliteWithLogin {
    [[StrategyDataBase shareDataBase] connect];
    BOOL executeUpdate = [_dataBase executeUpdate:@"CREATE TABLE LoginInfo(userID TEXT PRIMARY KEY, Name TEXT, isLogin INTEGER)"];
    if (executeUpdate) {
        //NSLog(@"推荐建表成功");
    }else {
        //NSLog(@"推荐建表失败");
    }
    [_dataBase close];
}

- (void)loginWithUserID:(NSString *)userID uerName:(NSString *)name{
    [[StrategyDataBase shareDataBase] connect];
    NSString *sql = [NSString stringWithFormat:@"insert into LoginInfo(userID, Name, isLogin) values(?,?,1)"];
    BOOL insertData = [_dataBase executeUpdate:sql, userID, name];

    if (insertData) {
        //NSLog(@"插入成功");
    } else {
        //NSLog(@"插入失败");
    }
    [_dataBase close];
}

- (BOOL)isLogin {
    [[StrategyDataBase shareDataBase] connect];
    NSString *sql = @"select isLogin from LoginInfo";
    FMResultSet *rs = [_dataBase executeQuery:sql];
    while ([rs next]) {
        BOOL rsIsLogin = [rs intForColumn:@"isLogin"];
        [_dataBase close];
        return rsIsLogin;
    }
    [_dataBase close];
    return NO;
}

- (void)logOut {
    [[StrategyDataBase shareDataBase] connect];
    NSString *sql = [NSString stringWithFormat:@"delete from LoginInfo where isLogin = 1"];
    BOOL executeDelete = [_dataBase executeUpdate:sql];
    if (executeDelete) {
        //NSLog(@"删除成功");
    }else{
        //NSLog(@"删除失败");
    }
    [_dataBase close];
}

- (NSString *)getUserID {
    [[StrategyDataBase shareDataBase] connect];
    NSString *sql = @"select userID from LoginInfo";
    FMResultSet *rs = [_dataBase executeQuery:sql];
    while ([rs next]) {
        NSString *userID = [rs stringForColumn:@"userID"];
        return userID;
    }
    return nil; 
}

- (NSString *)getUserName {
    [[StrategyDataBase shareDataBase] connect];
    NSString *sql = @"select Name from LoginInfo";
    FMResultSet *rs = [_dataBase executeQuery:sql];
    while ([rs next]) {
        NSString *userName = [rs stringForColumn:@"Name"];
        return userName;
    }
    return nil;
}

- (void)createSqliteGuider {
    [[StrategyDataBase shareDataBase] connect];
    BOOL executeUpdate = [_dataBase executeUpdate:@"CREATE TABLE guide(firstGuide INTEGER)"];
    if (executeUpdate) {
        //NSLog(@"引导标识建表成功");
    }else {
        //NSLog(@"引导标识建表失败");
    }
    NSString *sql = [NSString stringWithFormat:@"insert into guide(firstGuide) values(1)"];
    BOOL insertData = [_dataBase executeUpdate:sql];
    
    if (insertData) {
        //NSLog(@"插入成功");
    } else {
        //NSLog(@"插入失败");
    }
    [_dataBase close];
}

- (BOOL)isFirstGuide{
    [[StrategyDataBase shareDataBase] connect];
    NSString *sql = @"select firstGuide from guide";
    FMResultSet *rs = [_dataBase executeQuery:sql];
    while ([rs next]) {
        BOOL rsIsLogin = [rs intForColumn:@"firstGuide"];
        if (rsIsLogin == 1) {
            [_dataBase close];
            return NO;;
        }
    }
    [_dataBase close];
    return YES;
}

- (void)deleteAllCollection {
    [[StrategyDataBase shareDataBase] connect];
    BOOL executeDelete = [_dataBase executeUpdate:@"delete from strategy"];
    [_dataBase executeUpdate:@"delete from Recommend"];
    [_dataBase executeUpdate:@"delete from destination"];
    
    if (executeDelete) {
        //NSLog(@"删除成功");
    }else{
        //NSLog(@"删除失败");
    }
    [_dataBase close];
    
    [self createSqliteStrategy];
    [self createSqliteWithRecommend];
    [self creatSightListListWithName];
}

@end
