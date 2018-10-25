//
//  WorkGroupViewController.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "WorkGroupViewController.h"
#import "WorkGroupCollectionViewCell.h"
#import "WorkObj.h"
#import "UserObj.h"
#import "ShareViewController.h"
#import "WorkDetailViewController.h"

@interface WorkGroupViewController ()

@end

@implementation WorkGroupViewController

- (void)viewDidLoad {
    super.isAButton = YES;
    [super viewDidLoad];
    //设置父类相关属性
    self.ArtPageImgView.hidden = YES;
    [self.centerBtn setImage:UIImageFile(@"btn_返回", @"png") forState:UIControlStateNormal];
    [self.centerBtn addTarget:self action:@selector(backColumn) forControlEvents:UIControlEventTouchUpInside];
    
    //准备数据
    _workArr = [[NSMutableArray alloc] initWithCapacity:1];
    _workArr = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:@"WorkObj" andSelectCondition:@{@"GroupID":_groupObj.GroupID}];
    
    //初始化视图
    [self initTheView];
    //注册collectionViewCell
    [_workCollection registerClass:[WorkGroupCollectionViewCell class] forCellWithReuseIdentifier:@"workForGroup"];
    //设置代理
    _workCollection.delegate = self;
    _workCollection.dataSource = self;
    
    if([getUD(@"语言") isEqual:@"中文"])
    {
        _titleLabel.text = @"作品展示";
        _groupName.text = _groupObj.GroupName_CN;
        _workCount.text = [NSString stringWithFormat:@"%lu个项目",(unsigned long)_workArr.count];
    }
    else{
        _titleLabel.text = @"Works on display";
        _groupName.text = _groupObj.GroupName_EN;
        _workCount.text = [NSString stringWithFormat:@"%lu projects",(unsigned long)_workArr.count];
    }
    
}



#pragma make  -  UICollectionView的代理方法
//cell赋值
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WorkGroupCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"workForGroup" forIndexPath:indexPath];
    WorkObj *work = _workArr[indexPath.item];
    
    NSString *imgSavePath = [NSString stringWithFormat: @"%@/Library/Caches/%@/Group/groupId%@/works/THUMBNAIL/",NSHomeDirectory(),getUD(@"UserID"),_groupObj.GroupID];
    NSString *imgName = [NSString stringWithFormat:@"%@_thumbnail.%@",[work valueForKey:@"ArtWorkID"],[work.ARTWORK_THUMBNAIL pathExtension]];
    
    cell.imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@%@",imgSavePath,imgName]]];
    
    
    return cell;
}
//点击item事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WorkDetailViewController *wdvc = [[WorkDetailViewController alloc] init];
    wdvc.group = _groupObj;
    wdvc.index = indexPath.item;
    [self.navigationController pushViewController:wdvc animated:YES];
}
//每个section中item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _workArr.count;
}
//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREENWIDTH - 15) / 4, (SCREENWIDTH - 15) / 4);
}
//设置每个item的垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}


//初始化视图
- (void)initTheView
{
    //标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor colorWithHexadecimal:0xa0a0a0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.view addSubview:_titleLabel];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, 45));
    }];
    //分组名
    _groupName = [[UILabel alloc] init];
    _groupName.textAlignment = NSTextAlignmentLeft;
    _groupName.textColor = [UIColor colorWithHexadecimal:0xa0a0a0];
    _groupName.font = [UIFont systemFontOfSize:18.0];
    [self.view addSubview:_groupName];
    [_groupName makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom).offset(0);
        make.left.equalTo(10);
        make.size.equalTo(CGSizeMake(SCREENWIDTH - 60, 30));
    }];
    //作品数量
    _workCount = [UILabel labelWithBgColor:[UIColor clearColor] text:@"" textColor:[UIColor colorWithHexadecimal:0x626262] fontSize:13.0 textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:_workCount];
    [_workCount makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.groupName.bottom).offset(0);
        make.left.equalTo(10);
        make.size.equalTo(CGSizeMake(SCREENWIDTH - 60, 15));
    }];
    //分享按钮
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareBtn setImage:UIImageFile(@"btn_分享", @"png") forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(shareWork) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shareBtn];
    [_shareBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.centerY.equalTo(self.groupName.bottom).offset(0);
        make.size.equalTo(CGSizeMake(22, 22));
    }];
    
    //初始化collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _workCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120, SCREENWIDTH, SCREENHEIGHT - 174) collectionViewLayout:layout];
    _workCollection.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_workCollection];
    [_workCollection makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.workCount.bottom).offset(10);
        make.left.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, SCREENHEIGHT - 174));
    }];
    
}
//点击分享按钮
- (void)shareWork
{
    UserObj *user = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:@"UserObj" andSelectCondition:@{@"UserID":getUD(@"UserID")}][0];
    ShareViewController *svc = [[ShareViewController alloc] init];
    svc.shareUrl = [NSString stringWithFormat:@"http://%@.artp.cc/%@/artlist",user.ACCOUNT_DOMAIN,_groupObj.GroupID];
    [self.navigationController pushViewController:svc animated:YES];
}
//点击返回
- (void)backColumn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
















