//
//  NewsDetailViewController.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/8.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "ViewController.h"
#import "NewsContentView.h"
#import "NewsObj.h"

@interface NewsDetailViewController : ViewController

@property(nonatomic,strong) NewsObj *newsObj;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) NewsContentView *contentView;

@end
