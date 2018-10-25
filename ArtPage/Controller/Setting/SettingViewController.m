//
//  SettingViewController.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/26.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "SettingViewController.h"
#import "DownloadViewController.h"
#import "LoginViewController.h"
#import "SetColumnViewController.h"
#import "AboutArtPageViewController.h"
#import "UserObj.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    super.isAButton = YES;
    [super viewDidLoad];
    //设置父类相关属性
    [self.centerBtn setImage:UIImageFile(@"btn_关闭", @"png") forState:UIControlStateNormal];
    [self.centerBtn addTarget:self action:@selector(backTopController) forControlEvents:UIControlEventTouchUpInside];
    
    //初始化视图
    _settingView = [[SettingView alloc] init];
    [self.view addSubview:_settingView];
    [_settingView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(0);
        make.width.equalTo(SCREENWIDTH);
        make.height.equalTo(SCREENHEIGHT - 54);
    }];
    __block typeof(self) weakSelf = self;
    _settingView.sixItem.columnBlock = ^(UIButton *btn) {
        switch (btn.tag) {
            case 0:{
                DownloadViewController *dvc = [[DownloadViewController alloc] init];
                [weakSelf.navigationController pushViewController:dvc animated:YES];
            } break;
            case 1:{
                LoginViewController *lvc = [[LoginViewController alloc] init];
                [weakSelf.navigationController pushViewController:lvc animated:YES];
            } break;
            case 2:{
                SetColumnViewController *svc = [[SetColumnViewController alloc] init];
                [weakSelf.navigationController pushViewController:svc animated:YES];
            } break;
            case 3:{
                UserObj *user = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:@"UserObj" andSelectCondition:@{@"UserID":getUD(@"UserID")}][0];
                NSString *urlStr = [NSString stringWithFormat:@"http://%@.artp.cc/cover",user.ACCOUNT_DOMAIN];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{} completionHandler:nil];
            } break;
            case 4: break;
            case 5:{
                AboutArtPageViewController *aavc = [[AboutArtPageViewController alloc] init];
                [weakSelf.navigationController pushViewController:aavc animated:YES];
            } break;
        }
    };
    
}

- (void)backTopController
{
    [self.navigationController popViewControllerAnimated:YES];
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
