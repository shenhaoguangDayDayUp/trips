//
//  StrategyCollectTableViewController.m
//  Travel
//
//  Created by lanou on 15/10/5.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "StrategyCollectTableViewController.h"
#import "StrategyCollectTableViewCell.h"
#import "StrategyCollectionModel.h"

#import "ZDtailViewController.h"
#import "StrategyDetailViewController.h"

#import "SightModel.h"
#import "ScenicViewController.h"
#import "StrategyDataBase.h"
#import "EveryDayModel.h"
#import "TravelsViewController.h"
#import "StoryDetailViewController.h"


@interface StrategyCollectTableViewController ()<UITableViewDataSource, UITableViewDelegate>



@end

@implementation StrategyCollectTableViewController

- (void)dealloc {
    [_strategyArray release];
    [_titleString release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.tableView.backgroundColor = kBackColor;
    self.tableView.separatorStyle = NO;
    
    [self.tableView registerClass:[StrategyCollectTableViewCell class] forCellReuseIdentifier:@"StrategyCell"];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_new_poi_back_btn"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    backBtn.tintColor = kBrownColor;
    self.navigationItem.leftBarButtonItem = backBtn;
    
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.strategyArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StrategyCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StrategyCell" forIndexPath:indexPath];
    if([self.titleString isEqualToString:@"攻略"]){
        
        StrategyCollectionModel *model = self.strategyArray[indexPath.row];
        [cell.bacView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"trip_edit_empty_content"]];
        [cell.pic sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"trip_edit_empty_content"]];
        cell.titleLabel.text = model.title;
        cell.subTitleLabel.text = model.subTitle;
        
    }else if ([self.titleString isEqualToString:@"目的地"]){
        
        SightModel *model = self.strategyArray[indexPath.row];
        [cell.bacView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"trip_edit_empty_content"]];
        [cell.pic sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"trip_edit_empty_content"]];
        cell.titleLabel.text = model.name;
        cell.subTitleLabel.text = @"";
        
        
    } else if ([self.titleString isEqualToString:@"推荐"]) {
        
        EveryDayModel *model = self.strategyArray[indexPath.row];
        [cell.bacView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_w640] placeholderImage:[UIImage imageNamed:@"trip_edit_empty_content@2x"]];
        [cell.pic sd_setImageWithURL:[NSURL URLWithString:model.cover_image_w640] placeholderImage:[UIImage imageNamed:@"trip_edit_empty_content@2x"]];
        cell.titleLabel.text = model.name;
        cell.subTitleLabel.text = model.text;
        
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.titleString isEqualToString:@"目的地"]) {
        ScenicViewController *scenic = [[[ScenicViewController alloc] init] autorelease];
        scenic.model = self.strategyArray[indexPath.row];
        scenic.titleName = [self.strategyArray[indexPath.row] name];
        scenic.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        scenic.index = indexPath.row;
        scenic.resfresh = ^(NSInteger index1){
            self.strategyArray = [[StrategyDataBase shareDataBase] selectedAll];
            [tableView reloadData];
        };
        
        [self presentViewController:scenic animated:YES completion:nil];
        
    }else if([self.titleString isEqualToString:@"攻略"]){
        
        StrategyCollectionModel *model = self.strategyArray[indexPath.row];
        if (!model.itemId) {
            StrategyDetailViewController *detailVC = [[StrategyDetailViewController alloc] init];
            detailVC.url = model.url;
            detailVC.webTitle = model.title;
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:detailVC.url]];            
            detailVC.picUrl = model.picUrl;
            detailVC.subTitle = model.subTitle;
            detailVC.request = request;
            [request release];
            detailVC.hidesBottomBarWhenPushed = YES;
            detailVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            //进入展示界面，返回时从数据库中重新取出数据赋值，刷新数据
            detailVC.refreshCollectionBlock = ^(void) {
                self.strategyArray = [[StrategyDataBase shareDataBase] allStrategyCollection];
                [self.tableView reloadData];
            };
            
            [self presentViewController:detailVC animated:YES completion:nil];
            [detailVC release];
        }else{
            ZDtailViewController *strategyVC = [[ZDtailViewController alloc] init];
            strategyVC.itemId = model.itemId;
            strategyVC.tourId = model.tourId;
            strategyVC.hidesBottomBarWhenPushed = YES;
            //进入展示界面，返回时从数据库中重新取出数据赋值，刷新数据
            strategyVC.refreshCollectionBlock = ^(void) {
                self.strategyArray = [[StrategyDataBase shareDataBase] allStrategyCollection];
                [self.tableView reloadData];
            };
            [self presentViewController:strategyVC animated:YES completion:nil];
            [strategyVC release];
        }
        
    } else {
        EveryDayModel *everyModel = self.strategyArray[indexPath.row];
        if (everyModel.spot_id != nil) {
            StoryDetailViewController *storyVC = [[StoryDetailViewController alloc] init];
            storyVC.content = everyModel.text;
            storyVC.name = everyModel.name;
            storyVC.picUrl = everyModel.cover_image_1600;
            storyVC.spot_id = everyModel.spot_id;

            storyVC.hidesBottomBarWhenPushed = YES;
            storyVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            //进入展示界面，返回时从数据库中重新取出数据赋值，刷新数据
            storyVC.refreshCollectionBlock = ^(void) {
                self.strategyArray = [[StrategyDataBase shareDataBase] getAllRecommendCollecttion];
                [self.tableView reloadData];
            };
            
            [self presentViewController:storyVC animated:YES completion:nil];
            [storyVC release];
            
        } else {
            TravelsViewController *travelVC = [[TravelsViewController alloc] init];
            travelVC.ID = everyModel.ID;
            travelVC.picUrl = everyModel.cover_image_w640;
            travelVC.name = everyModel.name;
            
            travelVC.hidesBottomBarWhenPushed = YES;
            travelVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            //进入展示界面，返回时从数据库中重新取出数据赋值，刷新数据
            travelVC.refreshCollectionBlock = ^(void) {
                self.strategyArray = [[StrategyDataBase shareDataBase] getAllRecommendCollecttion];
                [self.tableView reloadData];
            };
            
            [self.navigationController pushViewController:travelVC animated:YES];
            [travelVC release];
        }
      
    
    }
    
    
}


//添加删除样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//删除对应的数据
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if ([self.titleString isEqualToString:@"目的地"]) {
            SightModel *model = self.strategyArray[indexPath.row];
            [[StrategyDataBase shareDataBase] deleteSightModelWithname:model.name];
            
        }else if([self.titleString isEqualToString:@"攻略"]){
            StrategyCollectionModel *model = self.strategyArray[indexPath.row];
            [[StrategyDataBase shareDataBase] deleteWebCollectionWithTitle:model.title ItemId:model.itemId tourId:model.tourId];
        } else if ([self.titleString isEqualToString:@"推荐"]) {
        
            EveryDayModel *model = self.strategyArray[indexPath.row];
            if (model.ID) {
                [[StrategyDataBase shareDataBase] deleteRecommendCollectionWithTitle:nil spotId:nil ID:model.ID];
            } else {
                [[StrategyDataBase shareDataBase] deleteRecommendCollectionWithTitle:nil spotId:model.spot_id ID:nil];
            }
            
        }
        [self.strategyArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
