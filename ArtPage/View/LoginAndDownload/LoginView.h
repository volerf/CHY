//
//  LoginView.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView<UITextFieldDelegate>

@property(nonatomic,strong) UIImageView *headImgView;
@property(nonatomic,strong) UITextField *userName;
@property(nonatomic,strong) UITextField *pwd;
@property(nonatomic,strong) UIButton *loginBtn;
@property(nonatomic,strong) UIButton *clearBtn;
@property(nonatomic,strong) UIButton *applyBtn;
@property(nonatomic,strong) UIButton *forgetBtn;
@property(nonatomic,strong) UIButton *backBtn;

@end
