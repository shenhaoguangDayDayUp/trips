//
//  StoryTableViewCell.h
//  Travel
//
//  Created by 申浩光 on 15/9/24.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailList.h"
@interface StoryTableViewCell : UITableViewCell
@property (nonatomic, retain) UIImageView *showImg;
@property (nonatomic, retain) UILabel *showLabel;
- (void)setValueWithModel:(DetailList *)model;
@end
