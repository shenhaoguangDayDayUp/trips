//
//  SearchDetailViewController.m
//  Travel
//
//  Created by 申浩光 on 15/10/8.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "SearchDetailTableViewCell.h"
#import "SearchResultModel.h"
#import "MJRefreshFooterView.h"
#import "SearchModel.h"
#import "SearchSightTableViewCell.h"
#import "ScenicViewController.h"
#import "LcityTableViewController.h"
#import "TravelsViewController.h"
@interface SearchDetailViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MJRefreshBaseViewDelegate>
{
    MJRefreshFooterView *_footer;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) NSMutableArray *resultArr;
@property (nonatomic, retain) NSMutableArray *SightArr;
@end

@implementation SearchDetailViewController

- (void)dealloc {
    [_tableView release];
    [_searchBar release];
    [_content release];
    [_resultArr release];
    [_SightArr release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self reloadSearchDetailData];
    [self reloadSearchSight];
    [self refreshLoading];
}

- (NSMutableArray *)resultArr {
    if (!_resultArr) {
        _resultArr = [[NSMutableArray alloc] init];
    }
    return _resultArr;
}

- (NSMutableArray *)SightArr{
    if (!_SightArr) {
        _SightArr = [[NSMutableArray alloc] init];
    }
    return  _SightArr;
}
- (void)reloadSearchDetailData {
    
    NSString *string = [self.content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@",[NSString stringWithFormat:kSearchResultUrl, string, self.resultArr.count]);
    [LORequestManger GET:[NSString stringWithFormat:kSearchResultUrl, string, self.resultArr.count] success:^(id response) {
        
        NSDictionary *dict = (NSDictionary *)response;
        for (NSDictionary *dic in dict[@"trips"]) {
            SearchResultModel *model = [SearchResultModel shareJsonWithDictonary:dic];
            [self.resultArr addObject:model];
        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@", error);
    }];
    
}

- (void)reloadSearchSight{
    NSString *str = [self.content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [LORequestManger GET:[NSString stringWithFormat:kSearchSight,str] success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        for (NSDictionary *dict in dic[@"places"]) {
            SearchSightModel *model = [SearchSightModel shareJsonWithDictonary:dict];
            [self.SightArr addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //NSLog(@"%@",error);
    }];

}

- (void)setUpTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:kBounds style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = kBackColor;
    self.tableView.separatorStyle = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SearchDetailTableViewCell class] forCellReuseIdentifier:@"searchCell"];
    [self.tableView registerClass:[SearchSightTableViewCell class] forCellReuseIdentifier:@"searchSighCell"];
    self.tableView.contentInset = UIEdgeInsetsMake(74, 0, 10, 0);
    
    UIView *navigationBar = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, kWidth, 64))];
    navigationBar.backgroundColor = kPinkColor;
    [self.view addSubview:navigationBar];
    [navigationBar release];
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBtn.frame = CGRectMake(15, 30, 25, 25);
    [backBtn setImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:(UIControlStateNormal)];
    [backBtn setTintColor:kBackColor];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:(CGRectMake(15 + 25 + 20, 22, kWidth - (15 + 25 + 40) , 40))];
    _searchBar.delegate = self;
    _searchBar.placeholder = self.content;
    [self.view addSubview:_searchBar];
    [self setUpSearchBar];
}

//搜索按键
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.content = self.searchBar.text;
    [self.resultArr removeAllObjects];
    [self.SightArr removeAllObjects];
    [self reloadSearchDetailData];
    [self reloadSearchSight];
    [self.tableView reloadData];
}

- (void)setUpSearchBar {
    
    for (UIView *view in _searchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    
}

- (void)clickBack {

    [self dismissViewControllerAnimated:NO completion:nil];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
//        //NSLog(@"%d",self.SightArr.count);
        return self.SightArr.count;
        
    }else{
        if (self.resultArr.count == 0) {
            return 10;
        } else {
            return self.resultArr.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        SearchSightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchSighCell" forIndexPath:indexPath];
        SearchSightModel *model = self.SightArr[indexPath.row];
        [cell setupWithModel:model];
        return cell;
    }else{
    SearchDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
        if (self.resultArr.count != 0) {
            SearchResultModel *model = self.resultArr[indexPath.row];
            [cell setValueWithModel:model];
        }
    return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
    return 50.0 / kAutoHight;
    }else{
        return 110.0/kAutoHight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LcityTableViewController *city = [[LcityTableViewController alloc] init];
        SearchSightModel *model = self.SightArr[indexPath.row];
        city.model.ID = model.ID;
        city.model.type = model.type;
      [self presentViewController:city animated:NO completion:nil];
        [city release];
        
    }else{
        
        TravelsViewController *travelVC = [[TravelsViewController alloc] init];
        if (self.resultArr.count != 0) {
            travelVC.ID = [self.resultArr[indexPath.row] ID];

        }
        travelVC.refreshCollectionBlock = ^(void) {
        
        };
        
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:travelVC];
        [self presentViewController:naVC animated:NO completion:nil];

        [travelVC release];
        [naVC release];
    }
}

- (void)refreshLoading {
    MJRefreshFooterView *footerView = [[MJRefreshFooterView alloc] init];
    footerView.scrollView = self.tableView;
    footerView.delegate = self;
    _footer = footerView;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.tableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

#pragma mark - 刷新控件的代理方法
#pragma mark 开始进入刷新状态
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    //NSLog(@"%@----开始进入刷新状态", refreshView.class);
    
    // 1.刷新数据
    [self reloadSearchDetailData];
    
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
