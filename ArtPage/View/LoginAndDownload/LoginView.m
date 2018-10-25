//
//  LoginView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (id)init
{
    if(self = [super init])
    {
        self.backgroundColor = bgColor;
        //ArtPage的logo
        _headImgView = [[UIImageView alloc] initWithImage: UIImageFile(@"img_首页Logo", @"png")];
        [self addSubview:_headImgView];
        [_headImgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX);
            make.top.equalTo(SCREENHEIGHT * 0.18);
            make.size.equalTo(CGSizeMake(143, 48));
        }];
        
        //用户名输入框
        _userName = [[UITextField alloc] init];
        _userName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"用户名" attributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0], NSFontAttributeName, [UIColor lightGrayColor], NSForegroundColorAttributeName, nil]];
        
        _userName.textColor = [UIColor whiteColor];
        _userName.font = [UIFont systemFontOfSize:16.f];
        _userName.keyboardType = UIKeyboardTypePhonePad;
        _userName.delegate = self;
        [self addSubview:_userName];
        [_userName makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImgView.bottom).offset(0.17 * SCREENHEIGHT);
            make.centerX.equalTo(self.centerX);
            make.width.equalTo(230);
            make.height.equalTo(30);
        }];
        UIImageView *userLine = [[UIImageView alloc] initWithImage:UIImageFile(@"img_首页输入框底线", @"png")];
        [self addSubview:userLine];
        [userLine makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userName.bottom).offset(1);
            make.left.equalTo(self.userName.left).offset(0);
            make.width.equalTo(self.userName.width);
            make.height.equalTo(1);
        }];
        
        //密码框
        _pwd = [[UITextField alloc] init];
        //设置占位字符
        _pwd.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0], NSFontAttributeName, [UIColor lightGrayColor], NSForegroundColorAttributeName, nil]];
        
        _pwd.textColor = [UIColor whiteColor];
        _pwd.font = [UIFont systemFontOfSize:16.f];
        _pwd.secureTextEntry = YES;
        _pwd.delegate = self;
        [self addSubview:_pwd];
        [_pwd makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userName.bottom).offset(30);
            make.centerX.equalTo(self.centerX);
            make.width.equalTo(230);
            make.height.equalTo(30);
        }];
        UIImageView *pwdLine = [[UIImageView alloc] initWithImage:UIImageFile(@"img_首页输入框底线", @"png")];
        [self addSubview:pwdLine];
        [pwdLine makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.pwd.bottom).offset(1);
            make.left.equalTo(self.pwd.left).offset(0);
            make.width.equalTo(self.pwd.width);
            make.height.equalTo(1);
        }];
        
        //clear按钮
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearBtn setImage:UIImageFile(@"btn_首页用户名取消", @"png") forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearUserAndPwd) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_clearBtn];
        [_clearBtn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.userName.right).offset(0);
            make.bottom.equalTo(self.userName.bottom).offset(-4);
            make.size.equalTo(CGSizeMake(22, 22));
        }];
        
        //登录按钮
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setImage:UIImageFile(@"btn_登录", @"png") forState:UIControlStateNormal];
        [self addSubview:_loginBtn];
        [_loginBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.pwd.bottom).offset(15);
            make.centerX.equalTo(self.centerX);
            make.width.equalTo(230);
            make.height.equalTo(47);
        }];
        
        //竖线
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = [UIColor colorWithHexadecimal:0xa0a0a0];
        [self addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.loginBtn.bottom).offset(30);
            make.centerX.equalTo(self.centerX);
            make.size.equalTo(CGSizeMake(1, 15));
        }];
        
        //申请使用
        _applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_applyBtn setTitle:@"申请试用" forState:UIControlStateNormal];
        [_applyBtn setTitleColor:[UIColor colorWithHexadecimal:0xa0a0a0] forState:UIControlStateNormal];
        _applyBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _applyBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_applyBtn];
        [_applyBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.loginBtn.bottom).offset(30);
            make.right.equalTo(line.left).offset(0);
            make.size.equalTo(CGSizeMake(100, 14.0));
        }];
        
        //忘记密码
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:[UIColor colorWithHexadecimal:0xa0a0a0] forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _forgetBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_forgetBtn];
        [_forgetBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.loginBtn.bottom).offset(30);
            make.left.equalTo(line.right).offset(0);
            make.size.equalTo(CGSizeMake(100, 14.0));
        }];
        
        //返回按钮
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"btn_返回"] forState:UIControlStateNormal];
        [self addSubview:_backBtn];
        [_backBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(17);
            make.bottom.equalTo(-10);
            make.size.equalTo(CGSizeMake(22, 37));
        }];
    }
    return self;
}

//清空输入框内容
- (void)clearUserAndPwd
{
    self.userName.text = @"";
    self.pwd.text = @"";
}
//点击屏幕空白键盘消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.userName resignFirstResponder];
    [self.pwd resignFirstResponder];
}


#pragma make - Method is UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
























