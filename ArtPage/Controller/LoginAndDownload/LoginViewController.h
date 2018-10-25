//
//  LoginViewController.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "ViewController.h"
#import "LoginView.h"
#import "AFHTTPSessionManager.h"

@interface LoginViewController : UIViewController

@property(nonatomic,strong) AFHTTPSessionManager *manager;
@property(nonatomic,strong) LoginView *loginView;

@end
