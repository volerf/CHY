//
//  ShareViewController.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/26.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "ViewController.h"
#import "SixItemView.h"

@interface ShareViewController : ViewController

@property(nonatomic,strong) NSString *shareUrl;
@property(nonatomic,strong) SixItemView *sixView;
@property(nonatomic,strong) UILabel *shareLabel;
@property(nonatomic,strong) UILabel *urlLabel;

@end
