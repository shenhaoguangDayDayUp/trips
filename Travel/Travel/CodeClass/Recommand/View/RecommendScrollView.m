//
//  RecommendScrollView.m
//  Travel
//
//  Created by 申浩光 on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "RecommendScrollView.h"
#import "EveryDayModel.h"
@implementation RecommendScrollView

- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSMutableArray *)imageArr delegate:(id)delegate action:(SEL)action timer:(NSTimeInterval)timer selector:(SEL)selector {
    self = [super initWithFrame:frame];
    if (self) {
        
        // 创建一个放轮播图的数组
        NSMutableArray *insertArr = [NSMutableArray arrayWithArray:imageArr];
        // 将imageArr的第一张图插到insertArr的最后一张
        [insertArr insertObject:imageArr[0] atIndex:imageArr.count];
        
        // 将imageArr的最后一张插入的insertArr的第一张
        [insertArr insertObject:imageArr[imageArr.count - 1] atIndex:0];
        
        // 设置scrollView的属性
        self.contentSize = CGSizeMake(kWidth * insertArr.count, 0);
        self.pagingEnabled = YES;
        self.bounces = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.contentOffset = CGPointMake(kWidth, 0);
        self.delegate = delegate;
        self.backgroundColor = [UIColor colorWithRed:0.882 green:0.839 blue:0.729 alpha:1.000];
        for (int i = 0; i < insertArr.count; i++) {
            EveryDayModel *model = insertArr[i];
            TapimageView *tapView = [[TapimageView alloc] initWithFrame:(CGRectMake(kWidth * i, 0, kWidth, self.bounds.size.height)) target:delegate action:action];
            tapView.backgroundColor = [UIColor colorWithRed:0.882 green:0.839 blue:0.729 alpha:1.000];
            tapView.contentMode = UIViewContentModeScaleAspectFill;
            [tapView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_1600] placeholderImage:[UIImage imageNamed:@"poi_bg_placeholder@2x"]];
            tapView.clipsToBounds = YES;
            tapView.contentMode = UIViewContentModeScaleAspectFill;
\
            UIImageView *coverPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"trip_edit_title_shadow"]];
            coverPic.frame = tapView.bounds;
            [tapView addSubview:coverPic];
            [coverPic release];
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15.0 / kAutoWidth, self.bounds.size.height - 70.0 / kAutoWidth, kWidth - 30.0 / kAutoWidth, 40)];
            //title.center = CGPointMake(kWidth / 2.5, self.bounds.size.height / 1.7);
            //title.textAlignment = NSTextAlignmentCenter;
            //title.backgroundColor = [UIColor blackColor];
            //title.alpha = 0.5;
            title.font = [UIFont systemFontOfSize:18.0];
            title.textColor = [UIColor whiteColor];
            title.text = model.name;
            [tapView addSubview:title];
            [title release];
            
            [self addSubview:tapView];
            [tapView release];
            
//            UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(15.0 / kAutoWidth, self.bounds.size.height - 90.0 / kAutoHight, 300, 5))];
//            label.text = @"❤️精彩游记大放送";
//            label.font = [UIFont systemFontOfSize:16.0];
//            label.textColor = [UIColor whiteColor];
//            [label sizeToFit];
//            [tapView addSubview:label];
//            [label release];
            
        }
        
        [NSTimer scheduledTimerWithTimeInterval:timer target:delegate selector:selector userInfo:nil repeats:YES];
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
