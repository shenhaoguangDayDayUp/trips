//
//  ZDtailViewController.m
//  Travel
//
//  Created by lanou on 15/9/23.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "ZDtailViewController.h"
#import "AuthorInfoView.h"
#import "ZDetailModel.h"
#import "ZRecodModel.h"
#import "ZDetailTableViewCell.h"
#import "GalleryViewController.h"
#import "StrategyDataBase.h"

#import "LoginViewController.h"
#define kImgHeight  200.0 / kAutoHight
typedef void (^ChangeCollecColor)(void);
@interface ZDtailViewController ()<UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,UMSocialUIDelegate>
@property (nonatomic, retain) ZDetailModel *detailModel;
@property (nonatomic, retain) NSMutableArray *recordArray;
@property (nonatomic, retain) NSMutableArray *heights;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, retain) UIButton *bacTopBtn;
@property (nonatomic, retain) UIView *navigationBarView;
@property (nonatomic, copy) ChangeCollecColor changeCollectionColor;
@property (nonatomic, retain) UIVisualEffectView *BlurView;

@end

@implementation ZDtailViewController
- (void)dealloc
{
    [_BlurView release];
    Block_release(_changeCollectionColor);
    [_navigationBarView release];
    [_heights release];
    [_label release];
    [_recordArray release];
    [_zoomImageView release];
    [_tableView release];
    [_itemId release];
    [_tourId release];
    [_locationTitle release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavigationbar];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
    
    
    
    [self setUpData];
    
   
    
    // Do any additional setup after loading the view.
}


#pragma mark ------添加假NavigationBar------

- (void)addNavigationbar{
    //假navigationBar
    _navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    _navigationBarView.backgroundColor = kBackColor;
    _navigationBarView.alpha = 0;
    [self.view addSubview:_navigationBarView];
    UIImageView *naviShadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kWidth, 1)];
    naviShadow.alpha = 0.4;
    naviShadow.backgroundColor = [UIColor grayColor];
    
    [_navigationBarView addSubview:naviShadow];
    [naviShadow release];
    //顶部返回按钮
    UIButton *bacBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    bacBtn.frame = CGRectMake(10, 24, 35, 35);
    [bacBtn setImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:UIControlStateNormal];
    [bacBtn setTintColor:kBrownColor];
    [bacBtn addTarget:self action:@selector(bacBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bacBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    shareBtn.frame = CGRectMake(kWidth - 15 - 25, 30, 25, 25);
    [shareBtn setImage:[UIImage imageNamed:@"tripview_share_highlight"] forState:(UIControlStateNormal)];
    [shareBtn setTintColor:kBrownColor];
    [shareBtn addTarget:self action:@selector(clickShare) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:shareBtn];
    
    
    UIButton *collectBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    collectBtn.frame = CGRectMake(shareBtn.frame.origin.x - 15 - 25, 30, 25, 25);
    [collectBtn setImage:[UIImage imageNamed:@"like_13x12_hl"] forState:(UIControlStateNormal)];
    
    [collectBtn setTintColor:kBrownColor];
    self.changeCollectionColor = ^(void) {        
        if ([[StrategyDataBase shareDataBase] jugdeIsCollectedWithTitle:_detailModel.title ItemId:self.itemId tourId:self.tourId]) {
            [collectBtn setTintColor:kPinkColor];
        }else{
            [collectBtn setTintColor:kBrownColor];
        };
    };
    
    if ([[StrategyDataBase shareDataBase] isLogin]) {
        self.changeCollectionColor();
    }
    
    [collectBtn addTarget:self action:@selector(clickCollect) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:collectBtn];
    
    UILabel *naviTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 190.0 / kAutoWidth, 35)];
    naviTitle.font = [UIFont boldSystemFontOfSize:18];
    naviTitle.text = self.locationTitle;
    naviTitle.textAlignment = NSTextAlignmentCenter;
    naviTitle.center = CGPointMake(kWidth / 2, bacBtn.center.y);
    naviTitle.textColor = kPinkColor;
    [_navigationBarView addSubview:naviTitle];
    [naviTitle release];
    
    


}

#pragma mark ------点击事件------

//收藏
- (void)clickCollect {
    if ([[StrategyDataBase shareDataBase] isLogin]){
        [self clickAction];
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.loginBlock = ^(void){
            if ([[StrategyDataBase shareDataBase] jugdeIsCollectedWithTitle:_detailModel.title ItemId:self.itemId tourId:self.tourId]) {//如果已经收藏过，只改变收藏按钮颜色
                self.changeCollectionColor();
                
            }else{//没收藏过
                [self clickAction];
            }
        };
        
        [self presentViewController:loginVC animated:YES completion:nil];
        [loginVC release];
    }
}

- (void)clickAction {
    if ([[StrategyDataBase shareDataBase] jugdeIsCollectedWithTitle:_detailModel.title ItemId:self.itemId tourId:self.tourId]) {
        [[StrategyDataBase shareDataBase] deleteWebCollectionWithTitle:_detailModel.title ItemId:self.itemId tourId:self.tourId];
    }else{
        
        [[StrategyDataBase shareDataBase] insertStrategyCollectionWithTitle:_detailModel.title ZDetailModel:_detailModel itemId:self.itemId tourId:self.tourId url:nil picUrl:nil subTitle:nil];
    };
    self.changeCollectionColor();
}

//分享
- (void)clickShare {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.117go.com/timg/p750/%@", _detailModel.coverpic]]];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55fd0ce3e0f55a305b002070"
                                      shareText:[NSString stringWithFormat:@"我在氢旅发现了一篇很有意思的文章快来看看吧--%@", _detailModel.title]
                                     shareImage:[UIImage imageWithData:data]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToSms,UMShareToDouban,UMShareToEmail,nil]
                                       delegate:self];

}

//返回上一级界面
- (void)bacBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.refreshCollectionBlock();
}

//点击返回顶部
- (void)bacToTopBtn {
    [self.tableView setContentOffset:CGPointMake(0, -kImgHeight) animated:YES];
}

//点击图片
- (void)tapImg:(UITapGestureRecognizer *)tap{
    //NSLog(@"%ld",(long)tap.view.tag);
    GalleryViewController *galleryVC = [[GalleryViewController alloc] init];
    galleryVC.currentIndex = tap.view.tag;
    galleryVC.dataArr = self.recordArray;
    galleryVC.photoTitle = self.detailModel.title;
    //block回调 使图片阅读进度可以对应起来
    galleryVC.bolck = ^(NSInteger index){
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionBottom];
    };
    
    galleryVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:galleryVC animated:YES completion:nil];
    [galleryVC release];
}

#pragma mark ------解析数据------
- (NSMutableArray *)recordArray {
    if (!_recordArray) {
        _recordArray = [[NSMutableArray alloc] init];
        
    }
    return _recordArray;
}

- (NSMutableArray *)heights {
    if (!_heights) {
        _heights = [[NSMutableArray alloc] init];
    }
    return _heights;
}

- (void)setUpData {
    NSString *url = [NSString stringWithFormat:kDetailUrl, self.itemId, self.tourId];
    [LORequestManger GET:url success:^(id response) {
        NSDictionary *dict = (NSDictionary *)response;
        self.detailModel = [ZDetailModel setModelWithDic:dict[@"obj"]];
        //self.label = _detailModel.foreword;
        //NSLog(@"%@", _label);
        [self setUpImgAndTableView];
 
        for (NSDictionary *record in dict[@"obj"][@"records"]) {
            ZRecodModel *model = [ZRecodModel setModelWithDic:record];
            float picH = 0;
            if (![model.picw isEqualToString:@"0"]) {
                picH = (kWidth - 20.0 / kAutoWidth) * [model.pich floatValue] / [model.picw floatValue];
                if (picH > 260.0 / kAutoHight) {
                    picH = 260.0 / kAutoHight;
                }
            }
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth - 30.0 / kAutoWidth, 20)];
            label.text = model.words;
            label.font = [UIFont systemFontOfSize:15]; 
            label.numberOfLines = 0;
            [label sizeToFit];
            float height = picH + label.bounds.size.height + 35.0 / kAutoHight;
            [self.heights addObject:[NSString stringWithFormat:@"%f",height]];
            [self.recordArray addObject:model];
            [label release];
            [_tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@", error);
    }];
}

#pragma mark ------设置背景图片和tableView------
- (void)setUpImgAndTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = NO;
    _tableView.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
    [_tableView registerClass:[ZDetailTableViewCell class] forCellReuseIdentifier:@"myZDCell"];
    self.tableView.contentInset = UIEdgeInsetsMake(kImgHeight, 0, 49, 0);
    
    [self.view insertSubview:_tableView belowSubview:_navigationBarView];
 
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 50.0 / kAutoHight)];
    headerView.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
    UIView *bacView = [[UIView alloc] initWithFrame:CGRectMake(10.0 / kAutoWidth, 15.0 / kAutoHight, kWidth - 20.0 / kAutoWidth, 25.0 / kAutoHight)];
    bacView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5.0 / kAutoWidth, 10.0 / kAutoHight, kWidth - 30.0 / kAutoWidth, 20.0 / kAutoHight)];
    label.text = _detailModel.foreword;
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    [label sizeToFit];
    headerView.frame = CGRectMake(0, 0, kWidth, 40.0 / kAutoHight + label.bounds.size.height);
    bacView.frame = CGRectMake(10.0 / kAutoWidth, 25.0 / kAutoHight, kWidth - 20.0 / kAutoWidth, label.bounds.size.height + 15.0 / kAutoHight);
    [bacView addSubview:label];
    [label release];
    bacView.layer.masksToBounds = YES;
    bacView.layer.cornerRadius = 5.0;
    [headerView addSubview:bacView];
    [bacView release];
    
    _tableView.tableHeaderView = headerView;
    [headerView release];
    
    //底层缩放的图片
    _zoomImageView = [[UIImageView alloc] init];
    NSString *coverPicUrl = [NSString stringWithFormat:@"http://img.117go.com/timg/p750/%@", _detailModel.coverpic];
    
    [_zoomImageView sd_setImageWithURL:[NSURL URLWithString:coverPicUrl] placeholderImage:[UIImage imageNamed:@"trip_edit_empty_content"]];
        
    _zoomImageView.frame = CGRectMake(0, -kImgHeight, kWidth, kImgHeight);
    _zoomImageView.contentMode = UIViewContentModeScaleAspectFill; 
    [self.tableView addSubview:_zoomImageView];
    _zoomImageView.clipsToBounds = YES;
    _BlurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    
    CGRect frame = _zoomImageView.bounds;
    frame.size.height = 600;
    _BlurView.frame = frame;
    
    _BlurView.alpha = 1;
    [_zoomImageView addSubview:_BlurView];
    
    //攻略作者的信息 头像
    AuthorInfoView *authorView = [[AuthorInfoView alloc] initWithFrame:CGRectMake(20.0 / kAutoHight, 100.0 / kAutoHight, kWidth, 100.0 / kAutoHight)];
    [authorView setUpViewWithDetailModel:_detailModel];
    
    
    [_zoomImageView addSubview:authorView];
    [authorView release];
    
    
    _zoomImageView.autoresizesSubviews = YES;
    
    

    
    [self setBacToTopBtn];

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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y ;
    ////NSLog(@"%f", y);
    if (y < -kImgHeight) {
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _zoomImageView.frame = frame;
        
//        CGRect Bframe = _zoomImageView.bounds;
//        frame.size.height = frame.size.height + 100;
//        _BlurView.frame = Bframe;
        CGFloat alpha = (100.0 / kAutoHight - (-y - 200.0 /kAutoHight)) / 100.0 / kAutoHight;
        _BlurView.alpha = alpha;
        
        //NSLog(@"%f", alpha);
    }
    
    if (y >= 0) {
        self.navigationBarView.alpha = y/200.0;
    }else{
         self.navigationBarView.alpha = 0;
    }
    
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




#pragma mark ------tableview代理方法------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recordArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {    
    return [_heights[indexPath.row] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myZDCell" forIndexPath:indexPath];
    [cell setCellWithModel:_recordArray[indexPath.row]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImg:)];
    tap.delegate = self;
    cell.imgView.tag = indexPath.row;
    [cell.imgView addGestureRecognizer:tap];
    [tap release];
    return cell;
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
