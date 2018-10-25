//
//  DownloadViewController.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "ViewController.h"
#import "DownloadView.h"
#import "DownloadViewModel.h"
#import "LoadingView.h"

@interface DownloadViewController : ViewController

@property(nonatomic,strong) DownloadView *downloadView;
@property(nonatomic,strong) DownloadViewModel *downloadViewModel;
@property(nonatomic,assign) BOOL isBeginDownload;
@property(nonatomic,assign) BOOL isFinishDownload;
@property(nonatomic,strong) NSMutableArray *downloadArray;
@property(nonatomic,strong) NSMutableArray *removeArray;

@property(nonatomic,strong) LoadingView *loadingView;

@end
