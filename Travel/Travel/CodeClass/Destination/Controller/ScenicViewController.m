//
//  ScenicViewController.m
//  Travel
//
//  Created by lanou3g on 15/9/22.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "ScenicViewController.h"
#define ImageHight 300.0f
#import "LScenicTableViewCell.h"
#import "LdetallViewController.h"
#import "PositionViewController.h"
#import "Lcityimageview.h"
#import "LphotoCollectionViewController.h"
#import "UMSocial.h"
#import "StrategyDataBase.h"
#import "LoginViewController.h"
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
typedef void (^ChangeCollecColor)(void);

@interface ScenicViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>

@property (nonatomic,retain) UITableView *tableview;
@property (nonatomic,retain) NSMutableArray *dicArray;
@property (nonatomic,retain) Lcityimageview *picimage;
//@property (nonatomic,retain) UIImageView *image;
//@property (nonatomic,retain) UIImageView *image1;
@property (nonatomic, copy) ChangeCollecColor changeCollectionColor;


@end

@implementation ScenicViewController
-(void)dealloc{
    [_picimage release];
    //[_image release];
    //[_image1 release];
    [_tableview release];
    [_dicArray release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleName;
    self.view.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];

    [self setupWithJson];
    
    
    // Do any additional setup after loading the view.

}

- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    self.resfresh(self.index);
}


//懒加载
- (NSMutableArray *)dicArray{
    if (!_dicArray) {
        self.dicArray = [NSMutableArray array];
    }
    return _dicArray;
}

- (SightModel *)model{
    if (!_model) {
        _model = [[SightModel alloc] init];
    }
    return _model;
}

//数据解析
- (void)setupWithJson{

        NSString *url = [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/",self.model.type,self.model.ID];
   
        [LORequestManger GET:url success:^(id response) {
            NSDictionary *dic = (NSDictionary *)response;
            for (NSDictionary *data1 in dic[@"hottest_places"]) {
                self.model = [SightModel shareJsonWithDictionary:data1];
            }
            [self.model setValuesForKeysWithDictionary:dic];
           // [self.dicArray addObject:self.model];
            [self setUpWithJsontableview];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //NSLog(@"%@",error);
        }];


}

#pragma mark ------界面布局搭建--------
- (void)setUpWithJsontableview{
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview = [[UITableView alloc] initWithFrame:kBounds style:UITableViewStylePlain];
    _tableview.contentInset = UIEdgeInsetsMake(ImageHight, 0, 0, 0);
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = kBackColor;
    [self.view addSubview:_tableview];
    
    self.picimage = [[Lcityimageview alloc] initWithFrame:CGRectMake(0, -ImageHight, kWidth, ImageHight) target:self action:@selector(imageTouch)];
    _picimage.userInteractionEnabled = YES;
    _picimage.likeLabel.text = @"";
    _picimage.beenLabel.text = @"";
    if (_model.photo == nil) {
        _picimage.image = [UIImage imageNamed:@"trip_edit_cover_default@2x"];
    }else{
    NSArray *arr = [_model.photo componentsSeparatedByString:@"?"];
    [_picimage sd_setImageWithURL:[NSURL URLWithString:arr[0]]];
    }
    _picimage.contentMode = UIViewContentModeScaleAspectFill;

    _picimage.clipsToBounds = YES;
    //picimage.backgroundColor = [UIColor orangeColor];
    [_tableview addSubview:_picimage];
    
    
    UIView *titleview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 200)];
    //titleview.backgroundColor = [UIColor orangeColor];
    titleview.backgroundColor = kBackColor;
    UILabel *titleName = [[UILabel alloc] initWithFrame:CGRectMake(0, 50/kAutoHight, kWidth, 50)];
    titleName.font = [UIFont boldSystemFontOfSize:20];
    titleName.textAlignment = 1;
    titleName.text = self.model.name;
    [titleview addSubview:titleName];
    [titleName release];
    
    UILabel *recomm = [[UILabel alloc] initWithFrame:CGRectMake(40.0/kAutoWidth, titleName.frame.origin.y + 50 + 20, kWidth - 2*(40.0/kAutoWidth) , 70)];
    recomm.textAlignment = 1;
    recomm.numberOfLines = 0;
    recomm.font = [UIFont systemFontOfSize:14];
    recomm.text = self.model.recommended_reason;
    [titleview addSubview:recomm];
    [recomm release];
    
    _tableview.tableHeaderView = titleview;
    [titleview release];
    
//    _image = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth-60)/2,  - 30/kAutoHight, 60, 60)];
//    //image.backgroundColor = [UIColor orangeColor];
//    if (_model.photo == nil) {
//        _image.image = [UIImage imageNamed:@"trip_edit_cover_default@2x"];
//    }else{
//        NSArray *arr = [_model.photo componentsSeparatedByString:@"?"];
//        [_image sd_setImageWithURL:[NSURL URLWithString:arr[0]]];
//    }
//    _image.layer.masksToBounds = YES;
//    _image.layer.cornerRadius = 60/2;
//    _image.layer.borderWidth = 2;
//    _image.layer.borderColor = [[UIColor whiteColor]CGColor];
//    _image.autoresizingMask= UIViewAutoresizingFlexibleTopMargin;
//    [titleview addSubview:_image];
//    
//    _image1 = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth-60)/2, ImageHight - 30, 60, 60)];
//    //image.backgroundColor = [UIColor orangeColor];
//    if (_model.photo == nil) {
//        _image1.image = [UIImage imageNamed:@"trip_edit_cover_default@2x"];
//    }else{
//        NSArray *arr = [_model.photo componentsSeparatedByString:@"?"];
//        [_image1 sd_setImageWithURL:[NSURL URLWithString:arr[0]]];
//    }
//    _image1.layer.masksToBounds = YES;
//    _image1.layer.cornerRadius = 60/2;
//    _image1.layer.borderWidth = 2;
//    _image1.layer.borderColor = [[UIColor whiteColor]CGColor];
//    _image1.autoresizingMask= UIViewAutoresizingFlexibleTopMargin;
//    [_picimage addSubview:_image1];
    
    //收藏按钮
    _collectbutton = [UIButton buttonWithType:(UIButtonTypeInfoLight)];
    _collectbutton.frame = CGRectMake(_backbutton.frame.origin.x + (280/kAutoWidth), kHeight/(667/20), 30, 30);
    [_collectbutton setImage:[UIImage imageNamed:@"like_13x12_sl@2x"] forState:(UIControlStateNormal)];
    [_collectbutton addTarget:self action:@selector(collect) forControlEvents:(UIControlEventTouchUpInside)];
    _collectbutton.tintColor = kBrownColor;
    [self.view addSubview:_collectbutton];
    
    
    //分享按钮
    _sharebutton = [UIButton buttonWithType:(UIButtonTypeInfoLight)];
    _sharebutton.frame = CGRectMake(_collectbutton.frame.origin.x + (45/kAutoWidth), kHeight/(667/20), 30, 30);
    [_sharebutton setImage:[UIImage imageNamed:@"tripview_share_highlight@2x"] forState:(UIControlStateNormal)];
    [_sharebutton addTarget:self action:@selector(share) forControlEvents:(UIControlEventTouchUpInside)];
    _sharebutton.tintColor = kBrownColor;
    [self.view addSubview:_sharebutton];
    
    
    //返回按钮
    _backbutton = [UIButton buttonWithType:(UIButtonTypeInfoLight)];
    _backbutton.frame = CGRectMake(kWidth/(375/10.0), kHeight/(667/20.0), 30, 30);
    [_backbutton setImage:[UIImage imageNamed:@"add_new_poi_back_btn"] forState:(UIControlStateNormal)];
    [_backbutton addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    _backbutton.tintColor = kBrownColor;
    [self.view addSubview:_backbutton];
    
    
    
    self.changeCollectionColor = ^(void){
        if ([[StrategyDataBase shareDataBase] isfavorite:_model.name]) {
            _collectbutton.tintColor = kPinkColor;
        }else{
            _collectbutton.tintColor = kBrownColor;
        }
    
    };
    if ([[StrategyDataBase shareDataBase] isLogin]) {
      self.changeCollectionColor();
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (y < -ImageHight) {
        CGRect frame = _picimage.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _picimage.frame = frame;
    }
    if (y < -ImageHight - 70) {
        LphotoCollectionViewController *photo = [[LphotoCollectionViewController alloc] init];
        photo.type = self.model.type;
        photo.ID = self.model.ID;
        photo.tableblock = ^(void){
            [self setUpWithJsontableview];
            //NSLog(@"回调成功");
        };
        //photo.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:photo animated:YES completion:nil];
        [photo release];
    }

}

- (void)deleteclick{
    //NSLog(@"删除");

}


//收藏按钮的点击实现方法
- (void)collect{
    if ([[StrategyDataBase shareDataBase] isLogin]) {
        [self collectway];
        
    }else{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        //登录之后执行
        loginVC.loginBlock = ^(void){
            
            if ([[StrategyDataBase shareDataBase] isfavorite:_model.name]) {//如果已经收藏过，只改变收藏按钮颜色
                self.changeCollectionColor();
                
            }else{//没收藏过
                [self collectway];
            }
        };
        [self presentViewController:loginVC animated:YES completion:nil];
        [loginVC release];
    }

    
}

- (void)collectway{
    [[StrategyDataBase shareDataBase] creatSightListListWithName];
    BOOL isFavorite = [[StrategyDataBase shareDataBase] isfavorite:_model.name];
    //NSLog(@"--------%d",isFavorite);
    if (isFavorite) {
        [[StrategyDataBase shareDataBase] deleteSightModelWithname:_model.name];
        
    }else{
        [[StrategyDataBase shareDataBase] insertModel:_model];
        
    }
     self.changeCollectionColor();

}

//分享按钮的点击实行方法
- (void)share{
    //NSArray *photourl = [self.photo componentsSeparatedByString:@"?"];
    //NSURL *url = [NSURL URLWithString:self.model.path];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_model.photo]];
    //[UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskPortraitUpsideDown];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55fd0ce3e0f55a305b002070"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageWithData:data]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToSms,UMShareToDouban,UMShareToEmail,nil]
                                       delegate:self];
}

//图片的点击实现方法
-(void)imageTouch{

    
    LphotoCollectionViewController *photo = [[LphotoCollectionViewController alloc] init];
    photo.type = self.model.type;
    photo.ID = self.model.ID;
    photo.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    photo.tableblock = ^(void){
        //NSLog(@"无效回调");
    };
//    [self addChildViewController:photo];
//     [self transitionWithType:@"rippleEffect" WithSubtype:kCATransitionFromRight];
//    [self.view addSubview:photo.view];
    [self presentViewController:photo animated:YES completion:nil];
    [photo release];
}

#pragma CATransition动画实现
- (void)transitionWithType:(NSString *)type WithSubtype:(NSString *) subtype
{
    CATransition *animation = [CATransition animation];
    
    animation.duration = 1;
    
    animation.type = type;
    
    if (subtype != nil) {
        animation.subtype = subtype;
    }
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [self.view.layer addAnimation:animation forKey:@"animation"];
    
}

#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:1.0f animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *str = @"mycell";
    LScenicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[LScenicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str] autorelease];
    }
    NSArray *arr = @[@"概况",@"地址",@"行动路线",@"开放时间",@"联系方式"];
 if(self.model.arrival_type == nil){
    self.model.arrival_type = @"";
 }
  if (self.model.opening_time == nil){
 self.model.opening_time = @"";
 }
    NSArray *scenicArray = @[self.model.Description,self.model.address,self.model.arrival_type,self.model.opening_time,self.model.tel];
  
    cell.nameLabel .text= arr[indexPath.row];
    cell.scenicLabel.text = scenicArray[indexPath.row];
    cell.iconbutton.tintColor = kBrownColor;
    
    if (indexPath.row == 0) {
        cell.iconbutton.tag = 0;
        [cell.iconbutton setImage:[UIImage imageNamed:@"poi_arrow_icon@2x"] forState:(UIControlStateNormal)];
        [cell.iconbutton addTarget:self action:@selector(buttonclick:) forControlEvents:(UIControlEventTouchUpInside)];
    }else if(indexPath.row == 2){
        
        cell.iconbutton.tag = 2;
        [cell.iconbutton setImage:[UIImage imageNamed:@"poi_arrow_icon@2x"] forState:(UIControlStateNormal)];
        [cell.iconbutton addTarget:self action:@selector(buttonclick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    }else if(indexPath.row == 1){
        
        cell.iconbutton.tag = 1;
        [cell.iconbutton setImage:[UIImage imageNamed:@"poi_arrow_icon@2x"] forState:(UIControlStateNormal)];
        [cell.iconbutton addTarget:self action:@selector(buttonclick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    }
    else{
        [cell.iconbutton setImage:nil forState:(UIControlStateNormal)];
        [cell.iconbutton addTarget:self action:nil forControlEvents:(UIControlEventTouchUpInside)];
    
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  80;
}


//按钮的点击方法;
- (void)buttonclick:(UIButton *)button{
    LdetallViewController *detall = [[LdetallViewController alloc] init];
    if (button.tag == 0) {
        
        detall.str = self.model.Description;
        
    }else if (button.tag == 2){
        
        detall.str = self.model.arrival_type;

    }else if (button.tag == 1){
        PositionViewController *position = [[PositionViewController alloc] init];
        position.Position = self.model.Location;
       position.name = self.model.name;
        [self presentViewController:position animated:NO completion:nil];
        [position release];
        //[self setupMaplocation];
    }
    
    detall.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:detall animated:YES completion:nil];
    [detall release];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
         LdetallViewController *detall = [[LdetallViewController alloc] init];
        detall.str = self.model.Description;
        detall.photostr = self.model.photo;
        //detall.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:detall animated:YES completion:nil];
        [detall release];
    }else if (indexPath.row == 2){
         LdetallViewController *detall = [[LdetallViewController alloc] init];
        detall.str = self.model.arrival_type;
        detall.photostr = self.model.photo;
        //detall.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:detall animated:YES completion:nil];
        [detall release];
    }else if (indexPath.row == 1){
        PositionViewController *position = [[PositionViewController alloc] init];
        position.Position = self.model.Location;
        position.name = self.model.name;
        [self presentViewController:position animated:NO completion:nil];
        [position release];
        //[self setupMaplocation];
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
