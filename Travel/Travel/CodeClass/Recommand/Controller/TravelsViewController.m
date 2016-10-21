//
//  TravelsViewController.m
//  Travel
//
//  Created by 申浩光 on 15/9/25.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "TravelsViewController.h"
#import "TravelsModel.h"
#import "UserInfo.h"
#import "TravelsTableViewCell.h"
#import "DaysModel.h"
#import "TravelsWithPhotographControllerViewController.h"
#import "DateModel.h"
#import "StrategyDataBase.h"
#import "LoginViewController.h"
#import "UMSocial.h"
typedef void (^ChangeCollecColor)(void);
@interface TravelsViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UMSocialUIDelegate>

@property (nonatomic, retain) NSMutableArray *travelsArr;
@property (nonatomic, retain)  NSMutableArray *daysArr;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIButton *bacTopBtn;
@property (nonatomic, retain) UserInfo *user;
@property (nonatomic, retain) TravelsModel *travel;
@property (nonatomic, retain) DateModel *dateModel;
@property (nonatomic, copy) ChangeCollecColor changeCollectionColor;

@end

@implementation TravelsViewController

- (void)dealloc {
    [_tableView release];
    [_travel release];
    [_travelsArr release];
    [_daysArr release];
    [_bacTopBtn release];
    Block_release(_refreshCollectionBlock);
    Block_release(_changeCollectionColor);
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadTravelsData];
    [self setUpTableView];
    self.navigationItem.title = @"精彩游记";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:kPinkColor,NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    [[StrategyDataBase shareDataBase] createSqliteWithRecommend];
}

- (void)reloadTravelsData {
    //NSLog(@"%@",[NSString stringWithFormat:kJounaryUrl, self.ID]);
    [LORequestManger GET:[NSString stringWithFormat:kJounaryUrl, self.ID] success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        self.travel = [TravelsModel shareJsonWithDictionary:dic];
        self.user = [UserInfo shareJasonWithDictionary:dic[@"user"]];
        for (NSDictionary *days in dic[@"days"]) {
            for (NSDictionary *waypoints in days[@"waypoints"]) {
                DaysModel *model = [DaysModel shareJsonWithDictionary:days];
                [model setValuesForKeysWithDictionary:waypoints];
                [self.daysArr addObject:model];
            }
        }
        [self.tableView reloadData];
        [self setUpHeaderView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@", error);
    }];
    
}

#pragma mark --------------- 懒加载 ----------------

- (NSMutableArray *)daysArr {
    if (!_daysArr) {
        _daysArr = [[NSMutableArray alloc] init];
    }
    return _daysArr;
}

// 设置tableView的属性
- (void)setUpTableView {
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_new_poi_back_btn"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    backBtn.tintColor = kBrownColor;
    self.navigationItem.leftBarButtonItem = backBtn;
    
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tripview_share_highlight"] style:(UIBarButtonItemStylePlain) target:self action:@selector(share)];
    shareBtn.tintColor = kBrownColor;
    
    UIBarButtonItem *likeBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"like_13x12_hl"] style:(UIBarButtonItemStylePlain) target:self action:@selector(like)];
    likeBtn.tintColor = kBrownColor;
    self.changeCollectionColor = ^(void) {
        
        if ([[StrategyDataBase shareDataBase] isCollectRecommendWithTitle:self.name spotId:nil ID:[NSString stringWithFormat:@"%@", self.ID] content:nil]) {
            [likeBtn setTintColor:kPinkColor];
        } else {
            [likeBtn setTintColor:kBrownColor];
        }
    };
    
    if ([[StrategyDataBase shareDataBase] isLogin]) {
        self.changeCollectionColor();
    }
    
    
    self.navigationItem.rightBarButtonItems = @[shareBtn, likeBtn];
    
    self.tableView = [[[UITableView alloc] initWithFrame:kBounds style:(UITableViewStylePlain)] autorelease];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20.0 / kAutoWidth, 0);
    _tableView.backgroundColor = kBackColor;
    _tableView.separatorStyle = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[TravelsTableViewCell class] forCellReuseIdentifier:@"travelCell"];
    [self setBacToTopBtn];

    
    [backBtn release];
    [shareBtn release];
    [likeBtn release];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
    self.refreshCollectionBlock();
}

#pragma mark ------添加返回顶部按钮------
- (void)setBacToTopBtn {
    
    
    //返回顶部按钮
    self.bacTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bacTopBtn.frame = CGRectMake(kWidth - 60 - 20, kHeight - 40 - 20, 40, 40);
    self.bacTopBtn.alpha = 0;
    [self.bacTopBtn setBackgroundImage:[UIImage imageNamed:@"ic_bactoTop"] forState:UIControlStateNormal];
    [self.bacTopBtn addTarget:self action:@selector(bacToTopBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bacTopBtn];
    
}

- (void)bacToTopBtn {

    [self.tableView setContentOffset:CGPointMake(0, - 64) animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    if (y >= kHeight) {
        [UIView animateWithDuration:0.5 animations:^{
            self.bacTopBtn.alpha = 0.5;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.bacTopBtn.alpha = 0;
        }];
    }
}

- (void)share {
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.travel.cover_image]];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55fd0ce3e0f55a305b002070"
                                      shareText:[NSString stringWithFormat:@"我在氢旅看到一篇有趣的游记，快来围观~http://web.breadtrip.com/trips/%@", self.travel.ID]
                                     shareImage:[UIImage imageWithData:data]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToSms,UMShareToDouban,UMShareToEmail,nil]
                                       delegate:self];
    
}

- (void)like {
    
    if ([[StrategyDataBase shareDataBase] isLogin]) {

        [self finishCollect];
        
    } else {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        //登录之后执行
        loginVC.loginBlock = ^(void){
            
            if ([[StrategyDataBase shareDataBase] isCollectRecommendWithTitle:self.name spotId:nil ID:[NSString stringWithFormat:@"%@", self.ID] content:nil]) {//如果已经收藏过，只改变收藏按钮颜色
                self.changeCollectionColor();
                
            }else{//没收藏过
                [self finishCollect];
            }
        };
                 
        [self presentViewController:loginVC animated:YES completion:nil];
        [loginVC release];
    }
    
}

- (void)finishCollect {
    if ([[StrategyDataBase shareDataBase] isCollectRecommendWithTitle:self.name spotId:nil ID:[NSString stringWithFormat:@"%@", self.ID] content:nil]) {
        [[StrategyDataBase shareDataBase] deleteRecommendCollectionWithTitle:self.name spotId:nil ID:[NSString stringWithFormat:@"%@", self.ID]];
    }else{
        [[StrategyDataBase shareDataBase] insertRecommendCollectWithModel:nil travel:self.travel soptID:nil ID:[NSString stringWithFormat:@"%@", self.ID] picUrl:self.picUrl];
    };
    self.changeCollectionColor();
}


// 设置表头
- (void)setUpHeaderView {
    // 设置表头
    UIView *headerView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, kWidth, 420.0 / kAutoHight))];
    headerView.backgroundColor = kBackColor;
    
    UIImageView *headerImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, kWidth, 200.0 / kAutoHight))];
    headerImg.backgroundColor = [UIColor redColor];
    headerImg.contentMode = UIViewContentModeScaleAspectFill;
    [headerImg sd_setImageWithURL:[NSURL URLWithString:_travel.trackpoints_thumbnail_image] placeholderImage:[UIImage imageNamed:@"poi_bg_placeholder@2x"]];
    [headerView addSubview:headerImg];
    
    UIImageView *userImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, 80.0 / kAutoHight, 80.0 / kAutoHight))];
    userImg.center = CGPointMake(kWidth / 2, headerImg.bounds.size.height);
    userImg.layer.masksToBounds = YES;
    userImg.layer.borderColor = [kBackColor CGColor];
    userImg.layer.cornerRadius = userImg.bounds.size.height / 2;
    userImg.layer.borderWidth = 3;
    [userImg sd_setImageWithURL:[NSURL URLWithString:_user.avatar_l] placeholderImage:nil];
    [headerImg addSubview:userImg];
    
    UILabel *userLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, headerImg.bounds.size.height + userImg.bounds.size.height / 2 + 15, kWidth - 20, 15))];
    userLabel.text = [NSString stringWithFormat:@"by %@", _user.name];
    userLabel.font = [UIFont systemFontOfSize:13.0];
    userLabel.textAlignment = NSTextAlignmentCenter;
    userLabel.textColor = [UIColor grayColor];
    [headerView addSubview:userLabel];
    
    UILabel *title = [[UILabel alloc] initWithFrame:(CGRectMake(10, userLabel.frame.origin.y + userLabel.bounds.size.height + 25, kWidth - 20, 15))];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = _travel.name;
    title.font = [UIFont boldSystemFontOfSize:20.0];
    [headerView addSubview:title];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:(CGRectMake(50, title.frame.origin.y + title.bounds.size.height + 25, kWidth - 100, 0.5))];
    line.image = [UIImage imageNamed:@"poi_seperator_line"];
    [headerView addSubview:line];
    
    UIImageView *Lline = [[UIImageView alloc] initWithFrame:(CGRectMake((kWidth - 100) / 3.0 + 50, line.frame.origin.y + line.bounds.size.height + 10, 0.5, 35))];
    Lline.image = [UIImage imageNamed:@"user_info_follow_separator"];
    [headerView addSubview:Lline];
    
    UIImageView *Rline = [[UIImageView alloc] initWithFrame:(CGRectMake((kWidth - 100) * 2 / 3.0 + 50, line.frame.origin.y + line.bounds.size.height + 10, 0.5, 35))];
    Rline.image = [UIImage imageNamed:@"user_info_follow_separator"];
    [headerView addSubview:Rline];
    
    UILabel *date = [[UILabel alloc] initWithFrame:(CGRectMake(line.frame.origin.x, line.frame.origin.y + line.bounds.size.height + 10, (kWidth - 100) / 3.0, 10))];
    date.font = [UIFont systemFontOfSize:13.0];
    date.textAlignment = NSTextAlignmentCenter;
    date.text = [_travel.first_day stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    [headerView addSubview:date];
    
    UILabel *dayCount = [[UILabel alloc] initWithFrame:(CGRectMake(date.frame.origin.x, date.frame.origin.y + date.bounds.size.height + 10, (kWidth - 100) / 3.0, 10))];
    dayCount.font = [UIFont systemFontOfSize:13.0];
    dayCount.textAlignment = NSTextAlignmentCenter;
    dayCount.textColor = [UIColor grayColor];
    dayCount.text = [NSString stringWithFormat:@"%@天", _travel.day_count];
    [headerView addSubview:dayCount];
    
    UILabel *mileage = [[UILabel alloc] initWithFrame:(CGRectMake(Lline.frame.origin.x, date.frame.origin.y, (kWidth - 100) / 3.0, 10))];
    mileage.font = [UIFont systemFontOfSize:13.0];
    mileage.textAlignment = NSTextAlignmentCenter;
    mileage.text = @"里程";
    [headerView addSubview:mileage];
    
    UILabel *mileageShow = [[UILabel alloc] initWithFrame:(CGRectMake(mileage.frame.origin.x, dayCount.frame.origin.y, (kWidth - 100) / 3.0, 10))];
    mileageShow.font = [UIFont systemFontOfSize:13.0];
    mileageShow.textAlignment = NSTextAlignmentCenter;
    mileageShow.textColor = [UIColor grayColor];
    NSString *km = [NSString stringWithFormat:@"%@",_travel.mileage];
    CGFloat mile = [km floatValue];
    mileageShow.text = [NSString stringWithFormat:@"%.0fkm", mile];
    [headerView addSubview:mileageShow];
    
    UILabel *like = [[UILabel alloc] initWithFrame:(CGRectMake(Rline.frame.origin.x, date.frame.origin.y, (kWidth - 100) / 3.0, 10))];
    like.font = [UIFont systemFontOfSize:13.0];
    like.textAlignment = NSTextAlignmentCenter;
    like.text = @"喜欢";
    [headerView addSubview:like];
    
    UILabel *likeCount = [[UILabel alloc] initWithFrame:(CGRectMake(like.frame.origin.x, dayCount.frame.origin.y, (kWidth - 100) / 3.0, 10))];
    likeCount.font = [UIFont systemFontOfSize:13.0];
    likeCount.textAlignment = NSTextAlignmentCenter;
    likeCount.textColor = [UIColor grayColor];
    likeCount.text = [NSString stringWithFormat:@"%@", _travel.recommendations];
    [headerView addSubview:likeCount];
    
    _tableView.tableHeaderView = headerView;
    
    [likeCount release];
    [mileageShow release];
    [mileage release];
    [dayCount release];
    [date release];
    [Rline release];
    [Lline release];
    [line release];
    [like release];
    [title release];
    [userLabel release];
    [userImg release];
    [headerImg release];
    [headerView release];
}

#pragma mark --------------- tableView代理 ----------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.daysArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TravelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"travelCell" forIndexPath:indexPath];
    DaysModel *model = self.daysArr[indexPath.row];

    [cell setValueWithModel:model];
    
//    if (indexPath.row != 0) {
//        DaysModel *model1 = self.daysArr[indexPath.row - 1];
//        if ([model1.date isEqualToString:model.date]) {
//            cell.date.text = @"";
//        }
//    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    tap.delegate = self;
    cell.showImg.tag = indexPath.row;
    [cell.showImg addGestureRecognizer:tap];
    [tap release];
    
    return cell;
}

- (void)tapImage:(UIGestureRecognizer *)tap {
    TravelsWithPhotographControllerViewController *photoVC = [[TravelsWithPhotographControllerViewController alloc] init];
    photoVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    photoVC.daysArr = self.daysArr;
    photoVC.currentIndex = tap.view.tag;
    
    //block回调 使图片阅读进度可以对应起来
    photoVC.block = ^(NSInteger index){
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionBottom];
    };
    
    [self presentViewController:photoVC animated:YES completion:nil];
    [photoVC release];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DaysModel *model = self.daysArr[indexPath.row];
    if (model.photo_info != nil) {
        NSString *w = [NSString stringWithFormat:@"%@", model.photo_info[@"w"]];
        NSString *h = [NSString stringWithFormat:@"%@", model.photo_info[@"h"]];
        CGFloat imgHeight = (kWidth - 24) * [h floatValue] / [w floatValue];
        
        UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(12, imgHeight + 5, kWidth - 24, 15))];
        label.font = [UIFont systemFontOfSize:14.0];
        label.text = model.text;
        label.numberOfLines = 0;
        [label sizeToFit];
        
        CGFloat LHeight = label.frame.origin.y + label.bounds.size.height;
        [label release];
        return (30 + 5 + 15 + LHeight + 40);
        
    }else
    {
        return 370;
    }
    
    
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
