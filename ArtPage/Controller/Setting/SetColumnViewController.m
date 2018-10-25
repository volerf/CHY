//
//  SetColumnViewController.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/8.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "SetColumnViewController.h"

@interface SetColumnViewController ()

@end

@implementation SetColumnViewController

- (void)viewDidLoad {
    super.isAButton = YES;
    [super viewDidLoad];
    
    //设置父类相关属性
    [self.centerBtn setImage:UIImageFile(@"btn_关闭", @"png") forState:UIControlStateNormal];
    [self.centerBtn addTarget:self action:@selector(backSettingView) forControlEvents:UIControlEventTouchUpInside];
    
    //初始化视图
    _setColumnView = [[SetColumnView alloc] init];
    [self.view addSubview:_setColumnView];
    [_setColumnView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.width.equalTo(SCREENWIDTH);
        make.height.equalTo(SCREENHEIGHT - 54);
    }];
    
    
}

- (void)backSettingView
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
