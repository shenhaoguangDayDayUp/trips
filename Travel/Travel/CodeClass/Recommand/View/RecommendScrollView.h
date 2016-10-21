//
//  RecommendScrollView.h
//  Travel
//
//  Created by 申浩光 on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateModel.h"
@interface RecommendScrollView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSMutableArray *)imageArr delegate:(id)delegate action:(SEL)action timer:(NSTimeInterval)timer selector:(SEL)selector;

@end
