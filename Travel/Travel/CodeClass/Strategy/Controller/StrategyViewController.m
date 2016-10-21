//
//  StrategyViewController.m
//  Travel
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "StrategyViewController.h"
#import "TitleScrollView.h"
#import "TableScrollView.h"
#import "StrategyTableViewCell.h"
#import "YALSunnyRefreshControl.h"
#import "NewStrategyModel.h"
#import "UIImageView+WebCache.h"
#import "StrategyDetailViewController.h"
#import "LocationViewController.h"
#import "MJRefreshFooterView.h"
#import "StrategyDataBase.h"
#import "DXAlertView.h"

@interface StrategyViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) TitleScrollView *titleScrollView;
@property (nonatomic, retain) TableScrollView *tableScrollView;
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, retain) YALSunnyRefreshControl *sunnyRefreshControl;
@property (nonatomic, retain) NSArray *urlArray;
@property (nonatomic, copy) NSString *startCount;

@end

@implementation StrategyViewController

- (void)dealloc
{
    [_dataArr release];
    [_titleScrollView release];
    [_tableScrollView release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[StrategyDataBase shareDataBase] createSqliteStrategy];
    //初始化链接数组
    self.urlArray = @[kNewStrategy, kHotStrategy, kAsian, kEurope, kOceania, kAmerica, kAfrica];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kBackColor;
    self.startCount = @"0";  
    [self setUpNewStrategyData];
    
    //添加页面上方一排按钮，可以滚动
    [self addTitleScrollView];
    
    //添加滑动页面
    [self addTableScrollView];
    
}


#pragma mark ------解析数据------

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

//解析数据
- (void)setUpNewStrategyData {
     __block StrategyViewController *strategyVC = self;
    for (int i = 0; i < self.urlArray.count; i++) {
        NSMutableArray *newArr = [NSMutableArray array];
        [LORequestManger GET:self.urlArray[i] success:^(id response) {
            NSDictionary *dict = (NSDictionary *)response;
            
            if (i == 1) {
                //NSLog(@"刷新第一个界面");
                UITableView *tableView = (UITableView *)[_tableScrollView viewWithTag:2000];
                [tableView reloadData];
            }
            
            for (NSDictionary *listDic in dict[@"obj"][@"list"]) {
                for (NSDictionary *dic in listDic[@"list"]) {
                    NewStrategyModel *aNewModel = [NewStrategyModel setModelWithDic:dic];
                    [newArr addObject:aNewModel];
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (i == self.urlArray.count - 1) {
                DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"加载失败了" contentText:@"下拉可以刷新哦~" leftButtonTitle:nil rightButtonTitle:@"确定"];
                [alert show];
                [alert release];
            }
            
            //NSLog(@"%@", error);
        }];
        [strategyVC.dataArr addObject:newArr];

    }
}


#pragma mark ------添加滚动的页面------

- (void)addTableScrollView {
    _tableScrollView = [[TableScrollView alloc] initWithFrame:CGRectMake(0, 64 + 30, kWidth, kHeight - 64 - 30) contentArr:nil];
    _tableScrollView.delegate = self;
    _tableScrollView.tag = 11111;
    [self.view addSubview:_tableScrollView];
    
    for (int i = 0; i < 7 ; i++) {
        UITableView *tableView = (UITableView *)[_tableScrollView viewWithTag:i + 2000];
        tableView.separatorStyle = NO;
        tableView.backgroundColor = kBackColor;
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 59, 0);
        [tableView registerClass:[StrategyTableViewCell class] forCellReuseIdentifier:@"myCell"];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        //添加下拉刷新
        self.sunnyRefreshControl = [YALSunnyRefreshControl attachToScrollView:tableView target:self refreshAction:@selector(sunnyControlAction:)];
        if (i == 0) {
            [self.sunnyRefreshControl startRefreshing];
            //添加上拉加载
            [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(endLoadRefreshing) userInfo:nil repeats:NO];
            
            MJRefreshFooterView *footer = [MJRefreshFooterView footer];
            footer.scrollView = tableView;
            footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
                
                self.startCount = [NSString stringWithFormat:@"%d", [self.startCount integerValue] + 12] ;
                NSString *url = [NSString stringWithFormat:kNewStrategyP, self.startCount];
                ////NSLog(@"%@", url);
                [footer endRefreshing];
                [LORequestManger GET:url success:^(id response) {
                    NSDictionary *dict = (NSDictionary *)response;
                    NSMutableArray *array = self.dataArr[i];
                    
                    for (NSDictionary *listDic in dict[@"obj"][@"list"]) {
                        for (NSDictionary *dic in listDic[@"list"]) {
                            NewStrategyModel *aNewModel = [NewStrategyModel setModelWithDic:dic];
                            [array addObject:aNewModel];
                        }
                    }
                    
                    //[self.dataArr replaceObjectAtIndex:index withObject:array];
                    
                    UITableView *tableView = (UITableView *)[_tableScrollView viewWithTag:2000 + i];
                    [tableView reloadData];
                    
                    
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                    //NSLog(@"%@", error);
                }];
            };
        }
        

        
    }
    
}
- (void)endLoadRefreshing {
    [self.sunnyRefreshControl endRefreshing];
}

#pragma mark ------下拉刷新------
- (void)sunnyControlAction:(YALSunnyRefreshControl *)sunnyRefreshControl {
    //NSLog(@"下拉刷新开始");
    NSInteger index = sunnyRefreshControl.scrollView.tag - 2000;
    
    [LORequestManger GET:self.urlArray[index] success:^(id response) {
        NSDictionary *dict = (NSDictionary *)response;
        NSMutableArray *array = [NSMutableArray array];
        
        ////NSLog(@"%@", self.dataArr[index]);
        for (NSDictionary *listDic in dict[@"obj"][@"list"]) {
            for (NSDictionary *dic in listDic[@"list"]) {
                NewStrategyModel *aNewModel = [NewStrategyModel setModelWithDic:dic];
                [array addObject:aNewModel];
            }
        }
        
        [self.dataArr replaceObjectAtIndex:index withObject:array];
        
        UITableView *tableView = (UITableView *)[_tableScrollView viewWithTag:2000 + index];
        [tableView reloadData];
        [sunnyRefreshControl endRefreshing];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [sunnyRefreshControl endRefreshing];
        ////NSLog(@"%@", error);
        //NSLog(@"网络错误");
    }];
    ////NSLog(@"%ld", (long)sunnyRefreshControl.scrollView.tag);
}

#pragma mark ------tableView代理方法------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArr.count > 0 && [self.dataArr[0] count] != 0) {
            return [self.dataArr[tableView.tag - 2000] count];
        }else{
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StrategyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];

    if (self.dataArr.count > 0 && [self.dataArr[0] count] != 0) {
        NSArray *modelArr = self.dataArr[tableView.tag - 2000];
        if (tableView.tag == 2000) {
            [cell setCellWithNewStrategyModel:modelArr[indexPath.row]];
            return cell;
        }else{
            [cell setCellWithHotStrategyModel:modelArr[indexPath.row]];
            return cell;
        }
    }else{
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0 / kAutoHight;
}


#pragma mark ------滚动改变选中的btn------

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger tag = _tableScrollView.contentOffset.x / kWidth + 10000;
    UIButton *btn = (UIButton *)[_titleScrollView viewWithTag:tag];
    //NSLog(@"滑动到第%ld个页面", (long)tag - 10000);
    [self resetBtnTitleAndAnimate:btn];
    //根据滑动到的页面刷新相应页面的数据
    [self reloadTableViewAtBtn:btn];
    if (scrollView.tag == 11111) {
        [self setTitleScrollViewContentOfsetAtBtn:btn];
    }
}


#pragma mark ------设置页面上方一排按钮，可以滚动------

- (void)addTitleScrollView {
    
    //标题文字
    NSArray *titleArr = @[@"最新",@"热门",@"亚洲",@"欧洲",@"美洲",@"非洲",@" 大洋洲"];
    
    self.titleScrollView = [[TitleScrollView alloc] initWithFrame:CGRectMake(0, 64, kWidth, 30) titleArr:titleArr target:self action:@selector(clickBtnAction:) controllEvent:UIControlEventTouchUpInside];
    [self.view addSubview:self.titleScrollView];
    [_titleScrollView release];
}


#pragma mark ------点击事件------

- (void)clickBtnAction:(UIButton *)btn {
    [self resetBtnTitleAndAnimate:btn];
    [_tableScrollView setContentOffset:CGPointMake((btn.tag - 10000) * kWidth, 0) animated:YES];
    [self reloadTableViewAtBtn:btn];
    [self setTitleScrollViewContentOfsetAtBtn:btn];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 2000) {
        //跳转最新页面
        StrategyDetailViewController *detailVC = [[StrategyDetailViewController alloc] init];
        detailVC.url = [_dataArr[tableView.tag - 2000][indexPath.row] link];
        detailVC.webTitle = [_dataArr[tableView.tag - 2000][indexPath.row] title];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:detailVC.url]];
        NSArray *modelArr = self.dataArr[tableView.tag - 2000];
        detailVC.picUrl = [modelArr[indexPath.row] banners][@"img_high"];
        detailVC.subTitle = [modelArr[indexPath.row] subtitle];
        detailVC.request = request;
        [request release];
        detailVC.hidesBottomBarWhenPushed = YES;
        detailVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        detailVC.refreshCollectionBlock = ^(void) {
            //NSLog(@"返回主页面，回调无效");
        };
        [self presentViewController:detailVC animated:YES completion:nil];
        [detailVC release];
    }else{
        //跳转最新以外的界面
        LocationViewController *locationVC = [[LocationViewController alloc] init];
        NewStrategyModel *model = _dataArr[tableView.tag - 2000][indexPath.row];
        locationVC.coverPic = [NSString stringWithFormat:@"http://img.117go.com/timg/p750/%@", model.coverpic];
        locationVC.itemId = model.itemid;
        locationVC.model = model;
        locationVC.hidesBottomBarWhenPushed = YES;
        locationVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:locationVC animated:YES completion:nil];
        [locationVC release];
    }
    
}

#pragma mark ------重置按钮，选中按钮动画------
- (void)resetBtnTitleAndAnimate:(UIButton *)btn {
    [self.titleScrollView setButtonToDefault];
    [UIView animateWithDuration:0.2 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        CGRect frame = self.titleScrollView.lineView.frame;
        frame.origin.x = (btn.tag - 10000) * 60.0 / kAutoWidth;
        self.titleScrollView.lineView.frame = frame;
    }];
}

#pragma mark ------根据按钮刷新相应页面------
- (void)reloadTableViewAtBtn:(UIButton *)btn {
    UITableView *tableView = (UITableView *)[_tableScrollView viewWithTag:btn.tag - 8000];
    [tableView reloadData];
}

#pragma mark ------根据标题改变标题位置------
- (void)setTitleScrollViewContentOfsetAtBtn:(UIButton *)btn {
    if (btn.tag - 10000 >= 3 && _titleScrollView.contentOffset.x == 0) {
        [_titleScrollView setContentOffset:CGPointMake(btn.bounds.size.width * 7 - kWidth, 0) animated:YES];
    }else if(btn.tag - 10000 <= 3 && _titleScrollView.contentOffset.x != 0){
        [_titleScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
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
