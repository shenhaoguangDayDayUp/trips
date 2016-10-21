//
//  MineViewController.m
//  Travel
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "CollectedViewController.h"
#import "SDImageCache.h"
#import "DXAlertView.h"
#import "AboutMineViewController.h"
#import "LoginViewController.h"
#import "StrategyDataBase.h"
#import "UMSocial.h"
@interface MineViewController () <UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UILabel *user;
@property (nonatomic, retain) UIImageView *userImg;
@property (nonatomic, retain) UIButton *photoBtn;
@end

@implementation MineViewController
-(void)dealloc{
    [_user release];
    [_tableView release];
    [_userImg release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackColor;
    [self setUpTableView];
    [[StrategyDataBase shareDataBase] creatSightListListWithName];
}

- (void)viewDidAppear:(BOOL)animated {
    if ([[StrategyDataBase shareDataBase] isLogin]) {
        _photoBtn.userInteractionEnabled = YES;
        
        if ([self isHaveUsrIcon]) {
            [self readImageFile];
        }else{
            __block MineViewController *mineVC = self;
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                ////NSLog(@"SnsInformation is %@",response.data);
                NSString *usrPic = response.data[@"profile_image_url"];
                if (usrPic == nil) {
                    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToTencent completion:^(UMSocialResponseEntity *response) {
                        NSString *quUsrPic = response.data[@"profile_image_url"];
                        [mineVC.userImg sd_setImageWithURL:[NSURL URLWithString:quUsrPic]];
                    }];
                }else{
                    [mineVC.userImg sd_setImageWithURL:[NSURL URLWithString:usrPic]];
                }
            }];
        }
        
        _user.text = [[StrategyDataBase shareDataBase] getUserName];
    }else{
        _user.text = @"未登录";
    }
    [self.tableView reloadData];
    [super viewDidAppear:YES];
}

#pragma mark --------------- 创建tableView ----------------

- (void)setUpTableView {
    
    if ([[StrategyDataBase shareDataBase] isLogin]) {
        [self addLoginOutBtn];
    }
    
    self.tableView = [[[UITableView alloc] initWithFrame:kBounds style:(UITableViewStylePlain)] autorelease];
    self.tableView.backgroundColor = kBackColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"mineCell"];

    BlurImageView *backView = [[BlurImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 180.0 / kAutoWidth)];
    backView.userInteractionEnabled = YES;
    
    TapimageView *headerView = [[TapimageView alloc] initWithFrame:(CGRectMake(0, 0, kWidth, 180.0 / kAutoWidth)) target:self action:@selector(tapUserImg)];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.userInteractionEnabled = YES;
    [backView addSubview:headerView];
    
    _userImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, 80.0 / kAutoWidth, 80.0 / kAutoWidth))];
    _userImg.center = CGPointMake(kWidth / 2, 80.0 / kAutoWidth);
    _userImg
    .backgroundColor = kPinkColor;
    _userImg.layer.masksToBounds = YES;
    _userImg.layer.borderColor = [kBackColor CGColor];
    _userImg.layer.borderWidth = 3;
    _userImg.layer.cornerRadius = _userImg.bounds.size.height / 2;
    [headerView addSubview:_userImg];
    
    _photoBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _photoBtn.frame = CGRectMake(0, 0, 80.0 / kAutoWidth, 80.0 / kAutoWidth);
    _photoBtn.center = CGPointMake(kWidth / 2, 80.0 / kAutoWidth);
    _photoBtn.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.100];
    _photoBtn.layer.masksToBounds = YES;
    _photoBtn.layer.cornerRadius = _userImg.bounds.size.height / 2;
    _photoBtn.layer.borderColor = [kBackColor CGColor];
    _photoBtn.layer.borderWidth = 3;
    _photoBtn.userInteractionEnabled = NO;
    [_photoBtn addTarget:self action:@selector(clickPhotoBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [headerView addSubview:_photoBtn];
    
    _user = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, kWidth, 15.0 / kAutoWidth))];
    _user.center = CGPointMake(kWidth / 2, 150.0 / kAutoWidth);    

    _user.textColor = [UIColor whiteColor];
    _user.font = [UIFont systemFontOfSize:16.0];
    _user.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:_user];
    
    self.tableView.tableHeaderView = backView;
    [backView release];
    [headerView release];
    
}

- (void)readImageFile {
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *filePath = [docPath stringByAppendingPathComponent:@"saveFore.png"];
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
    
    _userImg.image = image;
    
    [image release];
}

//判断头像文件是否存在
- (BOOL)isHaveUsrIcon {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"saveFore.png"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

- (void)clickPhotoBtn {
    //NSLog(@"系统相册");
    // 创建从底部弹出的提醒视图
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"提醒" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    
    sheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [sheet showInView:self.view];
}

#pragma mark - actionSheet的代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // 调用系统相机
    if (buttonIndex == 0) {
        //1. 有系统相机
        if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            // 允许进行修改布局, 进行编辑
            picker.allowsEditing = YES;
            
            // 指定图片的数据来源, 来源自相机
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            // 模态弹出
            [self presentViewController:picker animated:YES completion:nil];
            // 如果没有相机则提醒用户, 当前设备没有相机
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备没有摄像头" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }
        // 调用系统相册
    } else if (buttonIndex == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            
            // 指定数据来源为系统相册
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
}

#pragma mark -- 拍摄完成或者从相册中选择完成之后执行的方法

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    _userImg.image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self saveUserImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveUserImage {
    
    NSData *imagedata = UIImagePNGRepresentation(_userImg.image);
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *filePath = [docPath stringByAppendingPathComponent:@"saveFore.png"];
    
    // 写入文件, 写入时会判断图片是否存在, 如果存在, 覆盖掉之前存的图片, 如果不存在, 创建一个的图片
    [imagedata writeToFile:filePath atomically:YES];
    
}

- (void)cancelClick {
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"确定要注销？" leftButtonTitle:nil rightButtonTitle:@"确定"];
    [alert show];
    alert.rightBlock = ^() {
        [[StrategyDataBase shareDataBase] deleteAllCollection];
        [[StrategyDataBase shareDataBase] logOut];
        _photoBtn.userInteractionEnabled = NO;
        [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
            ////NSLog(@"response is %@",response);
        }];
        
        //NSLog(@"%d", [[StrategyDataBase shareDataBase] isLogin]);
        //NSLog(@"注销成功");
        if (![[StrategyDataBase shareDataBase] isLogin]) {
            self.navigationItem.rightBarButtonItem = nil;
            _user.text = @"未登录";
            _userImg.image = [UIImage imageNamed:nil];
        }
    };
    alert.dismissBlock = ^() {
        //NSLog(@"Do something interesting after dismiss block");
    };
}

- (void)tapUserImg {
    if ([[StrategyDataBase shareDataBase] isLogin]) {
        
        //NSLog(@"已登录");
        
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.loginBlock = ^(void){
            [self addLoginOutBtn];
            __block MineViewController *mineVC = self;
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                ////NSLog(@"SnsInformation is %@",response.data);
                NSString *usrPic = response.data[@"profile_image_url"];
                if (usrPic == nil) {
                    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToTencent completion:^(UMSocialResponseEntity *response) {
                        NSString *quUsrPic = response.data[@"profile_image_url"];
                        [mineVC.userImg sd_setImageWithURL:[NSURL URLWithString:quUsrPic]];
                    }];
                }else{
                    [mineVC.userImg sd_setImageWithURL:[NSURL URLWithString:usrPic]];
                }
                
                [mineVC readImageFile];
            }];
            _photoBtn.userInteractionEnabled = YES;
            _user.text = [[StrategyDataBase shareDataBase] getUserName];
        };
        [self presentViewController:loginVC animated:YES completion:nil];
        [loginVC release];
    }
}

//注销按钮
- (void)addLoginOutBtn {
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:(UIBarButtonItemStylePlain) target:self action:@selector(cancelClick)];
    cancelBtn.tintColor = kPinkColor;
    self.navigationItem.rightBarButtonItem = cancelBtn;
    [cancelBtn release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
        switch (indexPath.section) {
            case 0:
                cell.text.text = @"我的收藏";
                break;
            case 1:
                cell.text.text = @"夜间模式";
                cell.arrowImg.alpha = 0;
                cell.DNswitch.alpha = 1;
                [cell.DNswitch addTarget:self action:@selector(switchAction:) forControlEvents:(UIControlEventValueChanged)];
                break;
            case 2:
                cell.text.text = [NSString stringWithFormat:@"清除缓存（%@）", [self getFileSize]];
                break;
            case 3:
                cell.text.text = @"服务条款";
                break;
                
            default:
                break;
        }
    
    
    return cell;
}

- (void)switchAction:(UISwitch *)switchBtn {
    BOOL isButtonOn = [switchBtn isOn];
    if (isButtonOn) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"switchOn" object:nil];
    }else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"switchOff" object:nil];
    }
}

//获取缓存的大小

- (NSString *)getFileSize {
    NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
    //
    NSString * currentVolum = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];
    return currentVolum;
}

//计算出大小
- (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0 / kAutoWidth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0 / kAutoWidth;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[[UIView alloc] init] autorelease];
    view.backgroundColor = kBackColor;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if ([[StrategyDataBase shareDataBase] isLogin]) {            
            CollectedViewController *collectedVC = [[CollectedViewController alloc] init];
            collectedVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:collectedVC animated:YES];
            [collectedVC release];
        }else{
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            //登录之后执行
            loginVC.loginBlock = ^(void){
                [self addLoginOutBtn];
                [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                    ////NSLog(@"SnsInformation is %@",response.data);
                    NSString *usrPic = response.data[@"profile_image_url"];
                    [_userImg sd_setImageWithURL:[NSURL URLWithString:usrPic]];
                }];
                _photoBtn.userInteractionEnabled = YES;
                _user.text = [[StrategyDataBase shareDataBase] getUserName];
                
                CollectedViewController *collectedVC = [[CollectedViewController alloc] init];
                collectedVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:collectedVC animated:YES];
                [collectedVC release];
            };
            
            [self presentViewController:loginVC animated:YES completion:nil];
            [loginVC release];
        }
        
        
    } else if (indexPath.section == 2) {
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"确定要清除缓存？" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [alert show];
        alert.rightBlock = ^() {
            [[SDImageCache sharedImageCache] clearDisk];
            [self.tableView reloadData];
            //NSLog(@"right button clicked");
        };
        alert.dismissBlock = ^() {
            //NSLog(@"Do something interesting after dismiss block");
        };
        
    } else if (indexPath.section == 3) {
        AboutMineViewController *aboutVc = [[AboutMineViewController alloc] init];
        aboutVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutVc animated:YES];
        [aboutVc release];
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
