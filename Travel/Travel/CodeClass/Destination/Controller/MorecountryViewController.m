//
//  MorecountryViewController.m
//  Travel
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "MorecountryViewController.h"
#import "LdestinationCollectionViewCell.h"
#import "LORequestManger.h"
#import "CountryModel.h"
#import "LcityTableViewController.h"
#import "AppDelegate.h"
@interface MorecountryViewController ()
@property (nonatomic,retain) UICollectionView *countCollectionview;
//更多国家数组
@property (nonatomic,retain) NSMutableArray *countryArray;
//数据请求接口
@property (nonatomic,retain) NSString *url;
@end

@implementation MorecountryViewController
-(void)dealloc{
    [_titleName release];
    [_url release];
    [_countCollectionview release];
    [_countryArray release];
    [_country release];
    [super dealloc];
}


//懒加载
- (NSMutableArray *)countryArray{
    if (!_countryArray) {
        self.countryArray = [NSMutableArray array];
    }
    return _countryArray;
}


//数据分析
- (void)setUpJsonCountry{
    if ([self.country isEqualToString:@"欧洲国家"]) {
        self.url = [NSString stringWithFormat:@"%@",kMoreCountry];
    }else if([self.country isEqualToString:@"亚洲国家"]){
        self.url = [NSString stringWithFormat:@"%@",kMoreYCountry];
    }else if ([self.country isEqualToString:@"国内城市"]){
        self.url = [NSString stringWithFormat:@"%@",kMoreLcity];
    }
    
[LORequestManger GET:self.url success:^(id response) {
    NSDictionary *dic = (NSDictionary *)response;
    self.titleName = dic[@"title"];
    for (NSDictionary *data in dic[@"data"]) {
        CountryModel *country = [CountryModel shareJsonWithDictionary:data];
        [self.countryArray addObject:country];
    }
    [self setUpCollectionView];
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    NSLog(@"%@",error);
}];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
    [self setUpNavigation];
    [self setUpJsonCountry];
    
    // Do any additional setup after loading the view.
}


- (void)setUpNavigation{
    self.navigationItem.title = self.country;
    //导航控制器的标题
    //给导航控制器添加一个左按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_nav_back_button"] style:UIBarButtonItemStyleDone target:self action:@selector(leftbutton)];
    left.tintColor = kBrownColor;
    self.navigationItem.leftBarButtonItem = left;

}

//导航控制器左按钮的点击方法
- (void)leftbutton{
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark ------创建集合视图--------
//集合视图创建
- (void)setUpCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //行间距
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //item大小
    layout.itemSize = CGSizeMake((kWidth - 30)/2, (kWidth - 30)/2);
    //创建集合视图
    _countCollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64) collectionViewLayout:layout];
    _countCollectionview.backgroundColor = [UIColor clearColor];
    //遵循代理
    _countCollectionview.delegate = self;
    _countCollectionview.dataSource = self;
    [self.view addSubview:_countCollectionview];
    [layout release];
    _countCollectionview.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
    //注册cell
    [_countCollectionview registerClass:[LdestinationCollectionViewCell class] forCellWithReuseIdentifier:@"mycell"];
    
}


//cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.countryArray.count;

}


//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}


//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    LdestinationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];

    [cell setUpdetinationModel:self.countryArray[indexPath.row]];
    return cell;
}

//cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LcityTableViewController *Lcity = [[LcityTableViewController alloc] init];
    Lcity.model = self.countryArray[indexPath.row];
    Lcity.titleName = [self.countryArray[indexPath.row] name];
    [self.navigationController pushViewController:Lcity animated:YES];
    [Lcity release];
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
