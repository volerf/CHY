//
//  CHYLoadingView.h
//  上下拉刷新思想
//
//  Created by 华杉科技 on 2018/9/18.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>

//创建枚举表示几种状态
typedef enum
{
    CHYStateNormal,     //默认
    CHYStatePulling,    //拉
    CHYStateLoading,    //加载
    CHYStateHitTheEnd   //数据加载完毕
} CHYState;

@interface CHYLoadingView : UIView

@property(nonatomic,strong) UILabel *contentLabel;      //显示状态信息的Label
@property(nonatomic,strong) UIActivityIndicatorView *activityView;  //转圈小视图，表示正在加载
@property(nonatomic,strong) CALayer *arrowLayer; //显示箭头，类似UIImageView，3d旋转更方便
@property(nonatomic,assign) BOOL isLoading;        //是否正在加载
@property(nonatomic,assign) BOOL isTopView;        //判断视图是放在上面还是下面（下拉或上拉）
@property(nonatomic) CHYState state;               //状态


- (id)initWithFrame:(CGRect)frame andIsTopView:(BOOL)top;   //初始化视图
- (void)setState:(CHYState)state animated:(BOOL)animated; //设置视图状态和是否有动画效果

@end

























