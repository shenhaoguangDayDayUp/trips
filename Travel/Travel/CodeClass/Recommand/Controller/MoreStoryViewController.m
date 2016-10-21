//
//  MoreStoryViewController.m
//  Travel
//
//  Created by 申浩光 on 15/9/19.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "MoreStoryViewController.h"
#import "WonderfulStroyCollectionViewCell.h"
#import "StoryDetailViewController.h"
#import "MJRefreshFooterView.h"
@interface MoreStoryViewController () <UICollectionViewDataSource, UICollectionViewDelegate, MJRefreshBaseViewDelegate>
{
    MJRefreshFooterView *_footer;

}
@property (nonatomic, retain) UICollectionView *collectionView;

// 存放everyDay信息的数组
@property (nonatomic, retain) NSMutableArray *everydayArr;

// 存放用户信息的数组
@property (nonatomic, retain) NSMutableArray *userinfoArr;

@end

@implementation MoreStoryViewController

- (void)dealloc {
    [_collectionView release];
    [_everydayArr release];
    [_userinfoArr release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpMoreStoryView];
    [self reloadDataWithMoreStory];
    [self refreshLoading];
}


#pragma mark --------------- 数据解析 ----------------

- (void)reloadDataWithMoreStory {
    [LORequestManger GET:[NSString stringWithFormat:kMoreWonderfulStory, self.everydayArr.count] success:^(id response) {
        
        NSDictionary *dict = (NSDictionary *)response;
        for (NSDictionary *data in dict[@"data"][@"hot_spot_list"]) {
                EveryDayModel *model = [EveryDayModel shareJsonWithDictionary:data];
                [self.everydayArr addObject:model];
                UserInfo *userInfo = [UserInfo shareJasonWithDictionary:model.user];
                [self.userinfoArr addObject:userInfo];
        }
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
   
    }];
}

#pragma mark --------------- 懒加载 ----------------

- (NSMutableArray *)everydayArr {
    if (!_everydayArr) {
        _everydayArr = [[NSMutableArray alloc] init];
    }
    return _everydayArr;
}

- (NSMutableArray *)userinfoArr {
    if (!_userinfoArr) {
        _userinfoArr = [[NSMutableArray alloc] init];
    }
    return _userinfoArr;
}

- (void)setUpMoreStoryView {
    
    self.navigationItem.title = @"每日精彩故事";
    
    // 设置collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake((kWidth - 30) / 2, 220.0 / kAutoWidth);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView = [[UICollectionView alloc] initWithFrame:kBounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[WonderfulStroyCollectionViewCell class] forCellWithReuseIdentifier:@"WonderfulCell"];
    [layout release];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_nav_back_button"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickBack)];
    backBtn.tintColor = [UIColor colorWithRed:0.886 green:0.2588 blue:0.3411 alpha:1];
    self.navigationItem.leftBarButtonItem = backBtn;
    [backBtn release];
    
}
- (void)clickBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --------------- collectionView代理 ----------------

// 返回分区的行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.everydayArr.count;
}
// 设置collectionView的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WonderfulStroyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WonderfulCell" forIndexPath:indexPath];
    EveryDayModel *model = self.everydayArr[indexPath.row];
    UserInfo *user = self.userinfoArr[indexPath.row];
    [cell setValueWithModel:model user:user];
    return cell;
}

// 设置itme的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    StoryDetailViewController *storyVC = [[StoryDetailViewController alloc] init];
    storyVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    storyVC.spot_id = [self.everydayArr[indexPath.row] spot_id];
    storyVC.refreshCollectionBlock = ^(void) {
    
    
    };
    [self presentViewController:storyVC animated:YES completion:nil];
    [storyVC release];
    
}


#pragma mark --------------- 刷新 ----------------

- (void)refreshLoading {
    MJRefreshFooterView *footerView = [[MJRefreshFooterView alloc] init];
    footerView.scrollView = self.collectionView;
    footerView.delegate = self;
    _footer = footerView;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.collectionView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

#pragma mark - 刷新控件的代理方法
#pragma mark 开始进入刷新状态
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    //NSLog(@"%@----开始进入刷新状态", refreshView.class);
    
    // 1.刷新数据
    [self reloadDataWithMoreStory];
    
    // 2.2秒后刷新表格UI
    [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
}

#pragma mark 刷新完毕
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    //NSLog(@"%@----刷新完毕", refreshView.class);
}

#pragma mark 监听刷新状态的改变
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
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
