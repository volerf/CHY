//
//  ColumnViewController.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/22.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "ViewController.h"
#import "GroupObj.h"
#import "WorkObj.h"
#import "ColumnView.h"
#import "ColumnTableViewCell.h"
#import "InputPasswordView.h"

@interface ColumnViewController : ViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSString *isPublic;
@property(nonatomic,strong) ColumnView *columnView;
@property(nonatomic,strong) NSMutableArray *columnArr;

@property(nonatomic,strong) InputPasswordView *inputView;

@end
