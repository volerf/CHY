//
//  WorkNavView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/8.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "WorkNavView.h"

@implementation WorkNavView

- (id)init
{
    if(self = [super init])
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:UIImageFile(@"btn_返回", @"png") forState:UIControlStateNormal];
        [self addSubview:_leftBtn];
        [_leftBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(98);
            make.bottom.equalTo(-10);
            make.size.equalTo(CGSizeMake(22, 37));
        }];
        
        _rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:UIImageFile(@"btn_保存至相册", @"png") forState:UIControlStateNormal];
        [self addSubview:_rightBtn];
        [_rightBtn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-82);
            make.bottom.equalTo(-10);
            make.size.equalTo(CGSizeMake(54, 37));
        }];
    }
    return self;
}

@end
