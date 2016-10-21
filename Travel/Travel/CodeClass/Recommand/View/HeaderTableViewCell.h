//
//  HeaderTableViewCell.h
//  Travel
//
//  Created by 申浩光 on 15/9/24.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTableViewCell : UITableViewCell
@property (nonatomic, retain) UILabel *totalText;
- (void)setValueWithText:(NSString *)text;
@end
