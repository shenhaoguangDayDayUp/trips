//
//  PathView.h
//  Travel
//
//  Created by lanou on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PathView : UIView
@property (nonatomic, retain) UILabel *name1;
@property (nonatomic, retain) UILabel *name2;
@property (nonatomic, retain) UILabel *name3;
@property (nonatomic) CGFloat length;

- (instancetype)initWithFrame:(CGRect)frame nameArray:(NSArray *)array;

@end
