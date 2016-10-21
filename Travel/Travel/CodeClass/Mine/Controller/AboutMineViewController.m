//
//  AboutMineViewController.m
//  Travel
//
//  Created by 申浩光 on 15/10/5.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "AboutMineViewController.h"

@interface AboutMineViewController ()

@end

@implementation AboutMineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.996 green:0.915 blue:0.825 alpha:1.000];
    self.navigationItem.title = @"服务条款";
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_nav_back_button"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickBack)];
    backBtn.tintColor = [UIColor colorWithRed:0.886 green:0.2588 blue:0.3411 alpha:1];
    self.navigationItem.leftBarButtonItem = backBtn;
    [backBtn release];
    
    [self setUpAboutMine];
}


-(void)setUpAboutMine {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:kBounds];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor colorWithRed:0.882 green:0.839 blue:0.729 alpha:0.500];
    
    UIImageView *iconImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, 100, 100))];
    iconImg.center = CGPointMake(kWidth / 2, 80.0 / kAutoWidth);
    iconImg.layer.masksToBounds = YES;
    iconImg.layer.cornerRadius = 20.0 / kAutoWidth;
    iconImg.image = [UIImage imageNamed:@"iconImg"];
    [scrollView addSubview:iconImg];
    [iconImg release];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:(CGRectMake(20, iconImg.frame.origin.y + iconImg.bounds.size.height + 40.0 / kAutoWidth, kWidth - 40.0 / kAutoWidth, 10))];
    title.text = @"版本信息";
    title.textColor = [UIColor grayColor];
    [scrollView addSubview:title];
    [title release];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:(CGRectMake(20, title.frame.origin.y + title.bounds.size.height + 15.0 / kAutoWidth, kWidth - 40, 10))];
    label1.textColor = [UIColor grayColor];
    label1.text = @"    氢旅适用于iOS8.0及以上系统的设备。";
    label1.numberOfLines = 0;
    [label1 sizeToFit];
    [scrollView addSubview:label1];
    [label1 release];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:(CGRectMake(20, label1.frame.origin.y + label1.bounds.size.height + 30.0 / kAutoWidth, kWidth - 40, 10))];
    label2.textColor = [UIColor grayColor];
    label2.text = @"免责声明";
    [scrollView addSubview:label2];
    [label2 release];
    
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:(CGRectMake(20, label2.frame.origin.y + label2.bounds.size.height + 10.0 / kAutoWidth, kWidth - 40, 10))];
    label3.textColor = [UIColor grayColor];
    label3.text = @"    1.一切移动客户端用户在下载并使用本软件时均被视为已经仔细阅读本条款并完全同意。凡以任何方式登陆本软件，或直接、间接使用本APP资料者，均被视为自愿接受本声明和用户服务协议的约束。\n\n    2.本软件使用完全免费，手机由于上网而产生的GPRS流量费用由运营商收取。\n\n    3.本软件转载的内容并不代表本软件之意见及观点，也不意味着软件作者赞同其观点或证实其内容的真实性。\n\n    4.本软件所转载的文字、图片、音视频等内容均由互联网收集，对其真实性、准确性和合法性本软件不提供任何保证，也不承担任何法律责任。如有真实性、准确性和合法性存在问题的内容，请联系开发者及时删除相关内容。\n\n     5.本软件所转载的文字、图片、音视频等内容均由互联网自动收集，如侵犯了第三方的知识产权或其他权利，请联系开发者删除相关内容，本软件对此不承担任何法律责任。\n\n   6.本软件不保证为向用户提供便利而设置的外部链接的准确性和完整性，同时，对于该外部链接指向的不由本软件实际控制的任何网页上的内容，本软件不承担任何责任。\n\n     7.用户明确并同意其使用本软件网络服务所存在的风险将完全由其本人承担；因其使用本软件网络服务而产生的一切后果也由其本人承担，本软件对此不承担任何责任。\n\n   8.除本软件注明之服务条款外，其它因不当使用本APP而导致的任何意外、疏忽、合约毁坏、诽谤、版权或其他知识产权侵犯及其所造成的任何损失，本软件概不负责，亦不承担任何法律责任。\n\n   9.对于因不可抗力或因黑客攻击、通讯线路中断等本软件不能控制的原因造成的网络服务中断或其他缺陷，导致用户不能正常使用本软件，本软件不承担任何责任，但将尽力减少因此给用户造成的损失或影响。\n\n   10.本声明未涉及的问题请参见国家有关法律法规，当本声明与国家有关法律法规冲突时，以国家法律法规为准。\n\n   11.本软件版权及其修改权、更新权和最终解释权均属本软件开发者所有。";
    label3.numberOfLines = 0;
    [label3 sizeToFit];
    [scrollView addSubview:label3];
    [label3 release];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:(CGRectMake(20, label3.frame.origin.y + label3.bounds.size.height + 30 / kAutoWidth, kWidth - 40, 10))];
    label4.textColor = [UIColor grayColor];
    label4.text = @"联系我们";
    [scrollView addSubview:label4];
    [label4 release];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:(CGRectMake(20, label4.frame.origin.y + label4.bounds.size.height + 15.0 / kAutoWidth, kWidth - 40, 10))];
    label5.textColor = [UIColor grayColor];
    label5.text = @"邮箱: hydrogenteam@163.com";
    [scrollView addSubview:label5];
    [label5 release];
    
    
    scrollView.contentSize = CGSizeMake(0, label5.frame.origin.y + label5.bounds.size.height + 20);
    [scrollView release];
}



- (void)clickBack {
    [self.navigationController popViewControllerAnimated:YES];
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
