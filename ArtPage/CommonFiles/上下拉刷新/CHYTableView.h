//
//  CHYTableView.h
//  上下拉刷新思想
//
//  Created by 华杉科技 on 2018/9/18.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHYLoadingView.h"

@interface CHYTableView : UITableView<UIScrollViewDelegate>

//定义下拉和上拉的block块
typedef void (^PullDownRefreshingBlock)(CHYTableView *tableView);
typedef void (^DragUpRefreshingBlock)(CHYTableView *tableView);
@property(nonatomic,copy) PullDownRefreshingBlock pullDownBlock;
@property(nonatomic,copy) DragUpRefreshingBlock dragUpBlock;

//定义上下两个视图
@property(nonatomic,strong) CHYLoadingView *topView;
@property(nonatomic,strong) CHYLoadingView *botView;

//标示数据是否加载完
@property(nonatomic,assign) BOOL reachedEnd;
//是否正在加载
@property(nonatomic,assign) BOOL loading;

//是否是下拉动作
@property(nonatomic,assign) BOOL isTopAction;
//是否设置为只能下拉刷新
@property(nonatomic,assign) BOOL onlyDown;

//tablaView滚动的时候
- (void)tableViewDidScroll:(UIScrollView *)scrollView;
//tableView结束拖动的时候
- (void)tableViewDidEndDragging:(UIScrollView *)scrollView;
//TableView完成刷新
- (void)tableViewDidFinishedLoading;
//进入界面先刷新一次
- (void)firstRefresh;

@end















