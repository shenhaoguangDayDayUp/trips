//
//  LoginViewController.m
//  Travel
//
//  Created by 申浩光 on 15/10/5.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegistViewController.h"
#import "StrategyDataBase.h"
#import "DXAlertView.h"
#import "AppDelegate.h"
#import "UMSocial.h"
#import "SVProgressHUD.h"

@interface LoginViewController () <UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kPinkColor;
    [self setUpLoginView];


}

- (void)setUpLoginView {
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBtn.frame = CGRectMake(15, 30, 25, 25);
    [backBtn setImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:(UIControlStateNormal)];
    [backBtn setTintColor:kBackColor];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
    LoginView *loginView = [[LoginView alloc] initWithFrame:(CGRectMake(40, 120, kWidth - 80, kHeight)) delegate:self action:@selector(clickButton:)];
    [self.view addSubview:loginView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    UITextField *text1 = (UITextField *)[self.view viewWithTag:5000];
    UITextField *text2 = (UITextField *)[self.view viewWithTag:6000];
    if ([text1 isFirstResponder] == YES) {
        [text2 becomeFirstResponder];
    } else if ([text2 isFirstResponder] == YES) {
        [text2 resignFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)clickButton:(UIButton *)button {
    switch (button.tag) {
        case 10000:{
            
            //NSLog(@"登陆");
            UITextField *text1 = (UITextField *)[self.view viewWithTag:5000];

            UITextField *text2 = (UITextField *)[self.view viewWithTag:6000];
            if ([self validateEmail:text1.text]) {
                if (text2.text.length >= 6) {
                    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
                    [SVProgressHUD setForegroundColor:kBackColor];
                    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0.886 green:0.271 blue:0.353 alpha:0.160]];
                    [SVProgressHUD setFont:[UIFont systemFontOfSize:13]];
                    [SVProgressHUD showWithStatus:@"登录中~"];
                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                    manager.requestSerializer = [AFJSONRequestSerializer serializer];
                    NSDictionary *param = @{@"email":text1.text, @"pwd":text2.text};
                    NSString *url=@"http://oneexpress.duapp.com/api/login";
                    
                    [LORequestManger POST:url params:param success:^(id response) {
                        NSDictionary *dic = (NSDictionary *)response;
                        if ([dic[@"success"] isEqualToNumber:@1]) {
                            [[StrategyDataBase shareDataBase] loginWithUserID:dic[@"data"][@"object"][@"_id"] uerName:dic[@"data"][@"object"][@"name"]];
                            //NSLog(@"%d", [[StrategyDataBase shareDataBase] isLogin]);
                            [SVProgressHUD dismiss];
                            [self dismissViewControllerAnimated:YES completion:nil];
                            self.loginBlock();
                        }else{
                            [SVProgressHUD dismiss];
                            DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:dic[@"data"][@"msg"] leftButtonTitle:nil rightButtonTitle:@"确定"];
                            [alert show];
                            [alert release];
                        }
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        //NSLog(@"%@", operation.responseString);
                    }];
                }else{
                    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"密码必须6位以上！" leftButtonTitle:nil rightButtonTitle:@"确定"];
                    [alert show];
                    [alert release];
                }
            }else{
                DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"请输入合法的邮箱" leftButtonTitle:nil rightButtonTitle:@"确定"];
                [alert show];
                [alert release];
            }
            
            break;
        }
        case 20000:
            //NSLog(@"微博");
        {
            UMSocialSnsPlatform *snsPlatPorm = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            snsPlatPorm.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                
                //          获取微博用户名、uid、token等
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                    
                    //NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    [[StrategyDataBase shareDataBase] loginWithUserID:snsAccount.usid uerName:snsAccount.userName];
                    [self dismissViewControllerAnimated:YES completion:nil];
                     self.loginBlock();
                    
                }});

            break;
        }
        case 30000:
            //NSLog(@"空间");
        {
            UMSocialSnsPlatform *snsPlatPormTencent = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent];
            
            snsPlatPormTencent.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                //          获取微博用户名、uid、token等
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToTencent];
                    
                    //NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    
                    [[StrategyDataBase shareDataBase] loginWithUserID:snsAccount.usid uerName:snsAccount.userName];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    self.loginBlock();
                    
                }});
            
            
            break;
        }
        case 50000:
        {
            //NSLog(@"注册");
            RegistViewController *registVC = [[RegistViewController alloc] init];
            [self presentViewController:registVC animated:YES completion:nil];
            [registVC release];
            break;
        }
        default:
            break;
    }

}

//判断邮箱格式是否正确
- (BOOL)validateEmail:(NSString *)email {
    //NSLog(@"判断邮箱格式");
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isMatch = [emailTest evaluateWithObject:email];
    if (!isMatch) {
        
        return NO;
    }
    return YES;
}


- (void)clickBack {
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
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
