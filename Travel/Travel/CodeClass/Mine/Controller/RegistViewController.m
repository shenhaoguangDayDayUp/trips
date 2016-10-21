//
//  RegistViewController.m
//  Travel
//
//  Created by 申浩光 on 15/10/5.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistView.h"
#import "DXAlertView.h"
#import "SVProgressHUD.h"
@interface RegistViewController () <UITextFieldDelegate>

@property (nonatomic, retain) RegistView *registView;

@end

@implementation RegistViewController

- (void)dealloc {
    [_registView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kPinkColor;
    [self setUpRegistView];
}

- (void)setUpRegistView {
    
    self.registView = [[RegistView alloc] initWithFrame:(CGRectMake(30, 180 / kAutoHight, kWidth - 60, kHeight - 180 / kAutoHight)) delegate:self action:@selector(clickButton:)];
    [self.view addSubview:self.registView];
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBtn.frame = CGRectMake(15, 30, 25, 25);
    [backBtn setImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:(UIControlStateNormal)];
    [backBtn setTintColor:kBackColor];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
}

- (void)clickButton:(UIButton *)button {
    UITextField *text1 = (UITextField *)[self.view viewWithTag:6666];
    UITextField *text2 = (UITextField *)[self.view viewWithTag:7777];
    UITextField *text3 = (UITextField *)[self.view viewWithTag:9999];
    UITextField *text4 = (UITextField *)[self.view viewWithTag:8888];
    //NSLog(@"注册ch");
    if (![text1.text isEqualToString:@""]) {
        if ([self validateEmail:text2.text]) {
            if (text3.text.length >= 6 && [text3.text isEqualToString:text4.text]) {
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                NSDictionary *param = @{@"email":text2.text, @"pwd":text3.text, @"name":text1.text};
                NSString *url=@"http://oneexpress.duapp.com/api/save/user";
                
                //注册中 风火轮
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
                [SVProgressHUD setForegroundColor:kBackColor];
                [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0.886 green:0.271 blue:0.353 alpha:0.160]];
                [SVProgressHUD setFont:[UIFont systemFontOfSize:13]];
                [SVProgressHUD showWithStatus:@"注册中~"];
                
                [LORequestManger POST:url params:param success:^(id response) {
                    NSDictionary *dic = (NSDictionary *)response;
                    if ([dic[@"success"] isEqualToNumber:@1]) {
                        
                        //关闭风火轮
                        [SVProgressHUD dismiss];                        
                        
                        [self dismissViewControllerAnimated:YES completion:^{
                            DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"注册成功！" leftButtonTitle:nil rightButtonTitle:@"确定"];
                            [alert show];
                            [alert release];
                        }];
                        
                    }else{
                        
                        //关闭风火轮
                        [SVProgressHUD dismiss];

                        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:dic[@"data"][@"msg"] leftButtonTitle:nil rightButtonTitle:@"确定"];
                        [alert show];
                        [alert release];
                    }
                    //NSLog(@"%@", dic);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    //NSLog(@"%@", operation.responseString);
                }];
            }else{
                
                DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"密码长度大于6位且两次输入要一致！" leftButtonTitle:nil rightButtonTitle:@"确定"];
                [alert show];
                [alert release];
            }            
        }else{
            
            DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"请输入合法的邮箱" leftButtonTitle:nil rightButtonTitle:@"确定"];
            [alert show];
            [alert release];
        }
    }else{
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"用户名不能为空！" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [alert show];
        [alert release];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
//    UITextField *text1 = (UITextField *)[self.view viewWithTag:6666];
//    UITextField *text2 = (UITextField *)[self.view viewWithTag:7777];
//    UITextField *text3 = (UITextField *)[self.view viewWithTag:9999];
//    UITextField *text4 = (UITextField *)[self.view viewWithTag:8888];
//
//    if ([text1 isFirstResponder] == YES) {
//        [text2 becomeFirstResponder];
//    } else if ([text2 isFirstResponder] == YES) {
//        [text3 becomeFirstResponder];
//    } else if ([text3 isFirstResponder] == YES) {
//        [text4 resignFirstResponder];
//    }
    
    if ([_registView.user isFirstResponder] == YES) {
        [_registView.email becomeFirstResponder];
    } else if ([_registView.email isFirstResponder] == YES) {
        [_registView.password becomeFirstResponder];
    } else {
         [_registView.repwd resignFirstResponder];
    }
    
    return NO;
    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)clickBack {
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
