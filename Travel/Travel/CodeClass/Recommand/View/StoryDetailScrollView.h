//
//  StoryDetailScrollView.h
//  Travel
//
//  Created by 申浩光 on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailList.h"
#import "EveryDayModel.h"
#import "UserInfo.h"
@interface StoryDetailScrollView : UIScrollView
// 底部的米白色视图
@property (nonatomic, retain) UIView *showView;
// 总标题
@property (nonatomic, retain) UILabel *totitle;
// 故事标题
@property (nonatomic, retain) UILabel *title;
// 时间
@property (nonatomic, retain) UILabel *time;
// 作者头像
@property (nonatomic, retain) UIImageView *userImg;
// 内容图片
@property (nonatomic, retain) UIImageView *showImg;
// 内容
@property (nonatomic, retain) UILabel *showLabel;
// 开始的一段内容
@property (nonatomic, retain) UILabel *totalLabel;
// 下面链接的标题
@property (nonatomic, retain) UILabel *more;

// 收录故事小标题
@property (nonatomic, retain) UILabel *littleT;
- (void)setUpShowContent:(NSMutableArray *)array target:(id)target action:(SEL)action;
- (void)setValuesWithModel:(EveryDayModel *)every userInfo:(UserInfo *)user;
- (instancetype)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action;
@end
