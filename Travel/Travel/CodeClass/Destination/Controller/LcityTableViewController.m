//
//  LcityTableViewController.m
//  Travel
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LcityTableViewController.h"
#import "Lcityimageview.h"
#import "LORequestManger.h"
#import "LdestinationModel.h"
#import "SightModel.h"
#import "SightTableViewCell.h"
#import "ScenicViewController.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "UMSocial.h"
#import "LphotoCollectionViewController.h"
#define NavigationBarHight 64.0f
#define ImageHight 300.0f
@interface LcityTableViewController ()<UMSocialUIDelegate,MJRefreshBaseViewDelegate>
{
    
    MJRefreshFooterView *_footer;
    MJRefreshHeaderView *_header;
    
}

@property (nonatomic,retain) Lcityimageview *imageview;
@property (nonatomic,retain) NSMutableArray *LcityArray;
@property (nonatomic,retain) NSMutableArray *dicArray;
@property (nonatomic,retain) NSNumber *count;
@property (nonatomic,retain) UIButton *buttonback;
@property (nonatomic,retain) UIView *headerView;
@end

@implementation LcityTableViewController

- (void)dealloc{
    [_dicArray release];
    [_LcityArray release];
    [_count release];
    
    [super dealloc];
}

- (LdestinationModel *)model{
    if (!_model) {
        _model = [[LdestinationModel alloc]init];
    }
    return _model;
}
//城市数组懒加载
- (NSMutableArray *)LcityArray{
    if (!_LcityArray) {
        self.LcityArray = [NSMutableArray array];
    }
    return _LcityArray;
}

- (NSMutableArray *)dicArray{
    if (!_dicArray) {
        self.dicArray = [NSMutableArray array];
    }
    return _dicArray;
}
//图片数据解析
- (void)setUpWithJsonCity{
    NSString *str = [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/",self.model.type,self.model.ID];
    [LORequestManger GET:str success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        CountryModel *countryModel = [CountryModel shareJsonWithDictionary:dic];
        [self.dicArray addObject:countryModel];
        NSArray *photo =  dic[@"hottest_places"];
        for (NSDictionary *data in photo) {
            _picstring = [data valueForKey:@"photo"];
//            //NSLog(@"%@",_picstring);
        }
        [self setUpviewcontroller];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //NSLog(@"%@",error);
    }];
    
}


//cell数据解析
- (void)setupWithcellJsonsight{
    NSString *arr = [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/pois/all/?sort=default&start=%@&latitude=38.880918&longitude=121.546376&sign=e306b4ad817d9c2df47cd4097ac69244",self.model.type,self.model.ID,self.count];
//    //NSLog(@"%@",arr);
    [LORequestManger GET:arr success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        self.count = dic[@"next_start"];
        for (NSDictionary *data in dic[@"items"]) {
            SightModel *model = [SightModel shareJsonWithDictionary:data];
            [self.LcityArray addObject:model];
        }
        [self.tableView reloadData];
        
        // [self.tableview.defaultFooter endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ////NSLog(@"%@",error);
        
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
    self.count = @0;
    [self setUpWithJsonCity];
    [self setupWithcellJsonsight];
    [self setUpJsonpullUpresfre];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//框架搭建
- (void)setUpviewcontroller{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(ImageHight, 0, 40, 0);
    self.tableView.backgroundColor = kBackColor;
    _imageview = [[Lcityimageview alloc] initWithFrame:CGRectMake(0, -ImageHight, kWidth, ImageHight) target:self action:@selector(imageTouch)];
    [_imageview setupJsonModel:self.dicArray[0]];
    _imageview.contentMode = UIViewContentModeScaleAspectFill;
    _imageview.clipsToBounds = YES;
    if(_picstring == nil){
        _imageview.image = [UIImage imageNamed:@"trip_edit_cover_default@2x"];
    }else{
    NSArray *string = [_picstring componentsSeparatedByString:@"?"];
    //NSLog(@"%@",string);
    [_imageview sd_setImageWithURL:[NSURL URLWithString:string[0]]];
    }
    [self.tableView addSubview:_imageview];
    
    

    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, -ImageHight, kWidth, 64)];
    _headerView.backgroundColor = [UIColor colorWithRed:0.882 green:0.839 blue:0.729 alpha:1.000];
    _headerView.alpha = 0;
    _headerView.userInteractionEnabled = YES;
    _headerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self.view addSubview:_headerView];
    
    _buttonback = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _buttonback.frame = CGRectMake(10/kAutoWidth, -280, 40, 40);
    _buttonback.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [_buttonback setImage:[UIImage imageNamed:@"add_new_poi_back_btn"] forState:(UIControlStateNormal)];
    [_buttonback addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    _buttonback.tintColor = kBackColor;
    [self.view addSubview:_buttonback];
    
    [self.tableView registerClass:[SightTableViewCell class] forCellReuseIdentifier:@"mycell11"];
    
   // self.tableView.tableHeaderView = _imageview ;


}

- (void)back{
   
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//上拉刷新
- (void)setUpJsonpullUpresfre{
    
    __unsafe_unretained LcityTableViewController *city = self;
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
    [city setupWithcellJsonsight];
        
        [city performSelector:@selector(doneWithview:) withObject:refreshView afterDelay:2.0];
    };
    _footer = footer;
    
}

//下拉刷新
-(void)addHeader{

    __unsafe_unretained LcityTableViewController *city = self;
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        [city setupWithcellJsonsight];
        
        [city performSelector:@selector(doneWithview:) withObject:refreshView afterDelay:2.0];
    };
    [header beginRefreshing];
    _header = header;

}
- (void)doneWithview:(MJRefreshBaseView *)refreshView
{
    [self.tableView reloadData];
    [refreshView endRefreshing];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (y <= -ImageHight) {
        CGRect frame = _imageview.frame;
        CGRect frame1 = _buttonback.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _imageview.frame = frame;
        frame1.origin.y = y+20;
        _buttonback.frame = frame1;
        
    }
    if (y > -ImageHight) {
        CGRect frame = _headerView.frame;
        CGRect frame1 = _buttonback.frame;
        frame.origin.y = y;
        _headerView.frame = frame;
        frame1.origin.y = y+20;
        _buttonback.frame = frame1;
    }
    if (y >= 0) {
       [UIView animateWithDuration:0.5 animations:^{
           _headerView.alpha = 1.0;
       }];
    }else{
        _headerView.alpha = 0;
    }
    if (y < -ImageHight - 70) {
        LphotoCollectionViewController *photo = [[[LphotoCollectionViewController alloc] init] autorelease];
        photo.type = self.model.type;
        photo.ID = self.model.ID;
        photo.tableblock = ^(void){
        
        };
       // photo.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:photo animated:YES completion:nil];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.LcityArray.count;
}




//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell11"];
    [cell setUpwithmodel:self.LcityArray[indexPath.row]];
    return cell;
}



//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}


#pragma mark ------点击cell跳转到景点详情界面--------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ScenicViewController *scenic = [[[ScenicViewController alloc] init] autorelease];
    scenic.model = self.LcityArray[indexPath.row];
    scenic.titleName = [self.LcityArray[indexPath.row] name];
    scenic.resfresh = ^(NSInteger index2){
        //NSLog(@"无效回调");
    };
    [self presentViewController:scenic animated:NO completion:nil];
}

//图片的点击方法实现;
- (void)imageTouch{
    LphotoCollectionViewController *photo = [[[LphotoCollectionViewController alloc] init] autorelease];
    photo.type = self.model.type;
    photo.ID = self.model.ID;
    photo.tableblock = ^(void){
    };
    photo.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:photo animated:YES completion:nil];
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
