//
//  StoryDetailViewController.m
//  Travel
//
//  Created by 申浩光 on 15/9/21.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "StoryDetailViewController.h"
#import "StoryDetailScrollView.h"
#import "DetailList.h"
#import "EveryDayModel.h"
#import "UserInfo.h"
#import "StoryViewController.h"
#import "StrategyDataBase.h"
#import "LoginViewController.h"
#import "UMSocial.h"
typedef void (^ChangeCollecColor)(void);

@interface StoryDetailViewController () <UIScrollViewDelegate, UITextFieldDelegate, UMSocialUIDelegate>

@property (nonatomic, retain) StoryDetailScrollView *storyDetail;
@property (nonatomic, retain) UIImageView *backView;
@property (nonatomic, retain) NSMutableArray *detailArr;
@property (nonatomic, retain) EveryDayModel *everyModel;
@property (nonatomic, retain) UserInfo *user;
@property (nonatomic, retain) UIView *navigationBar;
//@property (nonatomic, retain) UIView *commentView;
@property (nonatomic, retain) UIView *line;
@property (nonatomic, copy) ChangeCollecColor changeCollectionColor;

@end

@implementation StoryDetailViewController

- (void)dealloc {
    Block_release(_refreshCollectionBlock);
    [_storyDetail release];
    [_spot_id release];
    [_backView release];
    [_detailArr release];
//   [_commentView release];
    [_navigationBar release];
    [_user release];
    [_everyModel release];
    [_line release];
    [_picUrl release];
    [_content release];
    [_name release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[StrategyDataBase shareDataBase] createSqliteWithRecommend];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self reloadDetailData];
    [self setUpDetailView];
}

#pragma mark --------------- 数据解析 ----------------
- (void)reloadDetailData {
    [LORequestManger GET:[NSString stringWithFormat:kWonderfulUrl, self.spot_id] success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        for (NSDictionary *detail_list in dic[@"data"][@"spot"][@"detail_list"]) {
            DetailList *detalModel = [DetailList shareJasonWithdictionary:detail_list];
            [self.detailArr addObject:detalModel];
        }
        
        self.everyModel = [EveryDayModel shareJsonWithDictionary:dic[@"data"][@"spot"]];
        [_everyModel setValuesForKeysWithDictionary:dic[@"data"][@"trip"]];
        [_everyModel setValuesForKeysWithDictionary:dic[@"data"][@"spot"][@"region"]];
        self.user = [UserInfo shareJasonWithDictionary:dic[@"data"][@"trip"][@"user"]];
        [self reloadDetailView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@", error);
    }];
    
}

#pragma mark --------------- 懒加载 ----------------
- (NSMutableArray *)detailArr {
    if (!_detailArr) {
        _detailArr = [[NSMutableArray alloc] init];
    }
    return _detailArr;
}

#pragma mark --------------- 刷新数据后的视图 ----------------
- (void)reloadDetailView {
    [_storyDetail setValuesWithModel:_everyModel userInfo:_user];
    [_storyDetail setUpShowContent:self.detailArr target:self action:(@selector(tapNext))];
    [_storyDetail setValuesWithModel:_everyModel userInfo:_user];
    [_backView sd_setImageWithURL:[NSURL URLWithString:_everyModel.cover_image_1600] placeholderImage:[UIImage imageNamed:@"trip_edit_cover_default"]];
}

#pragma mark --------------- 视图搭建 ----------------

- (void)setUpDetailView {
    _backView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, kWidth, kHeight + 64))];
    _backView.userInteractionEnabled = YES;
    _backView.image = [UIImage imageNamed:@"IMG_0871.JPG"];
    [self.view addSubview:_backView];
    
    _storyDetail = [[StoryDetailScrollView alloc] initWithFrame:(CGRectMake(0, 0, kWidth, kHeight)) target:self action:@selector(tapNext)];
    _storyDetail.delegate = self;
    [_backView addSubview:_storyDetail];
    
    _navigationBar = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, kWidth, 64))];
    _navigationBar.backgroundColor = kBackColor;
    _navigationBar.alpha = 0;
    [self.view addSubview:_navigationBar];
    
    _line = [[UIView alloc] initWithFrame:(CGRectMake(0, 64, kWidth, 1))];
    _line.backgroundColor = [UIColor grayColor];
    _line.alpha = 0;
    [self.view addSubview:_line];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:(CGRectMake(15, 35, kWidth - 30, 15))];
    title.font = [UIFont systemFontOfSize:18.0];
    title.text = @"地点故事";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = kPinkColor;
    [_navigationBar addSubview:title];
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBtn.frame = CGRectMake(15, 30, 28, 28);
    [backBtn setImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:(UIControlStateNormal)];
    [backBtn setTintColor:kBrownColor];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    shareBtn.frame = CGRectMake(kWidth - 15 - 35, 30, 25, 25);
    [shareBtn setImage:[UIImage imageNamed:@"tripview_share_highlight"] forState:(UIControlStateNormal)];
    [shareBtn setTintColor:kBrownColor];
    [shareBtn addTarget:self action:@selector(clickShare) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:shareBtn];
    
    UIButton *collectBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    collectBtn.frame = CGRectMake(shareBtn.frame.origin.x - 15 - 25, 30, 25, 25);
    [collectBtn setImage:[UIImage imageNamed:@"like_13x12_hl"] forState:(UIControlStateNormal)];
    [collectBtn setTintColor:kBrownColor];
    [collectBtn addTarget:self action:@selector(clickCollect) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:collectBtn];

    self.changeCollectionColor = ^(void) {
        
        if ([[StrategyDataBase shareDataBase] isCollectRecommendWithTitle:self.name spotId:self.spot_id ID:nil content:self.content]) {
            [collectBtn setTintColor:kPinkColor];
        } else {
            [collectBtn setTintColor:kBrownColor];
        }
    };
    if ([[StrategyDataBase shareDataBase] isLogin]) {
        self.changeCollectionColor();
    }
    
    UIImageView *detailBtn = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - 30.0 / kAutoWidth, - 110.0 / kAutoWidth, 10, 15)];
    detailBtn.image = [UIImage imageNamed:@"poi_arrow_icon@2x"];
    [_storyDetail addSubview:detailBtn];
    [detailBtn release];
    
//    _commentView = [[UIView alloc] initWithFrame:(CGRectMake(0, kHeight - 70 / kAutoHight, kWidth, 70 / kAutoHight))];
//    _commentView.backgroundColor = kBackColor;
//    _commentView.alpha = 0;
//    [self.view addSubview:_commentView];
//    
//    UIView *line = [[UIView alloc] initWithFrame:(CGRectMake(0, 20, 0.5, _commentView.bounds.size.height - 40))];
//    line.center = CGPointMake(kWidth / 2, _commentView.bounds.size.height / 2);
//    line.backgroundColor = [UIColor blackColor];
//    [_commentView addSubview:line];
//    
//    UILabel *likeL = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, kWidth / 2, 10))];
//    likeL.center = CGPointMake(kWidth / 2 / 2, _commentView.bounds.size.height / 2);
//    likeL.text = @"有3人喜欢";
//    likeL.textAlignment = NSTextAlignmentCenter;
//    likeL.font = [UIFont systemFontOfSize:14.0];
//    [_commentView addSubview:likeL];
//    
//    UILabel *commentL = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, kWidth / 2, 10))];
//    commentL.center = CGPointMake(kWidth / 2 + kWidth / 2 / 2, _commentView.bounds.size.height / 2);
//    commentL.text = @"有0人评论";
//    commentL.textAlignment = NSTextAlignmentCenter;
//    commentL.font = [UIFont systemFontOfSize:14.0];
//    [_commentView addSubview:commentL];
    
    [title release];
//    [line release];
//    [likeL release];
//    [commentL release];
    
}

- (void)clickShare {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.everyModel.cover_image]];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55fd0ce3e0f55a305b002070"
                                      shareText:[NSString stringWithFormat:@"我在氢旅看到一篇有趣的游记，地址在http://web.breadtrip.com/btrip/spot/%@",self.everyModel.spot_id]
                                     shareImage:[UIImage imageWithData:data]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToSms,UMShareToDouban,UMShareToEmail,nil]
                                       delegate:self];
}

- (void)clickCollect {
    if ([[StrategyDataBase shareDataBase] isLogin]) {

        [self finishCollect];
        
    } else {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        //登录之后执行
        loginVC.loginBlock = ^(void){
            
            if ([[StrategyDataBase shareDataBase] isCollectRecommendWithTitle:self.name spotId:self.spot_id ID:nil content:self.content]) {//如果已经收藏过，只改变收藏按钮颜色
                self.changeCollectionColor();
                
            }else{//没收藏过
                [self finishCollect];
            }
        };
        [self presentViewController:loginVC animated:YES completion:nil];
        [loginVC release];
        
    }
}

// 收藏功能
- (void)finishCollect {
    
    if ([[StrategyDataBase shareDataBase] isCollectRecommendWithTitle:self.name spotId:self.spot_id ID:nil content:self.content]) {
        [[StrategyDataBase shareDataBase] deleteRecommendCollectionWithTitle:self.name spotId:self.spot_id ID:nil];
    }else{
        
        [[StrategyDataBase shareDataBase] insertRecommendCollectWithModel:self.everyModel travel:nil soptID:self.spot_id ID:nil picUrl:nil];
    };
    self.changeCollectionColor();
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    _commentView.alpha = 1;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = _storyDetail.contentOffset.y;
//    _commentView.alpha = 0;
    if (y >= 0) {
        _navigationBar.alpha = y / 260.0;
        _line.alpha = 0.3;
        
    } else if (y <= 0) {
        _navigationBar.alpha = 0;
        _line.alpha = 0;
    }
}
- (void)tapNext {
    StoryViewController *storyVC = [[StoryViewController alloc] init];
    storyVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    storyVC.text = _everyModel.text;
    storyVC.name = _everyModel.name;
    storyVC.userName = _user.name;
    storyVC.avatar_l = _user.avatar_l;
    storyVC.photo = _everyModel.cover_image_1600;
    storyVC.detailArr = _detailArr;
    storyVC.date_added = _everyModel.date_added;
    storyVC.dayCout = _everyModel.day_count;
    storyVC.storyCount = _everyModel.comments_count;
    [self presentViewController:storyVC animated:YES completion:nil];
    [storyVC release];
}

#pragma mark --------------- 返回上一级页面 ----------------

- (void)clickBack {
    self.refreshCollectionBlock();
    
    
//    {
//        self.strategyArray = [[StrategyDataBase shareDataBase] allStrategyCollection];
//        [self.tableView reloadData];
//    };

    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
