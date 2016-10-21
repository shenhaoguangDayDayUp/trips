//
//  CollectedViewController.m
//  Travel
//
//  Created by 申浩光 on 15/10/5.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "CollectedViewController.h"
#import "CollectedTableViewCell.h"

#import "StrategyCollectTableViewController.h"
#import "StrategyDataBase.h"
@interface CollectedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@end

@implementation CollectedViewController

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
}


- (void)setUpTableView {
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_new_poi_back_btn"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    backBtn.tintColor = kBrownColor;
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.title = @"收藏";
    
    self.tableView = [[[UITableView alloc] initWithFrame:kBounds style:(UITableViewStylePlain)] autorelease];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kBackColor;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[CollectedTableViewCell class] forCellReuseIdentifier:@"collectedCell"];
    [backBtn release];
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectedCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.text.text = @"游记和地点故事";
    } else if (indexPath.section == 1) {
        cell.text.text = @"目的地";
    } else if (indexPath.section == 2) {
        cell.text.text = @"攻略";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[[UIView alloc] init]autorelease];
    view.backgroundColor = kBackColor;
    return view;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        StrategyCollectTableViewController *collectVC = [[[StrategyCollectTableViewController alloc] init] autorelease];
        collectVC.titleString = @"推荐";
        collectVC.navigationItem.title = @"游记和精彩故事收藏";
        collectVC.strategyArray = [[StrategyDataBase shareDataBase] getAllRecommendCollecttion];
        [self.navigationController pushViewController:collectVC animated:YES];
        
        
    }else if (indexPath.section == 1){
       StrategyCollectTableViewController *collectVC = [[StrategyCollectTableViewController alloc] init];
        collectVC.hidesBottomBarWhenPushed = YES;
        collectVC.titleString = @"目的地";
        collectVC.navigationItem.title = @"目的地收藏";
        collectVC.strategyArray = [[StrategyDataBase shareDataBase] selectedAll];
        
        [self.navigationController pushViewController:collectVC animated:YES];
        [collectVC release];
    }else{
        //NSLog(@"攻略界面收藏");
        StrategyCollectTableViewController *collectVC = [[[StrategyCollectTableViewController alloc] init] autorelease];
        collectVC.titleString = @"攻略";
        collectVC.navigationItem.title = @"攻略收藏";
        collectVC.strategyArray = [[StrategyDataBase shareDataBase] allStrategyCollection];
        [self.navigationController pushViewController:collectVC animated:YES];
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
