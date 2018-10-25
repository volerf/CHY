//
//  NewsViewController.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/27.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "ViewController.h"
#import "ColumnView.h"
#import "NewsTableViewCell.h"

@interface NewsViewController : ViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) ColumnView *newsListView;
@property(nonatomic,strong) NSMutableArray *newsArr;

@end
