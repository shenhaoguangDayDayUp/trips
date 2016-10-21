//
//  AuthorInfoView.h
//  Travel
//
//  Created by lanou on 15/9/22.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDetailModel.h"
@interface AuthorInfoView : UIView
@property (nonatomic, retain) UIImageView *authorIcon;
@property (nonatomic, copy) UILabel *title;
@property (nonatomic, copy) UILabel *authorInfo;
@property (nonatomic, copy) UILabel *date;
@property (nonatomic, copy) UILabel *tags;

- (void)setUpViewWithDetailModel:(ZDetailModel *)model;
@end
