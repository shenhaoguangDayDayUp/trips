//
//  StoryScrollView.h
//  Travel
//
//  Created by 申浩光 on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryScrollView : UIScrollView

// 作者
@property (nonatomic, retain) UILabel *userLabel;

// 标题
@property (nonatomic, retain) UILabel *titleLabel;

// 日期
@property (nonatomic, retain) UILabel *date;
@property (nonatomic, retain) UILabel *dateShow;

// 行程
@property (nonatomic, retain) UILabel *journeyday;
@property (nonatomic, retain) UILabel *journeyShow;

// 地点故事
@property (nonatomic, retain) UILabel *story;
@property (nonatomic, retain) UILabel *storyShow;

// 时间
@property (nonatomic, retain) UILabel *time;

// 四根线
@property (nonatomic, retain) UIImageView *Tline;
@property (nonatomic, retain) UIImageView *Bline;
@property (nonatomic, retain) UIView *Lline;
@property (nonatomic, retain) UIView *Rline;

// 开头的一段
@property (nonatomic, retain) UILabel *toContent;

// 展示图片
@property (nonatomic, retain) UIImageView *showImg;

// 图片描述
@property (nonatomic, retain) UILabel *showLabel;


@end
