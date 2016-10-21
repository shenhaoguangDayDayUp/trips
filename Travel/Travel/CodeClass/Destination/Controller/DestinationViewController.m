//
//  DestinationViewController.m
//  Travel
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "DestinationViewController.h"
#import "LORequestManger.h"
#import "LdestinationCollectionViewCell.h"
#import "LdestinaCollectionReusableView.h"
#import "MorecountryViewController.h"
#import "SVProgressHUD.h"
#import "LcityTableViewController.h"
#import "AppDelegate.h"
#import "ScenicViewController.h"
@interface DestinationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

 @property (nonatomic,retain) UICollectionView *destionationCollevtion;

@property (nonatomic,retain) NSMutableArray *modelArray;
//标题数组
@property (nonatomic,retain) NSMutableArray *titleArray;

@end

@implementation DestinationViewController
- (void)dealloc{
    [_modelArray release];
    [_titleArray release];
    [super dealloc];
}


//标题数组
- (NSMutableArray *)titleArray{
    if (!_titleArray) {
      self.titleArray = [NSMutableArray array];
    }
    return _titleArray;
}


//懒加载
- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        self.modelArray  = [NSMutableArray array];
    }
    return _modelArray;
}


#pragma mark ------数据解析--------
//目的地数据解析
- (void)setUpJsonDetination{
[LORequestManger GET:kDetination success:^(id response) {
    NSDictionary *dic = (NSDictionary *)response;
    for (NSDictionary *data in dic[@"elements"]) {
        LdestinationModel *destModel = [LdestinationModel shareJsonWithDictionary:data];
        [self.titleArray addObject:destModel.title];
        NSMutableArray *allArray = [NSMutableArray array];
        for (NSDictionary *arrdic in data[@"data"])
        {
            LdestinationModel *model = [LdestinationModel shareJsonWithDictionary:arrdic];
           // [destModel setValuesForKeysWithDictionary:arrdic];
            [allArray addObject:model];
            
        }
        [self.modelArray addObject:allArray];
    }
    //利用界面搭建刷新数据
    [_destionationCollevtion reloadData];
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //NSLog(@"%@",error);
}];


}



#pragma mark ------程序运行入口--------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //搭建风火轮
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    //[SVProgressHUD setForegroundColor:[UIColor colorWithRed:0.882 green:0.839 blue:0.729 alpha:1.000]];
    [SVProgressHUD setForegroundColor:kPinkColor];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0.6588 green:0.5686 blue:0.3686 alpha:0.2]];
    //[SVProgressHUD setBackgroundColor:kPinkColor];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:13]];
    [SVProgressHUD showWithStatus:@"加载中~"];
    [SVProgressHUD dismissWithDelay:2];
    [self setUpCollectionView];
    [self setUpJsonDetination];
   self.view.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
    //[self setUpJsonDetination];
  
    
    // Do any additional setup after loading the view.
}






#pragma mark ------创建集合视图--------
//集合视图创建
- (void)setUpCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //行间距
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    //item大小
    layout.itemSize = CGSizeMake((kWidth - 30)/2, (kWidth - 30)/2);
    //创建集合视图
    _destionationCollevtion = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight ) collectionViewLayout:layout];
    _destionationCollevtion.backgroundColor = [UIColor clearColor];
    //遵循代理
    _destionationCollevtion.delegate = self;
    _destionationCollevtion.dataSource = self;
    _destionationCollevtion.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);

    [self.view addSubview:_destionationCollevtion];
    
    
    //注册cell
    [_destionationCollevtion registerClass:[LdestinationCollectionViewCell class] forCellWithReuseIdentifier:@"mycell"];
    [_destionationCollevtion registerClass:[LdestinaCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell"];
   
    [layout release];
}

//cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 4) {
        return 2;
    }else{
        return 4;
    }

}

//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.titleArray.count;
}


//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LdestinationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
  //  NSArray *array = self.modelArray[indexPath.section];

    [cell setUpdetinationModel:self.modelArray[indexPath.section][indexPath.row]];
    
    return cell;

}



//返回标头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    LdestinaCollectionReusableView *reusabcell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell" forIndexPath:indexPath];
    reusabcell.titleLabel.text = self.titleArray[indexPath.section];
    reusabcell.Morebutton.tintColor = kBrownColor;
    if (indexPath.section == 2||indexPath.section == 5||indexPath.section == 6) {
        [reusabcell.Morebutton setImage:[UIImage imageNamed:@"poi_arrow_icon@2x"] forState:(UIControlStateNormal)];
        [reusabcell.Morebutton addTarget:self action:@selector(Morecountry:) forControlEvents:(UIControlEventTouchUpInside)];
        if (indexPath.section == 2) {
            reusabcell.Morebutton.tag = 2;
        }else if(indexPath.section == 5){
          reusabcell.Morebutton.tag = 5;
        }else{
            reusabcell.Morebutton.tag = 6;
        }
    }else{
    [reusabcell.Morebutton setImage:nil forState:(UIControlStateNormal)];
    [reusabcell.Morebutton addTarget:self action:nil forControlEvents:(UIControlEventTouchUpInside)];
    }
    return reusabcell;
}


//自定义标头高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kWidth, 55.0 / kAutoWidth);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//更多图标的点击方法
- (void)Morecountry:(UIButton *)button{
    MorecountryViewController *moreEurope = [[[MorecountryViewController alloc] init] autorelease];
    if (button.tag == 2) {
        //NSLog(@"欧洲国家");
        moreEurope.country = [NSString stringWithFormat:@"欧洲国家"];
        
    }else if(button.tag == 5){
        moreEurope.country = [NSString stringWithFormat:@"亚洲国家"];
    }else if(button.tag == 6){
        moreEurope.country = [NSString stringWithFormat:@"国内城市"];
    }
    
    [self animationWithView:self.navigationController.view WithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
    [self.navigationController pushViewController:moreEurope animated:NO];
}

//cell的点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LdestinationModel *model = self.modelArray[indexPath.section][indexPath.row];
    if ([model.type isEqualToString:@"5"]) {
        ScenicViewController *scenic = [[ScenicViewController alloc] init];
        scenic.model = self.modelArray[indexPath.section][indexPath.row];
        scenic.titleName = [self.modelArray[indexPath.section][indexPath.row] name];
        scenic.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        scenic.resfresh = ^(NSInteger index3){
            //NSLog(@"回调无效");
        };
        [self presentViewController:scenic animated:YES completion:nil];
        [scenic release];
    }else{
        LcityTableViewController *city = [[LcityTableViewController alloc] init];
        city.model = self.modelArray[indexPath.section][indexPath.row];
        city.titleName = [self.modelArray[indexPath.section][indexPath.row] name];
 
                //[self addChildViewController:city];
               // [self transitionWithType:@"rippleEffect" WithSubtype:kCATransitionFromRight];
        [self animationWithView:self.navigationController.view WithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
                //[self.view addSubview:city.view];
        city.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        //NSLog(@"%@ %@",city.model.ID,city.model.type);
        [self presentViewController:city animated:YES completion:nil];
        [city release];
    }
}
#pragma CATransition动画实现
//- (void)transitionWithType:(NSString *)type WithSubtype:(NSString *) subtype
//{
//    CATransition *animation = [CATransition animation];
//    
//    animation.duration = 1;
//    
//    animation.type = type;
//    
//    if (subtype != nil) {
//        animation.subtype = subtype;
//    }
//    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
//    
//    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
//    
//}
#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:1.0f animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
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
