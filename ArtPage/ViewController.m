//
//  ViewController.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = bgColor;
    self.navigationController.navigationBar.hidden = YES;
    //头部图片
    _ArtPageImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 85, 80)];
    _ArtPageImgView.image = UIImageFile(@"share", @"png");
    [self.view addSubview:_ArtPageImgView];
    
    //底部背景
    UILabel *bgLabel = [[UILabel alloc] init];
    bgLabel.backgroundColor = [UIColor colorWithRed:30.0 / 255 green:30.0 / 255 blue:30.0 / 255 alpha:0.9];
    [self.view addSubview:bgLabel];
    [bgLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(0);
        make.width.equalTo(SCREENWIDTH);
        make.height.equalTo(54);
    }];
    
    //判断是几个按钮
    if(_isAButton)
    {
        //1个按钮
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _centerBtn.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_centerBtn];
        [_centerBtn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.centerX);
            make.bottom.equalTo(-10);
            make.size.equalTo(CGSizeMake(22, 37));
        }];
        _leftBtn.hidden = YES;
        _rightBtn.hidden = NO;
    }
    else{
        //2个按钮，左边
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _leftBtn.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_leftBtn];
        [_leftBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(98);
            make.bottom.equalTo(-10);
            make.size.equalTo(CGSizeMake(22, 37));
        }];
        //右边
        _rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_rightBtn];
        [_rightBtn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-98);
            make.bottom.equalTo(-10);
            make.size.equalTo(CGSizeMake(22, 37));
        }];
        
        _centerBtn.hidden = YES;
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
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
