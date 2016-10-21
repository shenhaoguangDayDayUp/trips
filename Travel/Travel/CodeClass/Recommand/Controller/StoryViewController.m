//
//  StoryViewController.m
//  Travel
//
//  Created by 申浩光 on 15/9/23.
//  Copyright (c) 2015年  All rights reserved.
//

#import "StoryViewController.h"
#import "StoryScrollView.h"
#import "StoryTableViewCell.h"
#import "HeaderTableViewCell.h"
#import "DetailList.h"

@interface StoryViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) StoryScrollView *storySrollView;
@property (nonatomic, retain) UITableView *tableView;
// 下拉图片
@property (nonatomic, retain) UIImageView *zoomImgView;

// 作者头像
@property (nonatomic, retain) UIImageView *userImgView;

// 标题名视图
@property (nonatomic, retain) TapimageView *titleView;
// 小标题
@property (nonatomic, retain) UILabel *titleName;
@property (nonatomic, retain) UILabel *timeName;
@property (nonatomic, retain) UIImageView *arrowImg;

@property (nonatomic, retain) UIView *navigationBar;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat nowY;

@end

@implementation StoryViewController

- (void)dealloc {
    [_storySrollView release];
    [_zoomImgView release];
    [_userImgView release];
    [_titleView release];
    [_titleName release];
    [_arrowImg release];
    [_timeName release];
    [_photo release];
    [_name release];
    [_text release];
    [_userName release];
    [_avatar_l release];
    [_date_added release];
    [_dayCout release];
    [_storyCount release];
    [_detailArr release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpStorySrcollView];
//    [self setUpButtomView];
}


#pragma mark --------------- 视图布局 ----------------
- (void)setUpStorySrcollView {
    
    _tableView = [[UITableView alloc]initWithFrame:kBounds style:UITableViewStylePlain];
    _tableView.contentInset = UIEdgeInsetsMake(240.0 / kAutoWidth, 0, 10, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kBackColor;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[StoryTableViewCell class] forCellReuseIdentifier:@"StoryCell"];
    [_tableView registerClass:[HeaderTableViewCell class] forCellReuseIdentifier:@"headerCell"];
    
    
    // 初始化scrollView
    _storySrollView = [[StoryScrollView alloc] initWithFrame:(CGRectMake(0, 0, kWidth, 351.0 / kAutoWidth))];
    _storySrollView.delegate = self;
    _storySrollView.backgroundColor = [UIColor colorWithRed:0.969 green:0.949 blue:0.902 alpha:1.000];
    
    
    // 表头赋值
    _storySrollView.titleLabel.text = self.name;
    _storySrollView.userLabel.text = [NSString stringWithFormat:@"by %@", self.userName];
    // 修改时间
    NSString *btime = [self.date_added substringWithRange:NSMakeRange(0, 10)];
    NSString *beginTime = [btime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    NSString *endTime = [self.date_added substringWithRange:NSMakeRange(11, 5)];
    _storySrollView.dateShow.text = [NSString stringWithFormat:@"%@", beginTime];
    _storySrollView.journeyShow.text = [NSString stringWithFormat:@"%@天", self.dayCout];
    _storySrollView.time.text = [NSString stringWithFormat:@"%@ %@", beginTime, endTime];
    
    _titleView = [[TapimageView alloc] initWithFrame:CGRectMake(0, _storySrollView.Bline.frame.origin.y + 1, kWidth, 70 / kAutoHight) target:self action:@selector(backClick)];
    _titleView.backgroundColor = kBackColor;
    
    _arrowImg = [[UIImageView alloc] initWithFrame:(CGRectMake(kWidth - 25, 27.5, 10, 15))];
    _arrowImg.image = [UIImage imageNamed:@"poi_arrow_icon@2x"];
    [_titleView addSubview:_arrowImg];
    
    _titleName = [[UILabel alloc] initWithFrame:(CGRectMake(10, 20, kWidth - 40, 15))];
    _titleName.font = [UIFont boldSystemFontOfSize:16.0];
    _titleName.numberOfLines = 0;
    _titleName.text = self.text;
    _titleName.textColor = kPinkColor;
    [_titleName sizeToFit];
    [_titleView addSubview:_titleName];
   
    _timeName = [[UILabel alloc] initWithFrame:(CGRectMake(10, _titleName.frame.origin.y + _titleName.bounds.size.height + 10, kWidth - 20, 10))];
    _timeName.font = [UIFont systemFontOfSize:14.0];
    _timeName.textColor = [UIColor grayColor];
    _timeName.text = endTime;
    [_titleView addSubview:_timeName];
    
    _arrowImg.center = CGPointMake(kWidth - 20, (_titleName.frame.origin.y + _titleName.bounds.size.height) / 2);
    
    CGRect frame1 = _titleView.frame;
    frame1.size.height = _titleName.bounds.size.height + _titleName.frame.origin.y;
    _titleView.frame = frame1;
    [_storySrollView addSubview:_titleView];
    
    CGRect frame = _storySrollView.frame;
    frame.size.height = _titleView.frame.origin.y + _titleView.bounds.size.height + 20;
    _storySrollView.frame = frame;
    
    _tableView.tableHeaderView = _storySrollView;
    
    
    // 拉伸的图片
    _zoomImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"小老鼠.jpg"]];
    _zoomImgView.frame = CGRectMake(0, -240.0 / kAutoWidth, kWidth, 240.0 / kAutoWidth);
    // UIViewContentModeScaleAspectFill 高度改变宽度也跟着改变
    _zoomImgView.contentMode = UIViewContentModeScaleAspectFill;
    _zoomImgView.autoresizesSubviews = YES;
    _zoomImgView.clipsToBounds = YES;
    [_zoomImgView sd_setImageWithURL:[NSURL URLWithString:self.photo] placeholderImage:[UIImage imageNamed:@"trip_edit_cover_default"]];
    [_tableView addSubview:_zoomImgView];
    
    
    // 作者头像
    _width = 80.0;
    _userImgView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, _width, _width))];
    _userImgView.center = CGPointMake(kWidth / 2, 0);
    _userImgView.backgroundColor = [UIColor whiteColor];
    _userImgView.layer.masksToBounds = YES;
    _userImgView.layer.cornerRadius = _userImgView.bounds.size.height / 2;
    _userImgView.layer.borderWidth = 3;
    _userImgView.layer.borderColor = [kBackColor CGColor];
    _userImgView.clipsToBounds = YES;
    _userImgView.transform = CGAffineTransformMakeScale(1, 1);
    [_userImgView sd_setImageWithURL:[NSURL URLWithString:self.avatar_l] placeholderImage:nil];
    [_tableView addSubview:_userImgView];

    
    // navigationBar的显隐性设置
    _navigationBar = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, kWidth, 64))];
    _navigationBar.backgroundColor = kPinkColor;
    _navigationBar.alpha = 0;
    [self.view addSubview:_navigationBar];
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBtn.frame = CGRectMake(15, 30, 28, 28);
    [backBtn setImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:(UIControlStateNormal)];
    [backBtn setTintColor:kBackColor];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
}

- (void)backClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    
    NSLog(@"%f",y);
    CGFloat sx = y / (- y - 240.0 / kAutoWidth);
    if (y <= -240.0 / kAutoWidth) {
        _userImgView.transform = CGAffineTransformMakeScale(1, 1);
        CGRect frame = _zoomImgView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _zoomImgView.frame = frame;
        _navigationBar.alpha = 0;
    } else {
        if (sx > 1) {
            _userImgView.transform = CGAffineTransformMakeScale(1, 1);
        } else {
            _userImgView.transform = CGAffineTransformMakeScale(sx, sx);
        }
    }
    
    if (y > 0) {
        _navigationBar.alpha = y / 260.0;
    } else {
        _navigationBar.alpha = 0;
    }
    
}



#pragma mark --------------- tableView代理 ----------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.detailArr.count;

}

// 自定义cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    StoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell" forIndexPath:indexPath];
    DetailList *model = self.detailArr[indexPath.row];
    [cell setValueWithModel:model];

    return cell;

}

// 自定义cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(10, 10, kWidth - 20, 10))];
    DetailList *model = self.detailArr[indexPath.row];
    label.text = model.text;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15.0];
    [label sizeToFit];
    CGFloat height = label.frame.origin.y + label.bounds.size.height;
    CGFloat imgHeight = (kWidth - 20) * [model.photo_height floatValue] / [model.photo_width floatValue];
    [label release];
    return height + imgHeight + 10;

}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        UIView *view = [[[UIView alloc] initWithFrame:kBounds] autorelease];
//        return view;
//    } else {
//        UIView *view = [[[UIView alloc] initWithFrame:kBounds] autorelease];
//        view.backgroundColor = kPinkColor;
//        UIView *headerLine = [[UIView alloc] initWithFrame:(CGRectMake(15, 41, kWidth - 30, 0.5))];
//        headerLine.backgroundColor = [UIColor blackColor];
//        headerLine.alpha = 0.5;
//        [view addSubview:headerLine];
//        return view;
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return 0;
//    } else {
//        return 80;
//    }
//}
#pragma mark --------------- 底部视图 ----------------
//- (void)setUpButtomView {
//
//    UIView *commentView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, kWidth, 70 / kAutoHight))];
//    commentView.backgroundColor = kBackColor;
//    
//    UITextField *text = [[UITextField alloc] initWithFrame:(CGRectMake(15, commentView.frame.origin.y, kWidth - 30, 60 / kAutoHight))];
//    text.backgroundColor = kBackColor;
//    text.placeholder = @"添加评论...";
//    text.delegate = self;
//    text.font = [UIFont systemFontOfSize:13.0];
//    [commentView addSubview:text];
//    
//    UIButton *commit = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    commit.frame = CGRectMake(kWidth - 15 / kAutoHight - 40 / kAutoHight, text.frame.origin.y + 15, 40 / kAutoHight, 30 / kAutoHight);
//    commit.backgroundColor = kPinkColor;
//    [commit addTarget:self action:@selector(commitComment) forControlEvents:(UIControlEventTouchUpInside)];
//    [commentView addSubview:commit];
//    
//    self.tableView.tableFooterView = commentView;
//    [commentView release];
//    [text release];
//}
//
//- (void)commitComment {
//    NSLog(@"提交评论");
//}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    return [textField resignFirstResponder];
//}

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
