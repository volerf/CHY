//
//  NewsContentView.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/8.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsObj.h"

@interface NewsContentView : UIWebView<UIWebViewDelegate>

@property(nonatomic,strong) UILabel *newsTitle;
@property(nonatomic,strong) UILabel *createTime;

- (id)initWithNew:(NewsObj *)log;

@end
