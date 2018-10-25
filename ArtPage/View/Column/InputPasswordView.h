//
//  InputPasswordView.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/9.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupObj.h"

@interface InputPasswordView : UIView

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UITextField *passwordField;
@property(nonatomic,strong) UIImageView *lineView;
@property(nonatomic,strong) UIButton *btn;

@property(nonatomic,strong) GroupObj *group;

@end
