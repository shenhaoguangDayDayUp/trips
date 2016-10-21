//
//  TableScrollView.m
//  Travel
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "TableScrollView.h"

@implementation TableScrollView
- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame contentArr:(NSArray *)contentArr{
    self = [super initWithFrame:frame];
    if (self) {
        //设置scrollView
        self.contentSize = CGSizeMake(kWidth * 7, 0);
        self.pagingEnabled = YES;
        for (int i = 0; i < 7; i++) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0 + kWidth * i, 0, kWidth, kHeight - 64 - 30) style:UITableViewStylePlain];
            //_tableView.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
            _tableView.tag = 2000 + i;

            [self addSubview:_tableView];
        }
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
