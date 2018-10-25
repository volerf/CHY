//
//  LoadingView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        [_activityView startAnimating];
        [self addSubview:_activityView];
        
        _loadingLabel = [[UILabel alloc] init];
        _loadingLabel.text = @"数据加载中...";
        _loadingLabel.textColor = [UIColor redColor];
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        _loadingLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_loadingLabel];
        [_loadingLabel makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
            make.left.equalTo(5);
            make.size.equalTo(CGSizeMake(self.frame.size.width, 15));
        }];
    }
    return self;
}

@end
