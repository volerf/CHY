//
//  CHYDownloadManager.m
//  下载文件
//
//  Created by 华杉科技 on 2018/9/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "CHYDownloadManager.h"

@implementation CHYDownloadManager

//懒加载
- (AFURLSessionManager *)urlSessionManager
{
    if(!_urlSessionManager)
    {
        _urlSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return _urlSessionManager;
}

//获取当前操作对象
+ (instancetype)shareDownloadManager
{
    static CHYDownloadManager *downloadManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadManager = [[CHYDownloadManager alloc] init];
    });
    return downloadManager;
    
}

//指定下载路径和文件名的下载方法
- (void)downloadFileURL:(NSString *)url
               savePath:(NSString *)path
               fileName:(NSString *)fileName
               progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
      completionHandler:(void (^)(NSURLResponse *response,NSURL *filePath, NSError *error))completionHandler
{
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    //创建一个请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //创建一个下载操作
    NSURLSessionDownloadTask *downloadTask = [self.urlSessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress)
    {
        downloadProgressBlock(downloadProgress);
    }
    destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response)
    {
        NSString *p = [path stringByAppendingString:fileName];
        return [NSURL fileURLWithPath: p];
    }
    completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error)
    {
        completionHandler(response, filePath, error);
    }];
    
    //开始下载
    [downloadTask resume];
    
}
//使用默认下载路径和文件名的下载方法
- (void)downloadFileURL:(NSString *)url
               progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
      completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{
    //创建一个请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //创建一个下载操作
    NSURLSessionDownloadTask *downloadTask = [self.urlSessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress){
        
        downloadProgressBlock(downloadProgress);
        
    }destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response){
        NSString *filePath = [NSString stringWithFormat: @"%@/Library/Caches/%@",NSHomeDirectory(),response.suggestedFilename];     //沙盒路径 + /Library/Caches/ + 文件名
        return [NSURL fileURLWithPath:filePath];
        
    }completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error){
        completionHandler(response, filePath, error);
    }];
    
    //开始下载
    [downloadTask resume];
}

//暂停当前正在下载的任务
- (void)suspendAllDownload
{
    if(_urlSessionManager)
    {
        //循环遍历下载任务，逐个暂停
        for(NSURLSessionDownloadTask *task in _urlSessionManager.tasks)
        {
            [task suspend];
        }
    }
}

//继续下载暂停的任务
- (void)continueAllDownload
{
    if(_urlSessionManager)
    {
        for(NSURLSessionDownloadTask *task in _urlSessionManager.tasks)
        {
            [task resume];
        }
    }
}

//取消所有的下载任务
- (void)cancelAllDownload
{
    if(_urlSessionManager)
    {
        for(NSURLSessionDownloadTask *task in _urlSessionManager.tasks)
        {
            [task cancel];
        }
    }
}


@end
