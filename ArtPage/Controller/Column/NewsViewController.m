//
//  NewsViewController.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/27.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "NewsViewController.h"
#import "SettingViewController.h"
#import "NewsObj.h"
#import "UserObj.h"
#import "ShareViewController.h"
#import "NewsDetailViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置父视图相关属性
    self.view.backgroundColor = bgColor;
    self.ArtPageImgView.hidden = YES;
    //栏目按钮
    [self.leftBtn setImage:UIImageFile(@"btn_栏目", @"png") forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(columnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //设置按钮
    [self.rightBtn setImage:UIImageFile(@"btn_设置", @"png") forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(setingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //准备数据
    _newsArr = [[NSMutableArray alloc] initWithCapacity:1];
    _newsArr = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:@"NewsObj" andSelectCondition:@{@"UserID":getUD(@"UserID")}];
    
    //加载视图
    _newsListView = [[ColumnView alloc] init];
    [self.view addSubview:_newsListView];
    [_newsListView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, SCREENHEIGHT));
    }];
    if([getUD(@"语言") isEqual:@"中文"])
    {
        _newsListView.titleLabel.text = @"日志";
    }
    else{
        _newsListView.titleLabel.text = @"News";
    }
    
    //设置TableView的相关属性
    _newsListView.aTableView.delegate = self;
    _newsListView.aTableView.dataSource = self;
    _newsListView.aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //去掉TableView分割线
    //注册TableView单元格样式
    [_newsListView.aTableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"News"];
    
    //把columnView放到self.view的最下面
    [self.view sendSubviewToBack:_newsListView];
    
}

#pragma make  -  TableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arr = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:@"NewsObj" andSelectCondition:@{@"UserID":getUD(@"UserID")}];
    NewsDetailViewController *ndvc = [[NewsDetailViewController alloc] init];
    ndvc.newsObj = arr[indexPath.row];
    [self.navigationController pushViewController:ndvc animated:YES];
    
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_newsArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell对象
    NewsTableViewCell *cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"News"];
    //获取对应行的数据
    NewsObj *news = _newsArr[indexPath.row];
    //设置cell的头像图片
    //获取文件后缀名
    NSString *imgExt = [[[NSFileManager defaultManager] displayNameAtPath:news.IMAGE_URL] pathExtension];
    NSString *imgName = [NSString stringWithFormat:@"%@.%@",news.ID,imgExt];  //获取完整图片名
    //拼接文件路径
    NSString *imgPath = [NSString stringWithFormat:@"%@/Library/Caches/%@/News/%@",NSHomeDirectory(),getUD(@"UserID"),imgName];
    
    cell.headImgView.image = [UIImage imageWithData: [NSData dataWithContentsOfFile:imgPath]];
    
    //判断当前是否为中文
    if([getUD(@"语言") isEqual:@"中文"])
    {
        //设置中文标题
        cell.titleLabel.text = news.NAME_CN;
    }
    else{
        //设置英文的标题
        cell.titleLabel.text = news.NAME_EN;
    }
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
    NSDate *createDate = [format dateFromString:news.SUBMIT_DATE];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [format stringFromDate:createDate];
    cell.dateLabel.text = dateStr;
    //设置分享按钮的图标
    [cell.shareBtn setImage:[UIImage imageNamed:@"btn_分享"] forState:UIControlStateNormal];
    cell.shareBtn.tag = indexPath.row;
    [cell.shareBtn addTarget:self action:@selector(shareColumn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

//分享按钮点击事件
- (void)shareColumn:(UIButton *)btn
{
    UserObj *user = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:@"UserObj" andSelectCondition:@{@"UserID":getUD(@"UserID")}][0];
    NewsObj *news = _newsArr[btn.tag];
    NSString *shareUrl = [NSString stringWithFormat:@"http://%@.artp.cc/%@/newsInfo",user.ACCOUNT_DOMAIN,news.ID];
    ShareViewController *svc = [[ShareViewController alloc] init];
    svc.shareUrl = shareUrl;
    NSLog(@"%@",shareUrl);
    [self.navigationController pushViewController:svc animated:YES];
}
//点击栏目
- (void)columnBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//点击设置
- (void)setingBtnClick
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
