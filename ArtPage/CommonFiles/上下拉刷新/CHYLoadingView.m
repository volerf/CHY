//
//  CHYLoadingView.m
//  上下拉刷新思想
//
//  Created by 华杉科技 on 2018/9/18.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "CHYLoadingView.h"

@implementation CHYLoadingView

//初始化视图
- (id)initWithFrame:(CGRect)frame andIsTopView:(BOOL)top
{
    if(self = [super initWithFrame:frame])
    {
        _isTopView = top;       //设置视图是上面的还是下面的
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;   //灵活地自动调整视图的宽度
        self.backgroundColor = [UIColor whiteColor];
        int orginY = 0;     //定义视图的y坐标
        id image = nil;     //定义Image用来保存要显示的图片
        NSString *info = @"";
        
        //根据视图要显示的地方设置不同的数据
        if(_isTopView)
        {
            orginY = frame.size.height - 40;    //
            image = (id)[UIImage imageNamed:@"arrow"].CGImage;
            info = @"下拉刷新";
        }
        else{
            orginY = 20;
            image = (id)[UIImage imageNamed: @"arrowDown"].CGImage;
            info = @"上拉加载";
        }
        //文字提示
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, orginY, frame.size.width, 20)];
        _contentLabel.font = [UIFont systemFontOfSize:14.f];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _contentLabel.text = info;
        [self addSubview:_contentLabel];
        
        //箭头
        _arrowLayer = [CALayer layer];
        _arrowLayer.frame = CGRectMake(frame.size.width / 2 - 70, orginY, 20, 20);
        _arrowLayer.contentsGravity = kCAGravityResizeAspect;   //自动与图层匹配
        _arrowLayer.contents = image;
        [self.layer addSublayer:_arrowLayer];
        
        //加载圈
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];//初始化
        _activityView.center = _arrowLayer.position;        //加载圈的中心相对_arrowLayer定位
        [self addSubview:_activityView];
        
    }
    return self;
}

//state的set函数
- (void)setState:(CHYState)state
{
    [self setState:state animated:YES];
}

//设置视图状态和是否有动画效果
- (void)setState:(CHYState)state animated:(BOOL)animated
{
    float duration = animated ? 0.2f : 0.f;     //设置animated为YES时的动画时长
    if(_state != state)
    {
        _state = state;
        if(_state == CHYStateLoading)       //状态为正在加载时
        {
            _arrowLayer.hidden = YES;       //箭头隐藏
            _activityView.hidden = NO;      //加载圈显示
            [_activityView startAnimating]; //加载圈开始转动
            
            _isLoading = YES;               //加载中
            _contentLabel.text = @"加载中。。。";
        }
        else if(_state == CHYStatePulling && !_isLoading)   //下拉并且不是在加载中
        {
            _arrowLayer.hidden = NO;
            _activityView.hidden = YES;
            [_activityView stopAnimating];      //停止加载
            [CATransaction begin];          //开始动画
            [CATransaction setAnimationDuration:duration];  //设置动画时间
            _arrowLayer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);//绕z轴旋转90°
            [CATransaction commit];
            
            if(_isTopView)
            {
                _contentLabel.text = @"松开立即刷新";
            }
            else{
                _contentLabel.text = @"释放加载数据";
            }
        }
        else if (_state == CHYStateNormal && !_isLoading)
        {
            //Reset
            _arrowLayer.hidden = NO;
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            [CATransaction begin];
            [CATransaction setAnimationDuration:duration];
            _arrowLayer.transform = CATransform3DIdentity;
            [CATransaction commit];
            
            if(_isTopView)
            {
                _contentLabel.text = @"下拉刷新";
            }
            else{
                _contentLabel.text = @"加载数据";
            }
        }
        else if(_state == CHYStateHitTheEnd)
        {
            if(!self.isTopView)     //判断不是上面的视图
            {
                _arrowLayer.hidden = YES;
                _contentLabel.text = @"数据加载完毕";
            }
        }
    }
    
}

@end
















