//
//  RecommandViewController.m
//  Travel
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "RecommandViewController.h"
#import "RecommendScrollView.h"
#import "WonderfulStroyCollectionViewCell.h"
#import "RecommendCollectionReusableView.h"
#import "SpecialTopicCollectionViewCell.h"
#import "MoreStoryViewController.h"
#import "EveryDayModel.h"
#import "UserInfo.h"
#import "StoryDetailViewController.h"
#import "TravelsViewController.h"
#import "MJRefreshFooterView.h"
#import "MJRefreshHeaderView.h"
#import "DateModel.h"
#import "ScrollViewController.h"
#import "SearchBarViewController.h"
#import "SearchDetailViewController.h"
@interface RecommandViewController ()<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, MJRefreshBaseViewDelegate, UISearchBarDelegate, UISearchControllerDelegate,UISearchResultsUpdating>

{
    MJRefreshFooterView *_footer;
    MJRefreshHeaderView *_header;
}

// 创建collectionView
@property (nonatomic, retain) UICollectionView *collectionView;

// 设置轮播图
@property (nonatomic, retain) RecommendScrollView *scrollView;

// 设置pagecontol
@property (nonatomic, retain) UIPageControl *pageControl;

// 存放轮播图
@property (nonatomic, retain) NSMutableArray *imageArr;

// 存放everyDay信息的数组
@property (nonatomic, retain) NSMutableArray *everydayArr;

// 存放游记的数组
@property (nonatomic, retain) NSMutableArray *specialTopArr;

// 存放用户信息的数组
@property (nonatomic, retain) NSMutableArray *userinfoArr;

// 是否刷新数据

@property (nonatomic, retain) EveryDayModel *model;

@property (nonatomic, retain) NSNumber *next_start;

@property (nonatomic, retain) NSMutableArray *special;

@property (nonatomic, retain) NSMutableArray *scrollArr;

@property (nonatomic, retain) UISearchController *searchVC;


@end

@implementation RecommandViewController

- (void)dealloc {
    
    [_collectionView release];
//    [_footer free];
//    [_header free];
    [_scrollView release];
    [_pageControl release];
    [_specialTopArr release];
    [_everydayArr release];
    [_searchVC release];
    [_imageArr release];
    [_specialTopArr release];
    [_special release];
    [_userinfoArr release];
    [_scrollArr release];
    [_next_start release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self reloadDataWithEveryday];
    [self setUpRecommandView];
    [self refreshLoading];
}

- (void)reloadDataWithEveryday {
    
    [LORequestManger GET:kEverydayUrl success:^(id response) {
        NSDictionary *dict = (NSDictionary *)response;
        self.next_start = dict[@"next_start"];
        NSMutableArray *every = [NSMutableArray array];

        for (NSDictionary *dic in dict[@"elements"]) {
            if (![dic[@"type"] isEqualToNumber:@1] && ![dic[@"type"] isEqualToNumber:@11] && ![dic[@"type"] isEqualToNumber:@9] && ![dic[@"type"] isEqualToNumber:@7] && ![dic[@"type"] isEqualToNumber:@6] && ![dic[@"type"] isEqualToNumber:@5]) {
                for (NSDictionary *data in dic[@"data"]) {
                    
                    self.model = [EveryDayModel shareJsonWithDictionary:data];
                    
                    if ([dic[@"type"] isEqualToNumber:@10]) {
                        [self.everydayArr addObject:self.model];
                        UserInfo *userInfo = [UserInfo shareJasonWithDictionary:self.model.user];
                        [every addObject:userInfo];
                    } else if ([dic[@"type"] isEqualToNumber:@4]) {
                        [self.specialTopArr addObject:self.model];
                        UserInfo *userInfo = [UserInfo shareJasonWithDictionary:self.model.user];
                        [self.special addObject:userInfo];
                    }
                }
            }
            //else if ([dic[@"type"] isEqualToNumber:@1]) {
                //for (NSDictionary *data in dic[@"data"][0]) {
//                    DateModel *date = [DateModel shareJsonWithDictionary:data];
//                    [self.imageArr addObject:date.image_url];
//                    [self.scrollArr addObject:date];
                //}
            //}
        }
        for (int i = 0; i < 4; i++) {
            EveryDayModel *model = self.specialTopArr[i + 10];
            [self.imageArr addObject:model.cover_image_1600];
            [self.scrollArr addObject:model];
        }        
        [self.userinfoArr addObject:every];
        [self.userinfoArr addObject:self.special];
        [self.collectionView reloadData];
        [self setUpSrcollView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@", error);
    }];
}

#pragma mark --------------- 懒加载 ----------------

- (NSMutableArray *)everydayArr {
    if (!_everydayArr) {
        _everydayArr = [[NSMutableArray alloc] init];
    }
    return _everydayArr;
}

- (NSMutableArray *)specialTopArr {
    if (!_specialTopArr) {
        _specialTopArr = [[NSMutableArray alloc] init];
    }
    return _specialTopArr;
}

- (NSMutableArray *)userinfoArr {
    if (!_userinfoArr) {
        _userinfoArr = [[NSMutableArray alloc] init];
    }
    return _userinfoArr;
}

- (NSMutableArray *)special {
    if (!_special) {
        _special = [[NSMutableArray alloc] init];
    }
    return _special;
}

- (NSMutableArray *)imageArr {
    if (!_imageArr) {
        _imageArr = [[NSMutableArray alloc] init];
    }
    return _imageArr;
}

- (NSMutableArray *)scrollArr {
    if (!_scrollArr) {
        _scrollArr = [[NSMutableArray alloc] init];
    }
    return _scrollArr;
}


#pragma mark --------------- 搜索框 ----------------
- (void)setUpSearchBar {
    
    SearchBarViewController *searchBackVC = [[SearchBarViewController alloc] init];
    _searchVC = [[UISearchController alloc] initWithSearchResultsController:searchBackVC];
    _searchVC.searchBar.delegate = self;
    _searchVC.delegate = self;
    _searchVC.searchResultsUpdater = self;
    _searchVC.searchBar.barTintColor = kBackColor;
    _searchVC.searchBar.translucent = YES;
    _searchVC.searchBar.placeholder = @"搜索游记、目的地";
    [self presentViewController:_searchVC animated:YES completion:nil];
    [searchBackVC release];
}



#pragma mark UISearchBarDelegate

//搜索按键
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    SearchDetailViewController *searchDetailVC = [[SearchDetailViewController alloc] init];
    
    searchDetailVC.content = self.searchVC.searchBar.text;
    
    [_searchVC presentViewController:searchDetailVC animated:NO completion:nil];
    [searchDetailVC release];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    //NSLog(@"%@", self.searchVC.searchBar.text);
}

#pragma mark --------------- 设置推荐页面 ----------------

- (void)setUpRecommandView {

    // 设置collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:kBounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(200.0 / kAutoWidth, 0, 0, 0);
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[WonderfulStroyCollectionViewCell class] forCellWithReuseIdentifier:@"WonderfulCell"];
    [_collectionView registerClass:[RecommendCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"recommend"];
    [_collectionView registerClass:[SpecialTopicCollectionViewCell class] forCellWithReuseIdentifier:@"SpecialTop"];
   [layout release];
    
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"magnifier_searchbar"] style:(UIBarButtonItemStylePlain) target:self action:@selector(setUpSearchBar)];
    searchBtn.tintColor = kPinkColor;
    self.navigationItem.rightBarButtonItem = searchBtn;
    [searchBtn release];
}

- (void)setUpSrcollView {
    // 设置轮播图
    _scrollView = [[RecommendScrollView alloc] initWithFrame:(CGRectMake(0, -(200.0 / kAutoWidth), kWidth, 200.0 / kAutoWidth)) imageArr:self.scrollArr delegate:self action:@selector(actionTapImage) timer:3.5 selector:@selector(cirulrly)];
    [_collectionView addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:(CGRectMake(0, -35, kWidth, 30))];
    _pageControl.numberOfPages = self.imageArr.count;
    _pageControl.currentPage = 0;
    [_collectionView addSubview:_pageControl];
}

#pragma mark --------------- 轮播图的点击事件 ----------------

- (void)actionTapImage {
    NSInteger index = _scrollView.contentOffset.x / kWidth;
    index -= 1;
    if (index == self.imageArr.count) {
        index = 0;
    }
    
    TravelsViewController *travelVC = [[TravelsViewController alloc] init];
    travelVC.hidesBottomBarWhenPushed = YES;
    travelVC.ID = [self.scrollArr[index] ID];
    travelVC.picUrl = [self.scrollArr[index] cover_image_w640];
    travelVC.refreshCollectionBlock = ^(void) {
    };
    [self.navigationController pushViewController:travelVC animated:YES];
    [travelVC release];
}


#pragma mark --------------- 定时器添加事件 ----------------

- (void)cirulrly{
    
    CGPoint newPoint = _scrollView.contentOffset;
    newPoint.x += kWidth;
    
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = newPoint;
    } completion:^(BOOL finished) {
        [self setUpScrollViewWithCirulrly];
    }];
    
    
}

// 设置轮播图效果
- (void)setUpScrollViewWithCirulrly {
    if (_scrollView.contentOffset.x == kWidth * (self.imageArr.count + 1)) {
        _pageControl.currentPage = 0;
        [_scrollView setContentOffset:(CGPointMake(kWidth, 0)) animated:NO];
    } else if (_scrollView.contentOffset.x == 0) {
        [_scrollView setContentOffset:(CGPointMake(kWidth * self.imageArr.count, 0)) animated:NO];
        _pageControl.currentPage = 4;
    }
    
    int index = _scrollView.contentOffset.x / kWidth;
    _pageControl.currentPage = index - 1;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setUpScrollViewWithCirulrly];
    
}


#pragma mark --------------- collectionView代理 ----------------

// 返回分区数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
// 返回分区的行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.everydayArr.count == 0) {
            return 4;
        } else {
            return self.everydayArr.count;
        }
    } else {
        if (self.specialTopArr.count == 0) {
            return 10;
        } else {
            return self.specialTopArr.count;
        }
    }
}
// 设置collectionView的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        WonderfulStroyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WonderfulCell" forIndexPath:indexPath];
        if (self.everydayArr.count != 0) {
            EveryDayModel *model = self.everydayArr[indexPath.row];
            UserInfo *user = self.userinfoArr[indexPath.section][indexPath.row];
            [cell setValueWithModel:model user:user];
        }
        return cell;
    } else {
        SpecialTopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SpecialTop" forIndexPath:indexPath];
        if (self.specialTopArr.count != 0) {
            EveryDayModel *model = self.specialTopArr[indexPath.row];
            UserInfo *user = self.userinfoArr[indexPath.section][indexPath.row];
            [cell setValueWithModel:model user:user];
        }
        return cell;
    }

}
// 设置增广视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    RecommendCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"recommend" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        reusableView.titleLabel.text = @"每日精选故事";
        [reusableView.arrowBtn addTarget:self action:@selector(clickMoreStory) forControlEvents:(UIControlEventTouchUpInside)];
        [reusableView.arrowBtn setTitle:@"更多" forState:(UIControlStateNormal)];
    } else if (indexPath.section == 1){
        reusableView.titleLabel.text = @"精彩游记和专题";
        reusableView.arrowBtn.titleLabel.text = @"";
    }
    
    return reusableView;
    
}

// 更多故事按钮点击
- (void)clickMoreStory {
    MoreStoryViewController *moreStoryVC = [[MoreStoryViewController alloc] init];
    moreStoryVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moreStoryVC animated:YES];
    [moreStoryVC release];
}

//设置行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
   if (section == 1){
        return 10;
    } else {
        return 13;
    }
}

// 设置每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake((kWidth - 30) / 2, 220.0 / kAutoWidth);
    } else {
        return CGSizeMake(kWidth - 20, 215 / kAutoWidth);
    }
}

// 设置距上 下 左 右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
// 设置表头的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    return CGSizeMake(kWidth, 55);

}

// 设置itme的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        StoryDetailViewController *storyVC = [[StoryDetailViewController alloc] init];
        storyVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        storyVC.spot_id = [self.everydayArr[indexPath.row] spot_id];
        storyVC.name = [self.everydayArr[indexPath.row] name];
        storyVC.picUrl = [self.everydayArr[indexPath.row] cover_image_w640];
        EveryDayModel *model = self.everydayArr[indexPath.row];
        storyVC.content = model.text;
        storyVC.refreshCollectionBlock = ^(void) {
        };
        [self presentViewController:storyVC animated:YES completion:nil];
        [storyVC release];
    } else {
        TravelsViewController *travelVC = [[TravelsViewController alloc] init];
        travelVC.hidesBottomBarWhenPushed = YES;
        travelVC.ID = [self.specialTopArr[indexPath.row] ID];
        travelVC.picUrl = [self.specialTopArr[indexPath.row] cover_image_w640];
        travelVC.refreshCollectionBlock = ^(void) {
        };
        [self.navigationController pushViewController:travelVC animated:YES];
        [travelVC release];
        
    }
    
}

#pragma mark --------------- 上拉刷新 ----------------

- (void)refreshLoading {
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.collectionView;
    header.delegate = self;
    // 自动刷新
    [header beginRefreshing];
    _header = header;
    
    MJRefreshFooterView *footerView = [[MJRefreshFooterView alloc] init];
    footerView.scrollView = self.collectionView;
    footerView.delegate = self;
    _footer = footerView;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView {
    // 刷新表格
    [self.collectionView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

#pragma mark - 刷新控件的代理方法
#pragma mark 开始进入刷新状态
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    //NSLog(@"%@----开始进入刷新状态", refreshView.class);
    
    // 1.刷新数据
        
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        
        NSString *url = [NSString stringWithFormat:kRefreshJounaryUrl, self.next_start];
        //NSLog(@"%@", url);
        [LORequestManger GET:url success:^(id response) {
            NSDictionary *dict = (NSDictionary *)response;
            self.next_start = dict[@"next_start"];
            for (NSDictionary *dic in dict[@"elements"]) {
                    for (NSDictionary *data in dic[@"data"]) {
                        EveryDayModel *model = [EveryDayModel shareJsonWithDictionary:data];
                        if ([dic[@"type"] isEqualToNumber:@4]) {
                            [self.specialTopArr addObject:model];
                            UserInfo *userInfo = [UserInfo shareJasonWithDictionary:model.user];
                            [self.special addObject:userInfo];
                        }
                    }
                }
            [self.userinfoArr addObject:self.special];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //NSLog(@"%@", error);
        }];
    }
    // 2.2秒后刷新表格UI
    [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
}

#pragma mark 刷新完毕
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView {
    //NSLog(@"%@----刷新完毕", refreshView.class);
}

#pragma mark 监听刷新状态的改变
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state {
    switch (state) {
        case MJRefreshStateNormal:
            //NSLog(@"%@----切换到：普通状态", refreshView.class);
            break;
            
        case MJRefreshStatePulling:
            //NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
            break;
            
        case MJRefreshStateRefreshing:
            //NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
            break;
        default:
            break;
    }
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
