//
//  CHYDownloadManager.h
//  下载文件
//
//  Created by 华杉科技 on 2018/9/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface CHYDownloadManager : AFHTTPSessionManager

@property(nonatomic,strong) AFURLSessionManager *urlSessionManager;


+ (instancetype)shareDownloadManager;
//指定下载路径和文件名的下载方法
- (void)downloadFileURL:(NSString *)url
               savePath:(NSString *)path
               fileName:(NSString *)fileName
               progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
      completionHandler:(void (^)(NSURLResponse *response,NSURL *filePath, NSError *error))completionHandler;
//使用默认下载路径和文件名的下载方法
- (void)downloadFileURL:(NSString *)url
               progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
      completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

//暂停当前正在下载的任务
- (void)suspendAllDownload;

//继续下载暂停的任务
- (void)continueAllDownload;

//取消所有的下载任务
- (void)cancelAllDownload;


@end
