//
//  ColumnViewController.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/22.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "ColumnViewController.h"
#import "UserObj.h"
#import "ColumnManagerViewController.h"
#import "SettingViewController.h"
#import "ShareViewController.h"
#import "WorkGroupViewController.h"
#import "DownloadViewController.h"

@interface ColumnViewController ()

@property(nonatomic,strong) UITapGestureRecognizer *tap;

@end

@implementation ColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([_isPublic isEqual:@"YES"])
    {
        //跳转到此页后删除navigation中以前的控制器
        NSMutableArray *arr = [self.navigationController.viewControllers mutableCopy];
        for(int i = 0; i < [arr count] - 1;)
        {
            [arr removeObjectAtIndex:i];
        }
        self.navigationController.viewControllers = arr;
    }
    
    //设置父视图相关属性
    self.view.backgroundColor = bgColor;
    self.ArtPageImgView.hidden = YES;
    //栏目按钮
    [self.leftBtn setImage:UIImageFile(@"btn_栏目", @"png") forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(columnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //设置按钮
    [self.rightBtn setImage:UIImageFile(@"btn_设置", @"png") forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //准备数据
    _columnArr = [[NSMutableArray alloc] initWithCapacity:1];
    [_columnArr addObjectsFromArray: [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:@"GroupObj" andSelectCondition:@{@"UserID":getUD(@"UserID"), @"isPublic":_isPublic}]];
    
    //加载视图
    _columnView = [[ColumnView alloc] init];
    [self.view addSubview:_columnView];
    [_columnView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, SCREENHEIGHT - 54));
    }];
    if([self.isPublic isEqual:@"YES"])
    {
        if([getUD(@"语言") isEqual:@"中文"])
        {
            _columnView.titleLabel.text = @"公开分组";
        }
        else{
            _columnView.titleLabel.text = @"Public Group";
        }
    }
    else{
        if([getUD(@"语言") isEqual:@"中文"])
        {
            _columnView.titleLabel.text = @"非公开分组";
        }
        else{
            _columnView.titleLabel.text = @"non-public Group";
        }
    }
    
    //设置TableView的相关属性
    _columnView.aTableView.delegate = self;
    _columnView.aTableView.dataSource = self;
    _columnView.aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //去掉TableView分割线
    //注册TableView单元格样式
    [_columnView.aTableView registerClass:[ColumnTableViewCell class] forCellReuseIdentifier:@"publicGroup"];
    
    //把columnView放到self.view的最下面
    [self.view sendSubviewToBack:_columnView];
    
}

//分享按钮点击事件
- (void)shareColumn:(UIButton *)btn
{
    UserObj *user = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:@"UserObj" andSelectCondition:@{@"UserID":getUD(@"UserID")}][0];
    GroupObj *group = _columnArr[btn.tag];
    NSString *shareUrl = [NSString stringWithFormat:@"http://%@.artp.cc/%@/artlist",user.ACCOUNT_DOMAIN,group.GroupID];
    ShareViewController *svc = [[ShareViewController alloc] init];
    svc.shareUrl = shareUrl;
    NSLog(@"%@",shareUrl);
    [self.navigationController pushViewController:svc animated:YES];
}
//点击栏目按钮事件
- (void)columnBtnClick
{
    if([_isPublic isEqual:@"YES"])
    {
        ColumnManagerViewController *cmvc = [[ColumnManagerViewController alloc] init];
        [self.navigationController pushViewController:cmvc animated:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//点击设置按钮事件
- (void)settingBtnClick
{
    if([_isPublic isEqual:@"NO"] && _inputView != nil)
    {
        [_inputView removeFromSuperview];
        [self.columnView.aTableView removeGestureRecognizer:_tap];
    }
    SettingViewController *svc = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}
//点击tableView手势
- (void)removeInputView:(UITapGestureRecognizer *)tap
{
    //删除输入密码的视图
    [_inputView removeFromSuperview];
    //删除TableView手势
    [self.columnView.aTableView removeGestureRecognizer:tap];
}

#pragma make  -  UITableViewDelegate And UITableViewDataSource Methods
//行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
//行选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取点击行的groupObj对象
    GroupObj *group = _columnArr[indexPath.row];
    //判断是否为非公开分组
    if([self.isPublic isEqual:@"NO"])
    {
        //判断非公开分组是否有设置密码
        if(group.Password != nil && ![group.Password isEqual:@""])
        {
            //加载输入密码视图
            _inputView = [[InputPasswordView alloc] init];
            if([getUD(@"语言") isEqual:@"中文"])
            {
                _inputView.titleLabel.text = group.GroupName_CN;
            }
            else{
                _inputView.titleLabel.text = group.GroupName_EN;
            }
            _inputView.group = group;       //把groupObj对象传给视图对象
            //点击进入分组事件
            [_inputView.btn addTarget:self action:@selector(goToGroup) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_inputView];
            [_inputView makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.view.centerY);
                make.left.equalTo(0);
                make.width.equalTo(SCREENWIDTH);
                make.height.equalTo(200);
            }];
            //给tableView添加点击手势，点击TableView时删除视图
            _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeInputView:)];
            [self.columnView.aTableView addGestureRecognizer:_tap];
        }
        else{
            WorkGroupViewController *wgvc = [[WorkGroupViewController alloc] init];
            wgvc.groupObj = group;
            [self.navigationController pushViewController:wgvc animated:YES];
        }
    }
    else{
        WorkGroupViewController *wgvc = [[WorkGroupViewController alloc] init];
        wgvc.groupObj = group;
        [self.navigationController pushViewController:wgvc animated:YES];
    }
    
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
//行数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_columnArr count];
}
//行内显示数据和样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell对象
    ColumnTableViewCell *cell = [[ColumnTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"publicGroup"];
    //获取对应行的数据
    GroupObj *group = _columnArr[indexPath.row];
    //获取属于这个分组的所有图片
    NSMutableArray *workArr = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:@"WorkObj" andSelectCondition:@{@"GroupID":group.GroupID}];
    //设置cell的头像图片
    NSString *imgPath = @"";
    if(![group.GroupImage isEqual:@""])     //如果有groupImage就用
    {
        //获取文件后缀名
        NSString *imgExt = [[[NSFileManager defaultManager] displayNameAtPath:group.GroupImage] pathExtension];
        NSString *imgName = [NSString stringWithFormat:@"%@.%@",group.GroupID,imgExt];  //获取完整图片名
        //拼接文件路径
        imgPath = [NSString stringWithFormat:@"%@/Library/Caches/%@/Group/groupId%@/%@",NSHomeDirectory(),getUD(@"UserID"),group.GroupID,imgName];
    }
    else{         //没有，用分组内的第一张图片的缩略图
        //获取文件后缀名
        WorkObj *work = workArr[0];
        NSString *imgExt = [[[NSFileManager defaultManager] displayNameAtPath:work.ARTWORK_THUMBNAIL] pathExtension];
        NSString *imgName = [NSString stringWithFormat:@"%@_thumbnail.%@",work.ArtWorkID,imgExt];
        //拼接文件路径
        imgPath = [NSString stringWithFormat:@"%@/Library/Caches/%@/Group/groupId%@/works/THUMBNAIL/%@",NSHomeDirectory(),getUD(@"UserID"),group.GroupID,imgName];
    }
    cell.headImgView.image = [UIImage imageWithData: [NSData dataWithContentsOfFile:imgPath]];
    
    //判断当前是否为中文
    if([getUD(@"语言") isEqual:@"中文"])
    {
        //设置中文标题和个数
        cell.titleLable.text = group.GroupName_CN;
        NSString *projectCount = [NSString stringWithFormat:@"%lu个项目",(unsigned long)workArr.count];
        cell.contentLabel.text = projectCount;
    }
    else{
        //设置英文的标题和个数
        cell.titleLable.text = group.GroupName_EN;
        NSString *projectCount = [NSString stringWithFormat:@"%lu projects",(unsigned long)workArr.count];
        cell.contentLabel.text = projectCount;
    }
    //设置分享按钮的图标
    [cell.shareBtn setImage:[UIImage imageNamed:@"btn_分享"] forState:UIControlStateNormal];
    cell.shareBtn.tag = indexPath.row;
    [cell.shareBtn addTarget:self action:@selector(shareColumn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}



//进入分组事件
- (void)goToGroup
{
    //判断输入的分组密码是否正确
    if([_inputView.passwordField.text isEqual:_inputView.group.Password])
    {
        [_inputView removeFromSuperview];
        [self.columnView.aTableView removeGestureRecognizer:_tap];
        
        WorkGroupViewController *wgvc = [[WorkGroupViewController alloc] init];
        wgvc.groupObj = _inputView.group;
        [self.navigationController pushViewController:wgvc animated:YES];
    }
    else{
        UIAlertController *alert = [UIAlertController alertCancelWithTitle:@"错误" andMessage:@"输入密码不正确" andCancelInfo:@"确定"];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
