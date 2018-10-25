//
//  AboutViewController.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/27.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "AboutViewController.h"
//#import "AboutObj.h"
#import "AboutView.h"
#import "SettingViewController.h"

@interface AboutViewController ()

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) AboutView *aboutView;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    super.isAButton = NO;
    [super viewDidLoad];
    
    //设置父类相关属性
    self.ArtPageImgView.hidden = YES;
    [self.leftBtn setImage:[UIImage imageNamed:@"btn_栏目"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(backColumn) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:[UIImage imageNamed:@"btn_设置"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(goSetting) forControlEvents:UIControlEventTouchUpInside];
    
    //初始化title
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor lightGrayColor];
    _titleLabel.font = [UIFont systemFontOfSize:15.0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLabel];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.left.equalTo(0);
        make.width.equalTo(SCREENWIDTH);
        make.height.equalTo(45);
    }];
    if([getUD(@"语言") isEqual:@"中文"])
    {
        _titleLabel.text = @"关于";
    }
    else{
        _titleLabel.text = @"About";
    }
    
    //初始化ScrollView
    _aboutView = [[AboutView alloc] init];
    [self.view addSubview:_aboutView];
    [_aboutView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom).offset(5);
        make.left.equalTo(0);
        make.width.equalTo(SCREENWIDTH);
        make.height.equalTo(SCREENHEIGHT - 65 - 54);
    }];
}

- (void)backColumn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)goSetting
{
    SettingViewController *svc = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
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
