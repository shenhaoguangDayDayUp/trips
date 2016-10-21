//
//  Lcityimageview.h
//  Travel
//
//  Created by lanou3g on 15/9/20.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "TapimageView.h"
#import "CountryModel.h"
@interface Lcityimageview : TapimageView
@property (nonatomic,retain) UILabel *likeLabel;
@property (nonatomic,retain) UILabel *beenLabel;
//城市名
@property (nonatomic,retain) UILabel *nameLabel;
//喜欢的人数
@property (nonatomic,retain) UILabel *visited_countLabel;
//去过的人数
@property (nonatomic,retain) UILabel *wish_to_go_countLabel;



- (void)setupJsonModel:(CountryModel *)model;
-(instancetype)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action;
@end
