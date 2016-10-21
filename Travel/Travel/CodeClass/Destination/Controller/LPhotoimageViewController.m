//
//  LPhotoimageViewController.m
//  Travel
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LPhotoimageViewController.h"
#import "Lphotoscrollview.h"
@interface LPhotoimageViewController ()<UIScrollViewDelegate>
@property Lphotoscrollview *bigscrollview;
@end

@implementation LPhotoimageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupcontrollect];
    // Do any additional setup after loading the view.
}
- (void)setupcontrollect{
    
    _bigscrollview = [[Lphotoscrollview alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) photoArray:self.array target:self index:self.count];
    [self.view addSubview:_bigscrollview];
    UIButton *backbutton = [UIButton buttonWithType:(UIButtonTypeInfoLight)];
    [backbutton addTarget:self action:@selector(backbutton) forControlEvents:(UIControlEventTouchUpInside)];
    backbutton.frame = CGRectMake(kWidth/(375/10.0), kHeight/(667/20.0), 30, 30);
    [backbutton setImage:[UIImage imageNamed:@"add_new_poi_back_btn"] forState:(UIControlStateNormal)];
    [self.view addSubview:backbutton];
    backbutton.tintColor = kBrownColor;
    [_bigscrollview release];

}
float contextX = 0;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    contextX = scrollView.contentOffset.x;
    //NSLog(@"开始拖动时的坐标%f",contextX);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //滑动改变进度条
    if (scrollView.contentOffset.x > contextX) {
        self.count +=1;
    }else if(scrollView.contentOffset.x < contextX){
        self.count -=1;
    }
    
//滑动判断方向
    if(scrollView.contentOffset.x/kWidth == 2 )
    {
        //NSLog(@"下一张");
        [_bigscrollview scrolltonextPic];
    }else if (scrollView.contentOffset.x / kWidth == 0){
        //NSLog(@"上一张");
        [_bigscrollview scrolltolastPic];
    }

}


- (void)backbutton{
    //NSLog(@"111");
    
    [self dismissViewControllerAnimated:NO completion:nil];

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
