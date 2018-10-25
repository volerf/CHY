//
//  InputPasswordView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/9.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "InputPasswordView.h"

@implementation InputPasswordView

- (id)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
        _titleLabel.textColor = [UIColor colorWithHexadecimal:0xa0a0a0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(36);
            make.left.equalTo(20);
            make.width.equalTo(SCREENWIDTH - 40);
            make.height.equalTo(15);
        }];
        
        _passwordField = [[UITextField alloc] init];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"输入分组密码"];
        [str setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexadecimal:0x626262],NSFontAttributeName:[UIFont systemFontOfSize:12.0]} range:NSMakeRange(0, str.length)];
        _passwordField.attributedPlaceholder = str;
        _passwordField.font = [UIFont systemFontOfSize:12.0];
        _passwordField.textAlignment = NSTextAlignmentLeft;
        _passwordField.textColor = [UIColor colorWithHexadecimal:0xffffff];
        [self addSubview:_passwordField];
        [_passwordField makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.bottom).offset(36);
            make.centerX.equalTo(self.centerX);
            make.width.equalTo(222);
            make.height.equalTo(12);
        }];
        
        _lineView = [[UIImageView alloc] initWithImage:UIImageFile(@"img_首页输入框底线", @"png")];
        [self addSubview:_lineView];
        [_lineView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.passwordField.bottom).offset(7);
            make.centerX.equalTo(self.centerX);
            make.width.equalTo(230);
            make.height.equalTo(1);
        }];
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setImage:UIImageFile(@"btn_进入分组", @"png") forState:UIControlStateNormal];
        [self addSubview:_btn];
        [_btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineView.bottom).offset(10);
            make.centerX.equalTo(self.centerX);
            make.width.equalTo(230);
            make.height.equalTo(47);
        }];
        
    }
    return self;
}

@end











