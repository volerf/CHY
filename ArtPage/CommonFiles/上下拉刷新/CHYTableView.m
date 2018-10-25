//
//  CHYTableView.m
//  上下拉刷新思想
//
//  Created by 华杉科技 on 2018/9/18.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "CHYTableView.h"

#define CHYOffsetY 60.0f
#define CHYAnimatedTime 0.2f

@implementation CHYTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if(self = [super initWithFrame:frame style:style])
    {
        //添加下拉视图
        CGRect rect = CGRectMake(0, -frame.size.height, frame.size.width, frame.size.height);
        _topView = [[CHYLoadingView alloc] initWithFrame:rect andIsTopView:YES];
        [self addSubview:_topView];
        
        //添加上拉视图
        rect = CGRectMake(0, frame.size.height, frame.size.width, frame.size.height);
        _botView = [[CHYLoadingView alloc] initWithFrame:rect andIsTopView:NO];
        [self addSubview:_botView];
        
        //为当前类对象注册一个键值观察者，当对象的属性发生改变时可以做相应的调整
        [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}


//设置数据是否加载完毕
- (void)setReachedEnd:(BOOL)reachedEnd
{
    _reachedEnd = reachedEnd;
    if(_reachedEnd)
    {
        _botView.state = CHYStateHitTheEnd;     //数据加载完了就设置成CHYStateHitTheEnd
    }
    else{
        _botView.state = CHYStateNormal;    
    }
}

//设置是否只能下拉刷新
- (void)setOnlyDown:(BOOL)onlyDown
{
    _onlyDown = onlyDown;
    _botView.hidden = _onlyDown;        //设置成YES就隐藏下面的视图
}


#pragma make  -  Scroll method
//tablaView滚动的时候
- (void)tableViewDidScroll:(UIScrollView *)scrollView
{
    //如果正在加载中，滚动时什么也不做
    if(_topView.state == CHYStateLoading || _botView.state == CHYStateLoading)
    {
        return ;
    }
    //获取视图滚动的偏移量            下拉
    CGPoint offset = scrollView.contentOffset;
    //获取能够使视图加载的上拉距离        上拉长度+滚动视图的高度 - 滚动试图的内容大小
    float dragUpY = 0.0;
    if(scrollView.contentSize.height > scrollView.frame.size.height)
    {
        dragUpY = offset.y + scrollView.frame.size.height - scrollView.contentSize.height;
    }
    else{
        dragUpY = offset.y;
    }
    
    if(offset.y < -CHYOffsetY)
    {
        _topView.state = CHYStatePulling;       //设置为松开立即刷新
    }
    else if(offset.y > -CHYOffsetY && offset.y < 0)
    {
        _topView.state = CHYStateNormal;    //默认
    }
    else if(dragUpY > CHYOffsetY)
    {
        if(_botView.state != CHYStateHitTheEnd)
        {
            _botView.state = CHYStatePulling;
        }
    }
    else if(dragUpY < CHYOffsetY && dragUpY > 0)
    {
        if(_botView.state != CHYStateHitTheEnd)
        {
            _botView.state = CHYStateNormal;
        }
    }
    
    
}
//tableView结束拖动的时候
- (void)tableViewDidEndDragging:(UIScrollView *)scrollView
{
    //如果正在刷新就什么都不做
    if(_topView.state == CHYStateLoading || _botView.state == CHYStateLoading)
    {
        return ;
    }
    if(_topView.state == CHYStatePulling)       //松开立即刷新
    {
        _isTopAction = YES;
        _topView.state = CHYStateLoading;
        [UIView animateWithDuration:CHYAnimatedTime animations:^{
            //让TableView移动到原来位置下面60距离的位置，动画时间CHYAniatedTime秒
            self.contentInset = UIEdgeInsetsMake(CHYOffsetY, 0, 0, 0);
        }];
        if(_pullDownBlock)
        {
            _pullDownBlock(self);       //调用block块
        }
    }
    else if(_botView.state == CHYStatePulling)
    {
        if(self.reachedEnd || self.onlyDown)
        {
            return ;
        }
        
        _isTopAction = NO;
        _botView.state = CHYStateLoading;
        [UIView animateWithDuration:CHYAnimatedTime animations:^{
            //让TableView移动到距离原来的下面60距离的位置，动画时间0.2秒
            self.contentInset = UIEdgeInsetsMake(-CHYOffsetY, 0, 0, 0);
        }];
        if(_dragUpBlock)
        {
            _dragUpBlock(self);
        }
    }
    
}
//TableView完成刷新
//数据加载完毕后让tableView回到正常状态，即没有顶部和底部视图
- (void)tableViewDidFinishedLoading
{
    if(_topView.isLoading)  //正在加载
    {
        _topView.isLoading = NO;
        [_topView setState:CHYStateNormal animated:YES];    //状态设置为正常
    }
    else if(_botView.isLoading)
    {
        _botView.isLoading = NO;
        [_botView setState:CHYStateNormal animated:YES];
    }
    //让tableView回到最初的地方
    [UIView animateWithDuration:2 * CHYAnimatedTime animations:^{
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }];
}
//进入界面先刷新一次
- (void)firstRefresh
{
    self.contentOffset = CGPointMake(0, 0);
    [UIView animateWithDuration:CHYAnimatedTime animations:^{
        self.contentOffset = CGPointMake(0, -CHYOffsetY - 1);   //向下偏移61持续0.2秒
    } completion:^(BOOL finished) {
        [self tableViewDidEndDragging:self];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    //加载完成后设置底部视图的位置
    CGRect frame = _botView.frame;
    //如果内容大小小于视图大小（屏幕有空余）就设置为屏幕大小，否则设置为内容的高度
    frame.origin.y = self.contentSize.height < self.frame.size.height ? self.frame.size.height : self.contentSize.height;
    _botView.frame = frame;
    
    //让加载出来的新数据能让用户看见，让用户知道已经加载出来了
    if(!_isTopAction && self.contentSize.height > self.frame.size.height)
    {
        CGPoint offset = self.contentOffset;
        offset.y += 44.f;
        self.contentOffset = offset;
    }
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentSize"];
}


@end


















