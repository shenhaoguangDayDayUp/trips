//
//  WonderfulStroyCollectionViewCell.h
//  Travel
//
//  Created by 申浩光 on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EveryDayModel.h"
#import "UserInfo.h"
#import "SightModel.h"
@interface WonderfulStroyCollectionViewCell : UICollectionViewCell
// 显示精彩图片
@property (nonatomic, retain) UIImageView *showImgView;
// 显示故事标题
@property (nonatomic, retain) UILabel *titleLabel;
// 显示用户头像
@property (nonatomic, retain) UIImageView *userImgView;
// 显示用户名
@property (nonatomic, retain) UILabel *userLabel;
// 白色背景图
@property (nonatomic, retain) UIImageView *backImgView;
// 地点
@property (nonatomic, retain) UILabel *loactionLabel;

//删除按钮
@property (nonatomic,retain) UIButton *deletebutton;

- (void)setValueWithModel:(EveryDayModel *)model user:(UserInfo *)user;
-(void)setupWithJson:(SightModel *)model;
@end
