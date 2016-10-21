//
//  GalleryViewController.m
//  Travel
//
//  Created by lanou on 15/9/24.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "GalleryViewController.h"
#import "ZRecodModel.h"

@interface GalleryViewController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, retain) UIView *navigationBarView;
@property (nonatomic, retain) UIProgressView *progressView;
@end

@implementation GalleryViewController

- (void)dealloc
{
    Block_release(_bolck);
    [_progressView release];
    [_navigationBarView release];
    [_galleryView release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加滚动相册
    [self setUpGalleyScrollView];
    
    //添加进度条
    [self addProgressView];
    
    //导航条
    [self setBacBtn];
    // Do any additional setup after loading the view.
}

#pragma mark ------添加scrollView------
- (void)setUpGalleyScrollView{
    
    //相册主体
    _galleryView = [[GalleryScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth , kHeight) imgArray:self.dataArr target:self currentIndex:self.currentIndex];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bacBtn)];
    [_galleryView addGestureRecognizer:tap];
    [tap release];
    
    
    [self.view addSubview:_galleryView];
}



- (void)addProgressView{
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.frame = CGRectMake(20, kHeight - 64, kWidth - 40, 1);
    _progressView.tintColor = [UIColor whiteColor];
    _progressView.trackTintColor = [UIColor grayColor];
    _progressView.progress = (self.currentIndex + 1) / self.dataArr.count;
    [self.view addSubview:_progressView];
}

float contentX = 0;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    contentX = scrollView.contentOffset.x;
//    NSLog(@"开始拖拽时的坐标%f", contentX);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //滑动改变进度条
    if (scrollView.contentOffset.x > contentX) {
        self.currentIndex +=1;
    }else if(scrollView.contentOffset.x < contentX){
        self.currentIndex -=1;
    }
    _progressView.progress = (self.currentIndex + 1) / self.dataArr.count;
    
    
    //判断滑动方向
    if (scrollView.contentOffset.x / kWidth == 2) { //滑到下一张
        [_galleryView scrollToNextPic];
    }else if(scrollView.contentOffset.x / kWidth == 0){ //滑到前一张
        [_galleryView scrollToLastPic];
    }
    


}

- (void)setBacBtn {
    _navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    //_navigationBarView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_navigationBarView];
    
    //顶部返回按钮
    UIButton *bacBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    bacBtn.frame = CGRectMake(10, 24, 35, 35);
    bacBtn.tintColor = kBrownColor;
    [bacBtn setImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:UIControlStateNormal];
    [bacBtn addTarget:self action:@selector(bacBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bacBtn];
    
    UILabel *naviTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 190.0 / kAutoWidth, 35)];
    naviTitle.font = [UIFont boldSystemFontOfSize:18];
    naviTitle.text = self.photoTitle;
    naviTitle.textAlignment = NSTextAlignmentCenter;
    naviTitle.center = CGPointMake(kWidth / 2, bacBtn.center.y);
    naviTitle.textColor = kBrownColor;
    [_navigationBarView addSubview:naviTitle];
    [naviTitle release];
}

//返回上一级界面
- (void)bacBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.bolck(_progressView.progress * self.dataArr.count - 1);
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
