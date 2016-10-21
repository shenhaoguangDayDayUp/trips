//
//  LdetallViewController.m
//  Travel
//
//  Created by lanou3g on 15/9/22.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LdetallViewController.h"
#import "UILabel+VerticalAlignment.h"
@interface LdetallViewController ()

@end

@implementation LdetallViewController
-(void)dealloc{
    [_str release];
    [super dealloc];
}
- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    UIImageView *image = [[UIImageView alloc] initWithFrame:kBounds];
    NSArray *arr = [self.photostr componentsSeparatedByString:@"?"];
    [image sd_setImageWithURL:[NSURL URLWithString:arr[0]]];
    image.userInteractionEnabled = YES;
    [self.view addSubview:image];
    UIVisualEffectView *backvisual = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    backvisual.frame = image.bounds;
    backvisual.alpha = 1.0;
    [image addSubview:backvisual];
    [backvisual release];
    [image release];
    
    UIButton *backbutton = [UIButton buttonWithType:(UIButtonTypeInfoLight)];
    backbutton.frame = CGRectMake(20.0/kAutoWidth, 20.0/kAutoHight, 30, 30);
    [backbutton setImage:[UIImage imageNamed:@"add_new_poi_back_btn"] forState:(UIControlStateNormal)];
    [backbutton addTarget:self action:@selector(backbutton) forControlEvents:(UIControlEventTouchUpInside)];
    backbutton.tintColor = kBrownColor;
    [image addSubview:backbutton];
    
    UILabel *strLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0/kAutoWidth, 64.0/kAutoHight, kWidth - (2*10.0/kAutoWidth), 500)];
    strLabel.font = [UIFont systemFontOfSize:15];
    strLabel.text = _str;
    strLabel.numberOfLines = 0;
    strLabel.textColor = [UIColor whiteColor];
    strLabel.verticalAlignment = NSVerticalAlignmentTop;
    [image addSubview:strLabel];
    [strLabel release];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)backbutton{
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
