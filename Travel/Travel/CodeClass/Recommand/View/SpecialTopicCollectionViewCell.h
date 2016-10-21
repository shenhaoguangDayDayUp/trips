//
//  SpecialTopicCollectionViewCell.h
//  Travel
//
//  Created by 申浩光 on 15/9/19.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EveryDayModel.h"
#import "UserInfo.h"
@interface SpecialTopicCollectionViewCell : UICollectionViewCell

// 展示图片
@property (nonatomic, retain) UIImageView *showImgView;
// 展示游记标题
@property (nonatomic, retain) UILabel *titleLabel;
// 小竖线
@property (nonatomic, retain) UIView *lineView;
// 展示时间浏览人数（字符串拼接）
@property (nonatomic, retain) UILabel *timeLabel;
// 展示地点
@property (nonatomic, retain) UILabel *locationLabel;
// 展示作者头像
@property (nonatomic, retain) UIImageView *userImgView;
// 展示作者
@property (nonatomic, retain) UILabel *userLabel;
// 阴影
@property (nonatomic, retain) UIImageView *shadowImg;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

- (void)setValueWithModel:(EveryDayModel *)model user:(UserInfo *)user;

@end
