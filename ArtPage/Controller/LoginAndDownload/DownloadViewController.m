//
//  DownloadViewController.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "DownloadViewController.h"
#import "GroupObj.h"
#import "NewsObj.h"
#import "AboutObj.h"
#import "WorkObj.h"
#import "CHYDownloadManager.h"
#import "CHYDatabaseManager.h"
#import "ColumnViewController.h"

@interface DownloadViewController ()

@end

@implementation DownloadViewController

//viewModel准备数据
- (DownloadViewModel *)downloadViewModel
{
    if(!_downloadViewModel)
    {
        _downloadViewModel = [[DownloadViewModel alloc] init];
    }
    return _downloadViewModel;
}

//加载中视图
- (LoadingView *)loadingView
{
    if(!_loadingView)
    {
        _loadingView = [[LoadingView alloc] initWithFrame:CGRectMake((SCREENWIDTH - 100) / 2, (SCREENHEIGHT - 100) / 2, 100, 100)];
        [self.view addSubview:_loadingView];
    }
    return _loadingView;
}

//要下载的图片数组
- (NSMutableArray *)downloadArray
{
    if(!_downloadArray)
    {
        _downloadArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _downloadArray;
}
//要删除的图片数组
- (NSMutableArray *)removeArray
{
    if(!_removeArray)
    {
        _removeArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _removeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftBtn.hidden = YES;
    self.rightBtn.hidden = YES;
    _isBeginDownload = NO;
    _isFinishDownload = NO;
    
    _downloadView = [[DownloadView alloc] init];
    //下载按钮
    [_downloadView.downloadBtn addTarget:self action:@selector(downloadSource:) forControlEvents:UIControlEventTouchUpInside];
    //返回按钮
    [_downloadView.backBtn addTarget:self action:@selector(backLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_downloadView];
    [_downloadView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(0);
        make.size.equalTo(CGSizeMake(SCREENWIDTH, SCREENHEIGHT));
    }];
    
    //实现downloadViewModel里的弹出框block
    __weak typeof(self) weakSelf = self;
    self.downloadViewModel.alertBlock = ^(UIAlertController *alert)
    {
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
}

//开始下载按钮
- (void)downloadSource:(UIButton *)btn
{
    if(btn.selected)            //暂停下载
    {
        if(self.isFinishDownload)
        {
            ColumnViewController *cvc = [[ColumnViewController alloc] init];
            cvc.isPublic = @"YES";
            [self.navigationController pushViewController:cvc animated:YES];
        }
        else{
            if(self.isBeginDownload)
            {
                btn.selected = NO;
                [_downloadView setMessageLabelWithText:_downloadView.str1 andRangeText:@"数据同步"];
                [[CHYDownloadManager shareDownloadManager] suspendAllDownload];
            }
        }
    }
    else{
        btn.selected = YES;
        [_downloadView setMessageLabelWithText:_downloadView.str2 andRangeText:@"数据同步中"];
        if(self.isBeginDownload == NO)      //没有开始下载
        {
            [self loadingView];
            dispatch_async(dispatch_queue_create("请求", DISPATCH_QUEUE_CONCURRENT), ^{
                [self requestData];
            });
        }
        else{
            [[CHYDownloadManager shareDownloadManager] continueAllDownload];
        }
        
    }
}

//网络请求，请求接口数据
- (void)requestData
{
    [self.downloadViewModel requestAllDateDownloadArr:^(NSMutableArray *dowArr)
    {
        self.downloadArray = dowArr;
        
    } removeArr:^(NSMutableArray *remArr)
    {
        self.removeArray = remArr;
    }];
    
    //开始下载
    [self download];
}

- (void)download
{
    //删除网站删除的图片
    for(int i = 0; i < [self.removeArray count]; i++)
    {
        //获取文件保存在沙盒下的路径
        NSString *imgSavePath = [self.removeArray[i] valueForKey:@"imgSavePath"];
        //获取图片名
        NSString *imgName = [self.removeArray[i] valueForKey:@"imgName"];
        //拼接获取文件路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",imgSavePath,imgName];
        NSFileManager *fm = [NSFileManager defaultManager];
        if([fm fileExistsAtPath:filePath])      //如果图片存在就删除它
        {
            [fm removeItemAtPath:filePath error:nil];
        }
    }
    
    //开始下载文件
    self.isBeginDownload = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.loadingView.hidden = YES;
    });
    //开启子线程避免卡主线程
    dispatch_queue_t queue = dispatch_queue_create("下载", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        
        for(int i = 0; i < [self.downloadArray count]; i++)
        {
            //获取下载链接
            NSString *imgUrl = [self.downloadArray[i] valueForKey:@"imgUrl"];
            //获取文件保存在沙盒下的路径
            NSString *imgSavePath = [self.downloadArray[i] valueForKey:@"imgSavePath"];
            //获取图片名
            NSString *imgName = [self.downloadArray[i] valueForKey:@"imgName"];
            
            /*--避免重复下载    开始--*/
            //加载路径下文件的数据
            NSData *imgData = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@%@",imgSavePath,imgName]];
            //如果存在，就跳过本次循环
            if(imgData)
            {
                //回到主线程，刷新UI
                dispatch_queue_t qu = dispatch_get_main_queue();
                dispatch_async(qu, ^{
                    float pro = (i + 1) * 100.0 / [self.downloadArray count];
                    NSString *str = [NSString stringWithFormat: @"%.2f",pro];
                    self.downloadView.progressLabel.text = str;
                    if([str isEqual: @"100.00"])
                    {
                        [self.downloadView.downloadBtn setImage:UIImageFile(@"btn_进入主界面", @"png") forState:UIControlStateSelected];
                        self.isFinishDownload = YES;
                        [self.downloadView setMessageLabelWithText:self.downloadView.str3 andRangeText:@"数据同步已完成"];
                    }
                });
                continue;
            }
            /*--避免重复下载    结束--*/
            //下载文件
        
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            [[CHYDownloadManager shareDownloadManager] downloadFileURL:imgUrl savePath:imgSavePath fileName:imgName progress:^(NSProgress *downloadProgress) {
                
            } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                //回到主线程，刷新UI
                dispatch_queue_t qu = dispatch_get_main_queue();
                dispatch_async(qu, ^{
                    float pro = (i + 1) * 100.0 / [self.downloadArray count];
                    NSString *str = [NSString stringWithFormat: @"%.2f",pro];
                    self.downloadView.progressLabel.text = str;
                    if([str isEqual: @"100.00"])
                    {
                        [self.downloadView.downloadBtn setImage:UIImageFile(@"btn_进入主界面", @"png") forState:UIControlStateSelected];
                        self.isFinishDownload = YES;
                        [self.downloadView setMessageLabelWithText:self.downloadView.str3 andRangeText:@"数据同步已完成"];
                    }
                });
                dispatch_semaphore_signal(sema);
            }];
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        //下载完成,修改最后一次同步时间
        NSDate *date = [NSDate date];
        NSString *dateStr = [CommonClass formatStringWithDate:date];
        [[CHYDatabaseManager shareDataBaseManager] updateWithTableName:@"UserObj" andNewDataDic:@{@"lastSync":dateStr} andConditionsDic:@{@"UserID":getUD(@"UserID")}];
    });
}

//返回
- (void)backLogin
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end















