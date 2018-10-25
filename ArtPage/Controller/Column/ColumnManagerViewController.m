//
//  ColumnManagerViewController.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/26.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "ColumnManagerViewController.h"
#import "SixItemView.h"
#import "ColumnViewController.h"
#import "AboutViewController.h"
#import "NewsViewController.h"
#import "ShareViewController.h"
#import "UserObj.h"

@interface ColumnManagerViewController ()

@property(nonatomic,strong) SixItemView *sixView;

@property(nonatomic,strong) NSArray *norArr;
@property(nonatomic,strong) NSArray *selArr;

@end

@implementation ColumnManagerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(_sixView != nil)
    {
        [_sixView removeFromSuperview];
        [self initSixItemView];
    }
}

- (void)viewDidLoad {
    //设置父视图基本属性
    super.isAButton = YES;
    [super viewDidLoad];
    
    [self.centerBtn setImage:UIImageFile(@"btn_关闭", @"png") forState:UIControlStateNormal];
    [self.centerBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //添加六个按钮
    _norArr = @[@"btn_公开作品", @"btn_非公开作品", @"btn_关于", @"btn_日志", @"btn_推送主页链接", @"btn_切换英文"];
    _selArr = @[@"btn_公开作品_d", @"btn_非公开作品_d", @"btn_关于_d", @"btn_日志_d", @"btn_推送主页链接", @"btn_切换中文"];
    
    //初始化六按钮视图
    [self initSixItemView];
    
}

//初始化按钮视图
- (void)initSixItemView
{
    _sixView = [[SixItemView alloc] initWithNormalArr:_norArr andSelectArr:_selArr];
    [self.view addSubview:_sixView];
    [_sixView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-100);
        make.centerX.equalTo(self.view.centerX);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, 175));
    }];
    
    //实现六按钮视图的block完成点击事件
    __weak typeof(self) weakSelf = self;
    self.sixView.columnBlock = ^(UIButton *btn) {
        switch (btn.tag) {
            case 0: {
                if(!btn.selected)
                {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            } break;
            case 1: {
                if(!btn.selected)
                {
                    ColumnViewController *cvc = [[ColumnViewController alloc] init];
                    cvc.isPublic = @"NO";
                    [weakSelf.navigationController pushViewController:cvc animated:YES];
                }
            } break;
            case 2: {
                if(!btn.selected)
                {
                    AboutViewController *avc = [[AboutViewController alloc] init];
                    [weakSelf.navigationController pushViewController:avc animated:YES];
                }
            } break;
            case 3: {
                if(!btn.selected)
                {
                    NewsViewController *nvc = [[NewsViewController alloc] init];
                    [weakSelf.navigationController pushViewController:nvc animated:YES];
                }
            } break;
            case 4: {
                ShareViewController *svc = [[ShareViewController alloc] init];
                UserObj *user = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:@"UserObj" andSelectCondition:@{@"UserID":getUD(@"UserID")}][0];
                NSString *urlStr = [NSString stringWithFormat:@"http://%@.artp.cc/cover",user.ACCOUNT_DOMAIN];
                svc.shareUrl = urlStr;
                [weakSelf.navigationController pushViewController:svc animated:YES];
            } break;
            case 5: {
                if(btn.selected)
                {
                    setUD(@"中文", @"语言");
                    btn.selected = NO;
                }
                else{
                    setUD(@"英文", @"语言");
                    btn.selected = YES;
                }
                NSMutableArray *arr = [weakSelf.navigationController.viewControllers mutableCopy];
                ColumnViewController *cvc = [[ColumnViewController alloc] init];
                cvc.isPublic = @"YES";
                arr[0] = cvc;
                weakSelf.navigationController.viewControllers = arr;
            } break;
        }
    };
}

- (void)backBtnClick
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
