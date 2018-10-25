//
//  NewsDetailViewController.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/8.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    super.isAButton = YES;
    [super viewDidLoad];
    
    //设置父类的相关属性
    self.ArtPageImgView.hidden = YES;
    [self.centerBtn setImage:UIImageFile(@"btn_返回", @"png") forState:UIControlStateNormal];
    [self.centerBtn addTarget:self action:@selector(backNewsViewController) forControlEvents:UIControlEventTouchUpInside];
    
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
        _titleLabel.text = @"日志";
    }
    else{
        _titleLabel.text = @"New";
    }
    
    //加载视图
    _contentView = [[NewsContentView alloc] initWithNew: _newsObj];
    [self.view addSubview:_contentView];
    [_contentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(65);
        make.left.equalTo(18);
        make.width.equalTo(SCREENWIDTH - 36);
        make.height.equalTo(SCREENHEIGHT - 119);
    }];
}

- (void)backNewsViewController
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
