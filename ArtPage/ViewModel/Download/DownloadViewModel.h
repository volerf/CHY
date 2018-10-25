//
//  Download.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "GroupObj.h"
#import "NewsObj.h"
#import "AboutObj.h"
#import "WorkObj.h"
#import "CHYDownloadManager.h"
#import "CHYDatabaseManager.h"

@interface DownloadViewModel : NSObject

@property(nonatomic,strong) AFHTTPSessionManager *manager;
@property(nonatomic,strong) NSMutableArray *downloadArray;
@property(nonatomic,strong) NSMutableArray *removeArray;

//返回错误信息弹出框
typedef void(^AlertBlock)(UIAlertController *alert);
@property(nonatomic,copy) AlertBlock alertBlock;

- (void)requestAllDateDownloadArr:(void(^)(NSMutableArray *dowArr))dowBlock
                        removeArr:(void(^)(NSMutableArray *remArr))remBlock;



@end














