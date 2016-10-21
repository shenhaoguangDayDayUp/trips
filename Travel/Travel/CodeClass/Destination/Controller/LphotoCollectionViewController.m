//
//  LphotoCollectionViewController.m
//  Travel
//
//  Created by lanou3g on 15/10/4.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LphotoCollectionViewController.h"
#import "LphotoCollectionViewCell.h"
#import "LPhotoimageViewController.h"

@interface LphotoCollectionViewController ()<MJRefreshBaseViewDelegate>
{
    
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}
@property (nonatomic,retain) NSMutableArray *photoArray;

@end

@implementation LphotoCollectionViewController
- (id)init{
    UICollectionViewFlowLayout *layout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.itemSize = CGSizeMake((kWidth - 40)/3, (kWidth - 40)/3);
    return [self initWithCollectionViewLayout:layout];
}
static NSString * const reuseIdentifier = @"Cell";
-(void)dealloc{
    [_header free];
    [_footer free];
    [super dealloc];
}
//懒加载
- (NSMutableArray *)photoArray{
    if (!_photoArray) {
        _photoArray = [[NSMutableArray alloc] init];
    }
    return _photoArray;
}

//数据解析
- (void)setupWithJsonPhoto{
    NSString *url = [NSString stringWithFormat:@"http://api.breadtrip.com//destination/place/%@/%@/photos/?gallery_mode=1&count=18&start=%@&sign=eecdbb64a7d2b093f66b60da94f1fbd7",self.type,self.ID,self.count];
    //NSLog(@"%@",url);
    [LORequestManger GET:url success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        self.count = dic[@"next_start"];
        for (NSDictionary *data in dic[@"items"]) {
            LPhotoModel *model = [LPhotoModel shareJsonWithDictionary:data];
            [model setValuesForKeysWithDictionary:data[@"photo_info"]];
            // [model setValuesForKeysWithDictionary:data[@"poi"]];
            [self.photoArray addObject:model];
        }
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@",error);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = @0;
    [self setupWithJsonPhoto];
    //注册
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = YES;
 //   self.collectionView.frame = CGRectMake(0, 64, 0, kHeight - 64);
    self.collectionView.contentInset = UIEdgeInsetsMake(64, 0, 20, 0);
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , kWidth, 64)];
    headerview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerview];
    
    UIButton *backbutton = [UIButton buttonWithType:(UIButtonTypeInfoLight)];
    backbutton.frame = CGRectMake(kWidth/(375/10.0), kHeight/(667/20.0), 30, 30);
    [backbutton setImage:[UIImage imageNamed:@"add_new_poi_back_btn"] forState:(UIControlStateNormal)];
    [backbutton addTarget:self action:@selector(backbutton) forControlEvents:(UIControlEventTouchUpInside)];
    backbutton.tintColor = kBrownColor;
    [headerview addSubview:backbutton];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    nameLabel.text = @"图片";
    nameLabel.textAlignment = 1;
    nameLabel.font = [UIFont systemFontOfSize:18];
    [headerview addSubview:nameLabel];
    [headerview release];
    [nameLabel release];
   // [self.collectionView registerClass:[LphotoCollectionViewCell class] forCellWithReuseIdentifier:@"mycell"];
    
    
    //上拉刷新
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.collectionView;
    footer.delegate = self;
    _footer = footer;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[LphotoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}
- (void)doneWithView:(MJRefreshBaseView *)refreshView{
//刷新表格
    [self.collectionView reloadData];
    //[refreshView endRefreshing];
}

//进入刷新状态
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        [self setupWithJsonPhoto];
        [refreshView endRefreshing];
    }
    [self performSelector:@selector(doneWithView:) withObject:self afterDelay:2.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backbutton{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    self.tableblock();
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete method implementation -- Return the number of items in the section
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LphotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
   [cell setUpdetinationModel:self.photoArray[indexPath.row]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LPhotoimageViewController *photo = [[LPhotoimageViewController alloc] init];
    photo.array = self.photoArray;
    photo.count = indexPath.row;
    photo.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:photo animated:YES completion:nil];
    [photo release];
    
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
