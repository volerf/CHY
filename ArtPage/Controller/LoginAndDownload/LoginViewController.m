//
//  LoginViewController.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "LoginViewController.h"
#import "DownloadViewController.h"
#import "CHYDatabaseManager.h"
#import "UserObj.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
//视图将要出现时隐藏导航栏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    //是否显示返回按钮，登录和变更账户的区别
    if(self.navigationController.viewControllers.count == 1)
    {
        self.loginView.backBtn.hidden = YES;
    }
    else{
        self.loginView.backBtn.hidden = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.loginView.backBtn.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建manager对象
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:ArtPageURL];
    
    _loginView = [[LoginView alloc] init];
    if(getUD(@"userName") && getUD(@"pwd"))
    {
        _loginView.userName.text = getUD(@"userName");
        _loginView.pwd.text = getUD(@"pwd");
    }
    [_loginView.loginBtn addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.backBtn addTarget:self action:@selector(backTopViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginView];
    [_loginView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, SCREENHEIGHT));
    }];
}

//点击登录
- (void)userLogin
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.loginView.userName.text,@"UserName", @"CheckUser", @"Method", self.loginView.pwd.text, @"Password", nil];
    [_manager GET:@"?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *infoDic = (NSDictionary *)responseObject;
        if(infoDic[@"ErrMessage"] == [NSNull null])
        {
            setUD(self.loginView.userName.text, @"userName");       //保存账号密码
            setUD(self.loginView.pwd.text, @"pwd");
            setUD(infoDic[@"data"][0][@"UserID"], @"UserID");
            //字典转模型
            UserObj *user = [CommonClass customModel:@"UserObj" ToArray:infoDic[@"data"]][0];
            //保存到数据库
            NSMutableArray *arr = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:@"UserObj" andSelectCondition:@{@"UserID":user.UserID}];
            if(![arr count])
            {
                [[CHYDatabaseManager shareDataBaseManager] insertWithTableName:@"UserObj" andModel:user];
            }
            
            //登录成功让键盘消失
            [self.loginView.userName resignFirstResponder];
            [self.loginView.pwd resignFirstResponder];
            //跳转页面
            DownloadViewController *dvc = [[DownloadViewController alloc] init];
            [self.navigationController pushViewController:dvc animated:YES];
            
        }
        else{
            UIAlertController *alert = [UIAlertController alertCancelWithTitle:@"登录失败" andMessage:infoDic[@"ErrMessage"] andCancelInfo:@"确定"];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        UIAlertController *alert = [UIAlertController alertCancelWithTitle:@"登录失败" andMessage:@"请检查网络连接" andCancelInfo:@"确定"];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}
//点击返回
- (void)backTopViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end





















