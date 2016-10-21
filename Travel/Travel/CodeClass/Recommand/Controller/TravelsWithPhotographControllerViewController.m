//
//  TravelsWithPhotographControllerViewController.m
//  Travel
//
//  Created by 申浩光 on 15/9/26.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "TravelsWithPhotographControllerViewController.h"
#import "PhotoScrollView.h"
@interface TravelsWithPhotographControllerViewController ()

@property (nonatomic, retain) UIProgressView *progressView;
@property (nonatomic, retain) PhotoScrollView *photoView;
@end

@implementation TravelsWithPhotographControllerViewController

- (void)dealloc {
    [_progressView release];
    [_daysArr release];
    Block_release(_block);
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSrcollView];
    [self addProgressView];

}

- (void)setUpSrcollView {
    
    _photoView = [[PhotoScrollView alloc] initWithFrame:kBounds imgArray:self.daysArr target:self currentIndex:self.currentIndex];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bacBtn)];
    [_photoView addGestureRecognizer:tap];
    [tap release];
    [self.view addSubview:_photoView];
    [_photoView release];

}

- (void)addProgressView{
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.frame = CGRectMake(20, kHeight - 64, kWidth - 40, 1);
    _progressView.tintColor = [UIColor whiteColor];
    _progressView.trackTintColor = [UIColor grayColor];
    _progressView.progress = (self.currentIndex + 1) / self.daysArr.count;
    [self.view addSubview:_progressView];
}

float contentXP = 0;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    contentXP = scrollView.contentOffset.x;
    //NSLog(@"开始拖拽时的坐标%f", contentXP);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView.tag == 100000) {
        //滑动改变进度条
        if (scrollView.contentOffset.x > contentXP) {
            self.currentIndex += 1;
        }else if(scrollView.contentOffset.x < contentXP){
            self.currentIndex -= 1;
        }
        _progressView.progress = (self.currentIndex + 1) / self.daysArr.count;
        
        
        //判断滑动方向
        if (scrollView.contentOffset.x / kWidth == 2) { //滑到下一张
            [_photoView scrollToNextPic];
        }else if(scrollView.contentOffset.x / kWidth == 0){ //滑到前一张
            [_photoView scrollToLastPic];
        }
    }
    
}


- (void)bacBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.block(_progressView.progress * self.daysArr.count - 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
