//
//  TravelsTableViewCell.h
//  Travel
//
//  Created by 申浩光 on 15/9/25.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaysModel.h"
#import "DateModel.h"
@interface TravelsTableViewCell : UITableViewCell

@property (nonatomic, retain) UIView *backView;
@property (nonatomic, retain) UIImageView *showImg;
@property (nonatomic, retain) UIImageView *lineImg;
@property (nonatomic, retain) UIImageView *buttomImg;
@property (nonatomic, retain) UIImageView *arrowImg;
@property (nonatomic, retain) UIImageView *clockImg;
@property (nonatomic, retain) UILabel *showLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UILabel *date;

- (void)setValueWithModel:(DaysModel *)model;

@end
