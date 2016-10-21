//
//  LocationViewController.m
//  Travel
//
//  Created by lanou on 15/9/20.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LocationViewController.h"

#import "LocationModel.h"
#import "PathView.h"
#import "DetailCollectionViewCell.h"
#import "LocationCollectionReusableView.h"
#import "StrategyModel.h"
#import "ZDtailViewController.h"
#import "MJRefreshFooterView.h"
#define kPicHeight 300.0 / 667 * kHeight



@interface LocationViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate,UINavigationBarDelegate>
@property (nonatomic, retain) NSMutableArray *pathArray;  //标题下方的一排标识
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) LocationModel *locationModel;
@property (nonatomic, retain) NSMutableArray *strategyDataArr;
@property (nonatomic, retain) UIView *navigationBarView;
@property (nonatomic, copy) NSString *startCount;
@property (nonatomic, retain) UIVisualEffectView *BlurView;
@end

@implementation LocationViewController


- (void)dealloc
{
    [_BlurView release];
    [_navigationBarView release];
    [_strategyDataArr release];
    [_locationName release];
    [_model release];
    [_pathArray release];
    [_zoomImageView release];
    [_itemId release];
    [_collectionView release];
    [_scrollView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startCount = @"0";
    
    [self addNavigationbar];
    self.view.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUpData];
    [self setUpSrategyData];

}

#pragma mark ------添加假NavigationBar------

- (void)addNavigationbar{
    //假navigationBar
    _navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    _navigationBarView.backgroundColor = kBackColor;
    _navigationBarView.layer.shadowColor = [[UIColor blackColor] CGColor];
    [self.view addSubview:_navigationBarView];
    _navigationBarView.alpha = 0;
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
    
    UILabel *naviTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 190.0 / kAutoWidth, 35)];
    naviTitle.font = [UIFont boldSystemFontOfSize:18];
    naviTitle.text = self.model.name;
    naviTitle.textAlignment = NSTextAlignmentCenter;
    naviTitle.center = CGPointMake(kWidth / 2, bacBtn.center.y);
    naviTitle.textColor = kPinkColor;
    [_navigationBarView addSubview:naviTitle];
    [naviTitle release];
    
}

//返回上一级界面
- (void)bacBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ------解析数据------

- (NSMutableArray *)pathArray {
    if (!_pathArray) {
        _pathArray = [[NSMutableArray alloc] init];
    }
    return _pathArray;
}

- (NSMutableArray *)strategyDataArr {
    if (!_strategyDataArr) {
        _strategyDataArr = [[NSMutableArray alloc] init];
    }
    return _strategyDataArr;
}
- (void)setUpSrategyData {
    if (![_model.type isEqualToNumber:@3] ) {
         NSString *url = [NSString stringWithFormat:kStrategy2Url, self.itemId];
        [LORequestManger GET:url success:^(id response) {
            NSDictionary *dict = (NSDictionary *)response;
            for (NSDictionary *dic in dict[@"obj"][@"list"]) {
                StrategyModel *model = [StrategyModel setStrategyModelWithDic:dic];
                [self.strategyDataArr addObject:model];
                [self.collectionView reloadData];
            }
            ////NSLog(@"%@", dict);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //NSLog(@"%@", error);
        }];
    }else{
        NSString *url = [NSString stringWithFormat:kStrategyUrl, self.itemId];
        [LORequestManger GET:url success:^(id response) {
            NSDictionary *dict = (NSDictionary *)response;
            for (NSDictionary *dic in dict[@"obj"][@"list"]) {
                StrategyModel *model = [StrategyModel setStrategyModelWithDic:dic];
                [self.strategyDataArr addObject:model];
                [self.collectionView reloadData];
            }
            ////NSLog(@"%@", dict);navigationbar 透明 按钮不透明
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //NSLog(@"%@", error);
        }];
        
    }
    
}


//解析热门推荐地数据
- (void)setUpData {
    if ([_model.upid isEqualToNumber:@0]) {
        NSString *url = [NSString stringWithFormat:kLocationCountry, self.itemId];
        [LORequestManger GET:url success:^(id response) {
            NSDictionary *dict = (NSDictionary *)response;
            self.locationModel = [LocationModel setModelWithDic:dict[@"obj"][@"head"][@"locality"]];
            ////NSLog(@"%@", self.locationModel);
            for (NSDictionary *dic in dict[@"obj"][@"head"][@"locality"][@"path"]) {
                [self.pathArray addObject:dic[@"dispname"]];
            }
            [self setUpCollectionView];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //NSLog(@"%@", error);
        }];
    }else{
        NSString *url = [NSString stringWithFormat:kLocationUrl, self.itemId];
        [LORequestManger GET:url success:^(id response) {
            NSDictionary *dict = (NSDictionary *)response;
            self.locationModel = [LocationModel setModelWithDic:dict[@"obj"][@"scenery"]];
            
            for (NSDictionary *dic in dict[@"obj"][@"scenery"][@"path"]) {
                [self.pathArray addObject:dic[@"dispname"]];
            }
            [self setUpCollectionView];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //NSLog(@"%@", error);
        }];
    }
}

- (void)setUpCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kWidth - 30) / 2, kWidth / 1.8);
    layout.sectionInset = UIEdgeInsetsMake(10, 10.0, 10, 10);
    //layout.minimumLineSpacing = 10;
    layout.headerReferenceSize = CGSizeMake(kWidth, 46.0 / kAutoHight);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) collectionViewLayout:layout];
    [layout release];
    
    _collectionView.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //_collectionView.bounces = NO;
    //_collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(kPicHeight, 0, 0, 0);
    
    [_collectionView registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    [_collectionView registerClass:[LocationCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myHeader"];
    
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, - kPicHeight, kWidth, kHeight + kPicHeight)];
    _scrollView.contentSize = CGSizeMake(0, kHeight);
    
    [_scrollView addSubview:_collectionView];
    _scrollView.contentInset = UIEdgeInsetsMake(kPicHeight, 0, 0, 0);
    _scrollView.delegate = self;
    
    _scrollView.contentOffset = CGPointMake(0, -kPicHeight);
    
    [self.view insertSubview:_scrollView belowSubview:_navigationBarView];
    //[self.view addSubview:_scrollView];


    
    _zoomImageView = [[UIImageView alloc]init];
    [_zoomImageView sd_setImageWithURL:[NSURL URLWithString:_coverPic] placeholderImage:[UIImage imageNamed:@"trip_edit_empty_content"]];
    _zoomImageView.clipsToBounds = YES;
    _zoomImageView.frame = CGRectMake(0, -kPicHeight, self.view.frame.size.width, kPicHeight);
    //_zoomImageView.backgroundColor = [UIColor redColor];
    //contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
    _zoomImageView.contentMode = UIViewContentModeScaleAspectFill;//重点（不设置那将只会被纵向拉伸）
    [_collectionView addSubview:_zoomImageView];
    
    _BlurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    
    CGRect frame = _zoomImageView.bounds;
    frame.size.height = 600;
    _BlurView.frame = frame;
    
    _BlurView.alpha = 0.62;
    [_zoomImageView addSubview:_BlurView];
    
    _locationName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    _locationName.text = self.model.name;
    _locationName.textColor = [UIColor colorWithWhite:1.000 alpha:0.860];
    _locationName.font = [UIFont boldSystemFontOfSize:23];
    [_locationName sizeToFit];
    _locationName.shadowColor = [UIColor blackColor];
    _locationName.shadowOffset = CGSizeMake(0.8, 0.8);
    _locationName.center = CGPointMake(kWidth / 2,  180.0 / kAutoHight);
    [_zoomImageView addSubview:_locationName];

    
    
    
    PathView *pathView = [[PathView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) nameArray:self.pathArray];
    CGRect rect = CGRectMake(0, 0, pathView.length, 30);
    pathView.frame = rect;
    pathView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    pathView.center = CGPointMake(kWidth / 2, 220.0 / kAutoHight);
    //pathView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    [_zoomImageView addSubview:pathView];
    [pathView release];
    
    
    [self addPullUpWithColletionView];
}

//添加上拉加载
- (void)addPullUpWithColletionView {
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = _collectionView;

    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {


        if (![_model.type isEqualToNumber:@3] ) {
            self.startCount = [NSString stringWithFormat:@"%d", [self.startCount integerValue] + 12] ;

            NSString *url = [NSString stringWithFormat:kStrategy2UrlP, self.startCount, self.itemId];
            [LORequestManger GET:url success:^(id response) {
                NSDictionary *dict = (NSDictionary *)response;
                for (NSDictionary *dic in dict[@"obj"][@"list"]) {
                    StrategyModel *model = [StrategyModel setStrategyModelWithDic:dic];
                    [self.strategyDataArr addObject:model];
                    [self.collectionView reloadData];
                }
                [footer endRefreshing];
                ////NSLog(@"%@", dict);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //NSLog(@"%@", error);
            }];
        }else{
            self.startCount = [NSString stringWithFormat:@"%ld", [self.startCount integerValue] + 12] ;
            NSString *url = [NSString stringWithFormat:kStrategyUrlP, self.startCount, self.itemId];
            [LORequestManger GET:url success:^(id response) {
                NSDictionary *dict = (NSDictionary *)response;
                for (NSDictionary *dic in dict[@"obj"][@"list"]) {
                    StrategyModel *model = [StrategyModel setStrategyModelWithDic:dic];
                    [self.strategyDataArr addObject:model];
                    [self.collectionView reloadData];
                }
                [footer endRefreshing];

                ////NSLog(@"%@", dict);navigationbar 透明 按钮不透明
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //NSLog(@"%@", error);
            }];
        }
    };
}

#pragma mark ------collectionView代理方法------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.strategyDataArr.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    LocationCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myHeader" forIndexPath:indexPath];
    return headerView;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    [cell setCellWithModel:self.strategyDataArr[indexPath.row]];
    return cell;
}

//实现顶部图片放大效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    if (y < -kPicHeight) {
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _zoomImageView.frame = frame;
        //_BlurView.frame = _zoomImageView.bounds;
        CGFloat alpha = (100.0 / kAutoHight - (-y - 300.0 /kAutoHight)) / 160.0 / kAutoHight;
        _BlurView.alpha = alpha;
        
        //NSLog(@"%f",alpha);
    }
    
    if (y >= -63 && y <= 37 ) {
        //NSLog(@"%f", y);
        self.navigationBarView.alpha = (y + 63 )/ 100;
    }else if (y < -63) {
        self.navigationBarView.alpha = 0;
    }else{
         self.navigationBarView.alpha = 1;
    }
    
    
}

#pragma mark ------点击事件------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZDtailViewController *strategyVC = [[ZDtailViewController alloc] init];
    strategyVC.locationTitle = self.model.name;
    strategyVC.itemId = self.model.itemid;
    strategyVC.tourId = [self.strategyDataArr[indexPath.row] tourId];
    strategyVC.hidesBottomBarWhenPushed = YES;
    strategyVC.refreshCollectionBlock = ^(void){
        //NSLog(@"回调无效");
    };
    [self presentViewController:strategyVC animated:YES completion:nil];
    [strategyVC release];
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
