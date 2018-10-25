//
//  WorkDetailViewController.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/3.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "WorkDetailViewController.h"

@interface WorkDetailViewController ()

@property(nonatomic,assign) CGFloat realWidth;
@property(nonatomic,assign) CGFloat realHeight;
@property(nonatomic,strong) WorkImgScaleView *imgScaleView;
@property(nonatomic,strong) UICollectionViewFlowLayout *layout;


@end

@implementation WorkDetailViewController

//允许旋转的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}
//是否允许旋转
- (BOOL)shouldAutorotate
{
    return YES;
}
//屏幕大小改变时，即屏幕旋转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    _realWidth = size.width;
    _realHeight = size.height;
    _layout.itemSize = CGSizeMake(_realWidth, _realHeight);
    _workCollectionView.frame = CGRectMake(0, 0, _realWidth, _realHeight);
    _imgScaleView.frame = CGRectMake(0, 0, _realWidth, _realHeight);
    _workCollectionView.contentOffset = CGPointMake(_realWidth * _index, 0);
    
    [_workCollectionView reloadData];
    [self initNavView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;     //取消导航栏限制
    _realWidth = SCREENWIDTH;
    _realHeight = SCREENHEIGHT;
    //获取数据
    _worksArr = [[NSMutableArray alloc] initWithCapacity:1];
    _worksArr = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:@"WorkObj" andSelectCondition:@{@"GroupID":_group.GroupID}];
    
    //初始化collectionView视图
    [self initCollectionView];
    
    //设置底部导航视图
    [self initNavView];
    
    //点击屏幕手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showWorkInfo)];
    [self.view addGestureRecognizer:tap];
}

//返回
- (void)backWorkGroup
{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存图片
- (void)saveImage
{
    WorkObj *work = _worksArr[_index];      //_index表示当前屏幕显示的图片下标
    //通过路径和文件名获取图片信息
    NSString *imgSavePath = [NSString stringWithFormat: @"%@/Library/Caches/%@/Group/groupId%@/works/ORIGINAL/",NSHomeDirectory(),getUD(@"UserID"),[_group valueForKey:@"GroupID"]];
    NSString *imgName = [NSString stringWithFormat:@"%@_original.%@",[work valueForKey:@"ArtWorkID"],[work.ARTWORK_FILE_ORIGINAL pathExtension]];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@%@",imgSavePath,imgName]]];
    //保存图片
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}
//保存图片的回调函数
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo
{
    if(!error)
    {
        UILabel *msgLabel = [UILabel labelWithBgColor:[UIColor colorWithRed:60.0 / 255 green:60.0 / 255 blue:60.0 / 255 alpha:0.9] text:@"图片已保存到相册" textColor:[UIColor colorWithHexadecimal:0xa0a0a0] fontSize:20.0 textAlignment:NSTextAlignmentCenter];
        if(![getUD(@"语言") isEqual:@"中文"])
        {
            msgLabel.text = @"Picture has been saved";
        }
        [self.view addSubview:msgLabel];
        [msgLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(0);
            make.width.equalTo(SCREENWIDTH);
            make.height.equalTo(60);
        }];
        //设置提示信息的淡出效果
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:4.0];
        [[msgLabel viewWithTag:0] setAlpha:0];      //淡出
        [UIView commitAnimations];
    }
}

//显示或隐藏图片信息，点击手势事件
- (void)showWorkInfo
{
    _infoView.hidden = !_infoView.hidden;
    _navView.hidden = !_navView.hidden;
}
//设置底部导航视图
- (void)initNavView
{
    [_navView removeFromSuperview];
    _navView = [[WorkNavView alloc] init];
    _navView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_navView];
    [_navView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(0);
        make.width.equalTo(self.realWidth);
        make.height.equalTo(54);
    }];
    [_navView.leftBtn addTarget:self action:@selector(backWorkGroup) forControlEvents:UIControlEventTouchUpInside];
    [_navView.rightBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self scrollViewDidEndDecelerating:_workCollectionView];
}
//初始化collectionView
- (void)initCollectionView
{
    //初始化collectionView
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;     //横向滚动
    _layout.itemSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
    _workCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) collectionViewLayout:_layout];
    _workCollectionView.pagingEnabled = YES;
    //水平方向间隙
    _layout.minimumInteritemSpacing = 0;
    //没有水平滑动指示
    _workCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview: _workCollectionView];
    
    //注册collectionViewCell
    [_workCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"work"];
    //设置代理
    _workCollectionView.delegate = self;
    _workCollectionView.dataSource = self;
    //设置偏移
    _workCollectionView.contentOffset = CGPointMake(SCREENWIDTH * _index, 0);
}
#pragma make  -  UICollectionView的代理方法
//视图停止时初始化图片显示的信息
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _index = scrollView.contentOffset.x / _realWidth;
    WorkObj *work = _worksArr[_index];
    //初始化scrollView对象
    [_infoView removeFromSuperview];        //删除原来的infoView，重新初始化
    if([getUD(@"语言") isEqual:@"中文"])    //判断是否为中文状态下
    {
        _infoView = [[WorkInfoView alloc] initWithTitle:work.ARTWORK_NAME_CN andContent:work.ARTWORK_DESC_CN width:_realWidth];
    }
    else{
        _infoView = [[WorkInfoView alloc] initWithTitle:work.ARTWORK_NAME_EN andContent:work.ARTWORK_DESC_EN width:_realWidth];
    }
    [self.view addSubview:_infoView];
    [_infoView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-54);
        make.left.equalTo(0);
        make.width.equalTo(self.realWidth);
        if(self.infoView.contentSize.height < 150)      //视图的最大高度为150
        {
            make.height.equalTo(self.infoView.contentSize.height);
        }
        else{
            make.height.equalTo(150);
        }
    }];
    _infoView.hidden = YES;     //默认设置为隐藏，点击手势触发时为显示
    _navView.hidden = YES;
    
}
//item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_worksArr count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //获取要显示的数据，model
    WorkObj *work = _worksArr[indexPath.item];
    NSString *imgSavePath = [NSString stringWithFormat: @"%@/Library/Caches/%@/Group/groupId%@/works/ORIGINAL/",NSHomeDirectory(),getUD(@"UserID"),[_group valueForKey:@"GroupID"]];
    NSString *imgName = [NSString stringWithFormat:@"%@_original.%@",[work valueForKey:@"ArtWorkID"],[work.ARTWORK_FILE_ORIGINAL pathExtension]];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@%@",imgSavePath,imgName]]];
    //
    _imgScaleView = [[WorkImgScaleView alloc] initWithImage:image];
    _imgScaleView.frame = CGRectMake(0, 0, _realWidth, _realHeight);
    
    //初始化cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"work" forIndexPath:indexPath];
    //删除cell的所有子视图，避免重用时的残留
    while ([cell.contentView.subviews lastObject] != nil)
    {
        [[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    //把imgView添加到cell上显示
    [cell.contentView addSubview:_imgScaleView];
    
    return cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//设置每个item的垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
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
