//
//  SearchDetailTableViewCell.h
//  Travel
//
//  Created by 申浩光 on 15/10/8.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultModel.h"
@interface SearchDetailTableViewCell : UITableViewCell

@property (nonatomic, retain) UIView *backView;
@property (nonatomic, retain) UIImageView *showImg;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *dateLabel;
- (void)setValueWithModel:(SearchResultModel *)model;
@end
