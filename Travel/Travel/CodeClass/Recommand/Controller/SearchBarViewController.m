//
//  SearchBarViewController.m
//  Travel
//
//  Created by 申浩光 on 15/10/7.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "SearchBarViewController.h"
#import "SearchBarCollectionViewCell.h"
#import "SearchCollectionReusableView.h"
#import "SearchModel.h"
#import "LcityTableViewController.h"
@interface SearchBarViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectView;
@property (nonatomic, retain) NSMutableArray *overseasArr;
@property (nonatomic, retain) NSMutableArray *countryArr;

@end

@implementation SearchBarViewController

- (void)dealloc {
    [_collectView release];
    [_overseasArr release];
    [_countryArr release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSearchBarView];
    [self reloadSearchBarData];
}

- (NSMutableArray *)overseasArr {
    if (!_overseasArr) {
        _overseasArr = [[NSMutableArray alloc] init];
    }
    return _overseasArr;
}

- (NSMutableArray *)countryArr {
    if (!_countryArr) {
        _countryArr = [[NSMutableArray alloc] init];
    }
    return _countryArr;
}

- (void)reloadSearchBarData {
    
    [LORequestManger GET:kEverydayUrl success:^(id response) {
        NSDictionary *dict = (NSDictionary *)response;
        for (NSDictionary *search in dict[@"search_data"]) {
            if ([search[@"title"] isEqualToString:@"国外热门目的地"]) {
                
                for (NSDictionary *elements in search[@"elements"]) {
                    SearchModel *oversea = [SearchModel shareJasonWithDictionary:elements];
                    [self.overseasArr addObject:oversea];
                }
                
            } else {
                
                for (NSDictionary *countryDic in search[@"elements"]) {
                    SearchModel *country = [SearchModel shareJasonWithDictionary:countryDic];
                    [self.countryArr addObject:country];
                }
            }
        }
        [self.collectView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@", error);
    }];

}


- (void)setUpSearchBarView {
    
    // 设置collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 13;
    layout.itemSize = CGSizeMake((kWidth - 70) / 3, 25.0 / kAutoWidth);
    layout.sectionInset = UIEdgeInsetsMake(20, 25, 20, 25);
    _collectView = [[UICollectionView alloc] initWithFrame:kBounds collectionViewLayout:layout];
    _collectView.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    [self.view addSubview:_collectView];
    
    [_collectView registerClass:[SearchBarCollectionViewCell class] forCellWithReuseIdentifier:@"searchCell"];
    [_collectView registerClass:[SearchCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"searchHead"];
    [layout release];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.overseasArr.count;
    } else {
        return self.countryArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchBarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        SearchModel *model = self.overseasArr[indexPath.row];
        cell.area.text = model.name;
        
    } else {
        
        SearchModel *model = self.countryArr[indexPath.row];
        cell.area.text = model.name;
        
    }
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SearchCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"searchHead" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        reusableView.title.text = @"国外热门目的地";
        reusableView.Tline.alpha = 0;
    } else if (indexPath.section == 1) {
        reusableView.title.text = @"国内热门目的地";
    }
    return reusableView;
}

// 设置表头的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(kWidth, 50);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchBarCollectionViewCell *cell = (SearchBarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.areaImg.backgroundColor = kPinkColor;
    cell.areaImg.alpha = 0.1;
    [UIView animateWithDuration:0.3 animations:^{
        cell.areaImg.backgroundColor = kBackColor;
        cell.areaImg.alpha = 1;
    }];
    
    LcityTableViewController *city = [[LcityTableViewController alloc] init];
    if (indexPath.section == 0) {
        
        SearchModel *oversea = self.overseasArr[indexPath.row];
        city.model.ID = oversea.ID;
        city.model.type = [oversea.type stringValue];
        //NSLog(@"%@,%@", [oversea.type stringValue],oversea.ID);
        
        
    } else if (indexPath.section == 1) {
        
        SearchModel *country = self.countryArr[indexPath.row];
        city.model.ID = country.ID;
        city.model.type = [country.type stringValue];
        //NSLog(@"%@,%@", [country.type stringValue],country.ID);
    }
   // city.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:city animated:YES completion:nil];
    [city release];
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
