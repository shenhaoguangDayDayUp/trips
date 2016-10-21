//
//  GalleryScrollView.m
//  Travel
//
//  Created by lanou on 15/9/25.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "GalleryScrollView.h"
#import "ZRecodModel.h"
@implementation GalleryScrollView

- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)imgArray target:(id)target currentIndex:(NSInteger)currentIndex {
    self.currentIdx = currentIndex;
    self.imgArr = imgArray;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.contentSize = CGSizeMake(kWidth * 3, kHeight);
        self.delegate = target;
        self.pagingEnabled = YES;
        

        //只生成3个scrollview，只要一直显示的是中间那一张，就可以左右滑动了。
        for (int i = 0; i < 3; i++) {
            //小scrollView
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, kHeight)];
            scrollView.delegate = self;
            scrollView.tag = 1200 + i;
            scrollView.maximumZoomScale = 1.5;
            scrollView.minimumZoomScale = 1;
            scrollView.contentSize = CGSizeMake(kWidth, kHeight);
            
            //scrollView上面的图片
            ZRecodModel *model = nil;
            if (currentIndex == 0) {//判断是否是第一张照片
                model = imgArray[currentIndex+ i];
                self.contentOffset = CGPointMake(0, 0);
                
            }else if(currentIndex == imgArray.count - 1){//判断是否是最后一张照片
                model = imgArray[currentIndex - 2 + i];
                self.contentOffset = CGPointMake(kWidth * 2, 0);
            }else{
                model = imgArray[currentIndex  - 1 + i];
                self.contentOffset = CGPointMake(kWidth, 0);
            }
            
            //计算图片高度
            float picH = 0;
            if (![model.picw isEqualToString:@"0"]) {
                picH = kWidth * [model.pich floatValue] / [model.picw floatValue];
                if (picH > 260.0 / kAutoHight) {
                    picH = 260.0 / kAutoHight;
                }
            }
            //NSLog(@"%f", picH);
            
            //贴图
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, picH)];
            //img.backgroundColor = [UIColor redColor];
            img.tag = 2000 + i;
            img.center = CGPointMake(kWidth / 2, kHeight / 2);
            [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.117go.com/timg/p750/%@", model.picfile]] placeholderImage:[UIImage imageNamed:@"empty_content@2x"]];
            img.contentMode = UIViewContentModeScaleAspectFill;
            [scrollView addSubview:img];
            [img release];
            [self addSubview:scrollView];
            [scrollView release];
            
            //文字介绍
            UIScrollView *labelScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20.0 / kAutoWidth, 64 + 30 , kWidth - 40.0 / kAutoWidth, kHeight - 64 - 30 - 74) ];
            //labelScrollView.backgroundColor = [UIColor blueColor];
            labelScrollView.delegate = self;
            labelScrollView.bounces = NO;
            labelScrollView.tag = 20000 + i;
            UILabel *words = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelScrollView.bounds.size.width, 20)];
            words.numberOfLines = 0;
            words.tag = 11100 + i;
            words.font = [UIFont systemFontOfSize:15];
            //words.backgroundColor = [UIColor redColor];
            words.textColor = [UIColor whiteColor];
            words.text = model.words;
            [words sizeToFit];
            
            labelScrollView.frame = CGRectMake(20.0 / kAutoWidth, kHeight - 195.0 / kAutoHight , words.bounds.size.width, 110.0 / kAutoHight);
            labelScrollView.contentSize = CGSizeMake(0, words.bounds.size.height );

            CGRect frame = labelScrollView.frame;
            frame.origin.x = frame.origin.x + kWidth * i;
            labelScrollView.frame = frame;
            
            labelScrollView.showsVerticalScrollIndicator = NO;
            [labelScrollView addSubview:words];
            [words release];
            
            [self addSubview:labelScrollView];
            [labelScrollView release];
            
        }
        
        
    }
    return self;
}


//滑动到前一张照片----------特殊情况在于第一张照片和最后一张照片，下面的两个方法的前面都是用来排除特殊情况
- (void)scrollToLastPic{
    if (self.currentIdx > 1) {
        self.currentIdx -= 1;
        if (self.currentIdx == self.imgArr.count - 2) {
            self.currentIdx = self.imgArr.count - 3;
        }
        //NSLog(@"%ld", (long)self.currentIdx);
        for (int i = 0; i < 3; i++) {
            ZRecodModel *model = self.imgArr[self.currentIdx - 1 + i];
            [self setSCrollViewWithIndex:i model:model];
            
        }
        self.contentOffset = CGPointMake(kWidth, 0);//保持中间的照片始终显示在屏幕上
    }
}
//滑动到下一张照片
- (void)scrollToNextPic{
    if (self.currentIdx < self.imgArr.count - 2) {
        self.currentIdx += 1;
        if (self.currentIdx == 1) {
            self.currentIdx = 2;
        }
        
        
        for (int i = 0; i < 3; i++) {
            ZRecodModel *model = self.imgArr[self.currentIdx - 1 + i];
            [self setSCrollViewWithIndex:i model:model];
        }
        self.contentOffset = CGPointMake(kWidth, 0);//保持中间的照片始终显示在屏幕上
    }
}

//根据i值和model设置scorllView上面的照片和文字
- (void)setSCrollViewWithIndex:(int)i model:(ZRecodModel *)model {
    //重置缩放
    UIScrollView *scrollView = (UIScrollView *)[self viewWithTag:1200 + i];
    scrollView.zoomScale = 1.0;
    
    //计算图片高度
    float picH = 0;
    if (![model.picw isEqualToString:@"0"]) {
        picH = kWidth * [model.pich floatValue] / [model.picw floatValue];
        if (picH > 260.0 / kAutoHight) {
            picH = 260.0 / kAutoHight;
        }
    }
    
    UIImageView *img = (UIImageView *)[self viewWithTag:2000 + i];
    CGRect picFrame = img.frame;
    picFrame.size.height = picH;
    img.frame = picFrame;
    
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.117go.com/timg/p750/%@", model.picfile]] placeholderImage:[UIImage imageNamed:@"empty_content@2x"]];
    
    UILabel *words = (UILabel *)[self viewWithTag:11100 + i];
    CGRect frame = words.frame;
    frame.size.width = kWidth - 40.0 / kAutoWidth;
    words.frame = frame;
    words.text = model.words;
    [words sizeToFit];
    
    //自适应高度之后重新设置labelscrollview的高度和滚动范围
    UIScrollView *labelScrollView = (UIScrollView *)[self viewWithTag:20000 + i];
    CGRect lframe = labelScrollView.frame;
    lframe.size.width = words.bounds.size.width;
    labelScrollView.frame = lframe;
    labelScrollView.contentSize = CGSizeMake(0, words.bounds.size.height );
    

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    NSArray *array = scrollView.subviews;
    return array[0];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
