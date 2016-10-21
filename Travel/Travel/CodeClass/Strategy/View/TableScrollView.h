//
//  TableScrollView.h
//  Travel
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableScrollView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic, retain) UITableView *tableView;

- (instancetype)initWithFrame:(CGRect)frame contentArr:(NSArray *)contentArr;

@end
