//
//  Download.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "DownloadViewModel.h"

@implementation DownloadViewModel

//懒加载
- (AFHTTPSessionManager *)manager
{
    if(!_manager)
    {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:ArtPageURL];
    }
    return _manager;
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


//请求数据
- (void)requestAllDateDownloadArr:(void (^)(NSMutableArray *))dowBlock removeArr:(void (^)(NSMutableArray *))remBlock
{
    //设置manager的完成队列是系统全局并发队列
    self.manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    /*-------------------请求公开分组接口--------------------*/
    [self requestWithDictionary:@{@"Method":@"GetPublicGroup",@"UserID":getUD(@"UserID")} andClassName:@"GroupObj"];
    /*-------------------请求非公开分组接口--------------------*/
    [self requestWithDictionary:@{@"Method":@"GetECPGroup",@"UserID":getUD(@"UserID")} andClassName:@"GroupObj"];
    /*-------------------请求日志接口--------------------*/
    [self requestWithDictionary:@{@"Method":@"GetNewsList",@"UserID":getUD(@"UserID")} andClassName:@"NewsObj"];
    /*-------------------请求关于接口--------------------*/
    [self requestWithDictionary:@{@"Method":@"GetAbout",@"UserID":getUD(@"UserID")} andClassName:@"AboutObj"];
    
    /*-------------------请求分组内图片接口--------------------*/
    //获取所有分组的GroupID
    NSMutableArray *groupArr = [[CHYDatabaseManager shareDataBaseManager] selectAllDataWithTableName:@"GroupObj"];
    for(int i = 0; i < [groupArr count]; i++)
    {
        //创建信号量用于阻塞请求分组图片线程
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        GroupObj *obj = groupArr[i];
        [self.manager GET:@"?" parameters:@{@"Method":@"GetArtWorksByGroup",@"GroupID":obj.GroupID} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            if(dic[@"ErrMessage"] == [NSNull null])
            {
                //获取日志模型数组
                NSMutableArray *workArr = [CommonClass customModelName:@"WorkObj" dataArray:dic[@"data"]];
                //循环遍历数组给每一个对象的GroupID赋值为当前分组的GroupID
                for (WorkObj *work in workArr)
                {
                    work.GroupID = obj.GroupID;
                }
                
                CHYDatabaseManager *dbm = [CHYDatabaseManager shareDataBaseManager];
                //获取数据库中该用户对应group下的所有作品
                NSMutableArray *oldWorks = [dbm selectWithTableName:@"WorkObj" andSelectCondition:@{@"GroupID":obj.GroupID}];
                //删除该用户对应表的所有老数据
                if([dbm deleteWithTableName:@"WorkObj" andConditionsDic:@{@"GroupID":obj.GroupID}])
                {
                    //把新数据模型数组保存到数据库
                    [dbm insertWithTableName:@"WorkObj" andModelArray:workArr];
                }
                else{
                    NSLog(@"删除老数据失败");
                }
                //对比新老数据，找到老数据比新数据多的数据并记录下来
                NSMutableArray *remArr = [[NSMutableArray alloc] initWithCapacity:1];
                for(int i = 0; i < oldWorks.count; i++)
                {
                    if(![dbm isExistsFromTable:@"WorkObj" whereObject:oldWorks[i]])      //此数据图片需要删除
                    {
                        [remArr addObject:oldWorks[i]];       //添加到删除数组
                    }
                }
                //                    [self gainImgMessageWithArray:remArr column:@"ARTWORK_FILE_COMMON" type:@"delete"];
                [self gainImgMessageWithArray:remArr column:@"ARTWORK_FILE_ORIGINAL" type:@"delete"];
                [self gainImgMessageWithArray:remArr column:@"ARTWORK_THUMBNAIL" type:@"delete"];
                //                    [self gainImgMessageWithArray:remArr column:@"ARTWORK_FILE_1600" type:@"delete"];
                
                [dbm.fmdb close];       //用完数据库记得关闭数据库
            }
            else{
                UIAlertController *alert = [UIAlertController alertCancelWithTitle:@"获取分组图片错误" andMessage:dic[@"ErrMessage"] andCancelInfo:@"确定"];
                if(self.alertBlock)
                {
                    self.alertBlock(alert);
                }
            }
            dispatch_semaphore_signal(sema);        //取消阻塞
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            UIAlertController *alert = [UIAlertController alertCancelWithTitle:@"下载失败" andMessage:@"请检查网络状况" andCancelInfo:@"确定"];
            if(self.alertBlock)
            {
                self.alertBlock(alert);
            }
            dispatch_semaphore_signal(sema);        //取消阻塞
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);       //阻塞当前线程
    }
    //开始准备下载数据
    CHYDatabaseManager *dbm = [CHYDatabaseManager shareDataBaseManager];
    //GroupImage
    NSMutableArray *groupArr1 = [dbm selectWithTableName:@"GroupObj" andSelectCondition:@{@"UserID":getUD(@"UserID")}];
    [self gainImgMessageWithArray:groupArr1 column:@"GroupImage" type:@"download"];
    
    //About-ARTIST_IMAGE
    NSMutableArray *aboutArr = [dbm selectWithTableName:@"AboutObj" andSelectCondition:@{@"UserID":getUD(@"UserID")}];
    [self gainImgMessageWithArray:aboutArr column:@"ARTIST_IMAGE" type:@"download"];
    
    //IMAGE_URL
    NSMutableArray *newsArr = [dbm selectWithTableName:@"NewsObj" andSelectCondition:@{@"UserID":getUD(@"UserID")}];
    [self gainImgMessageWithArray:newsArr column:@"IMAGE_URL" type:@"download"];
    
    //获取当前用户的GroupID
    NSMutableArray *groupIdArr = [dbm selectWithColumn:@"GroupID" fromTable:@"GroupObj" whereCondition:@{@"UserID":getUD(@"UserID")}];
    for(int i = 0; i < groupIdArr.count; i++)
    {
        NSMutableArray *workArr = [dbm selectWithTableName:@"WorkObj" andSelectCondition:@{@"GroupID":groupIdArr[i]}];
        //            [self gainImgMessageWithArray:workArr column:@"ARTWORK_FILE_COMMON" type:@"download"];
        [self gainImgMessageWithArray:workArr column:@"ARTWORK_FILE_ORIGINAL" type:@"download"];
        [self gainImgMessageWithArray:workArr column:@"ARTWORK_THUMBNAIL" type:@"download"];
        //            [self gainImgMessageWithArray:workArr column:@"ARTWORK_FILE_1600" type:@"download"];
    }
    //关闭数据库
    [dbm.fmdb close];
    
    //把收集的数据返回到控制器
    if(dowBlock)
    {
        dowBlock(self.downloadArray);
    }
    if(remBlock)
    {
        remBlock(self.removeArray);
    }
}


//封装请求接口
- (void)requestWithDictionary:(NSDictionary *)reqDic andClassName:(NSString *)className
{
    //创建信号量对象，并设置任务的并发执行数量，设置为0会阻碍当前线程
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    [self.manager GET:@"?" parameters:reqDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if(dic[@"ErrMessage"] == [NSNull null])
        {
            //获取模型数组
            NSMutableArray *modelArr = [CommonClass customModelName:className dataArray:dic[@"data"]];
            //循环遍历数组给每一个对象的UserID赋值为当前登录账号的UserID
            for (int i = 0; i < modelArr.count; i++)
            {
                id model = modelArr[i];
                [model setValue:getUD(@"UserID") forKey:@"UserID"];
                if([className isEqual:@"GroupObj"])
                {
                    if([reqDic[@"Method"] isEqual:@"GetPublicGroup"])
                    {
                        [model setValue:@"YES" forKey:@"isPublic"];
                    }
                    else{
                        [model setValue:@"NO" forKey:@"isPublic"];
                    }
                }
            }
            NSDictionary *queryDic;
            if([className isEqual:@"GroupObj"])
            {
                queryDic = @{@"UserID":getUD(@"UserID"), @"isPublic":[modelArr[0] valueForKey:@"isPublic"]};
            }
            else{
                queryDic = @{@"UserID":getUD(@"UserID")};
            }
            //获取数据库中该用户原始的对应表中的数据，即老数据
            NSMutableArray *oldArr = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:className andSelectCondition:queryDic];
            //删除该用户对应表的所有老数据
            if([[CHYDatabaseManager shareDataBaseManager] deleteWithTableName:className andConditionsDic:queryDic])
            {
                //把新数据模型数组保存到数据库
                [[CHYDatabaseManager shareDataBaseManager] insertWithTableName:className andModelArray:modelArr];
            }
            else{
                NSLog(@"删除老数据失败");
            }
            //对比新老数据，找到老数据比新数据多的数据并记录下来
            NSMutableArray *remArr = [[NSMutableArray alloc] initWithCapacity:1];
            for(int i = 0; i < oldArr.count; i++)
            {
                if(![[CHYDatabaseManager shareDataBaseManager] isExistsFromTable:className whereObject:oldArr[i]])      //此数据图片需要删除
                {
                    [remArr addObject:oldArr[i]];       //添加到删除数组
                }
            }
            if([className isEqual:@"GroupObj"])
            {
                [self gainImgMessageWithArray:remArr column:@"GroupImage" type:@"delete"];
            }
            else if([className isEqual: @"NewsObj"])
            {
                [self gainImgMessageWithArray:remArr column:@"IMAGE_URL" type:@"delete"];
            }
            else if([className isEqual:@"AboutObj"])
            {
                [self gainImgMessageWithArray:remArr column:@"ARTIST_IMAGE" type:@"delete"];
            }
        }
        else{
            //在控制器中弹出错误信息提示
            UIAlertController *alert = [UIAlertController alertCancelWithTitle:@"获取数据失败" andMessage:dic[@"ErrMessage"] andCancelInfo:@"确定"];
            if(self.alertBlock)
            {
                self.alertBlock(alert);
            }
        }
        //关闭数据库
        [[CHYDatabaseManager shareDataBaseManager].fmdb close];
        
        dispatch_semaphore_signal(sema);        //解除信号量约束
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //在控制器中弹出错误信息提示
        UIAlertController *alert = [UIAlertController alertCancelWithTitle:@"下载失败" andMessage:@"请检查网络状况" andCancelInfo:@"确定"];
        if(self.alertBlock)
        {
            self.alertBlock(alert);
        }
        
        dispatch_semaphore_signal(sema);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}



//获取图片信息，arr是模型数组，column是图片所在列名，type是下载图片或删除图片
- (void)gainImgMessageWithArray:(NSMutableArray *)arr column:(NSString *)column type:(NSString *)type
{
    //循环遍历，去除空字符串，拼接开头字符http://www.artp.cc/
    for(int i = 0; i < [arr count]; i++)
    {
        //定义字典保存关键数据
        NSDictionary *dic = [[NSDictionary alloc] init];
        NSString *imgUrl;           //保存下载图片的完整链接
        NSString *imgSavePath;      //保存到本地的路径
        NSString *imgName;          //保存到本地的文件的名称
        
        //取出数组中第一个元素转化为模型
        id model = arr[i];
        NSString *urlStr = [model valueForKey:column];      //获取要下载图片的连接
        if(!urlStr || [urlStr isEqual:@""])             //判断是否为空
        {
            continue;
        }
        //获取原文件的文件名
        NSString *oldFileName = [[NSFileManager defaultManager] displayNameAtPath:[model valueForKey:column]];
        //如果下载的图片是GroupImage
        if([column isEqual:@"GroupImage"])      //分组图片
        {
            //拼接保存路径
            imgSavePath = [NSString stringWithFormat: @"%@/Library/Caches/%@/Group/groupId%@/",NSHomeDirectory(),getUD(@"UserID"),[model valueForKey:@"GroupID"]];
            //拼接保存文件的文件名，[oldFileName pathExtension]表示获取源文件的后缀名
            imgName = [NSString stringWithFormat:@"%@.%@",[model valueForKey:@"GroupID"],[oldFileName pathExtension]];
        }
        else if([column isEqual:@"ARTIST_IMAGE"])       //关于图片
        {
            imgSavePath = [NSString stringWithFormat: @"%@/Library/Caches/%@/About/",NSHomeDirectory(),getUD(@"UserID")];
            imgName = [NSString stringWithFormat:@"ARTIST_IMAGE.%@",[oldFileName pathExtension]];
        }
        else if([column isEqual:@"IMAGE_URL"])      //日志图片
        {
            imgSavePath = [NSString stringWithFormat: @"%@/Library/Caches/%@/News/",NSHomeDirectory(),getUD(@"UserID")];
            imgName = [NSString stringWithFormat:@"%@.%@",[model valueForKey:@"ID"],[oldFileName pathExtension]];
        }
        //        else if([column isEqual: @"ARTWORK_FILE_COMMON"])       //COMMON图片
        //        {
        //            imgSavePath = [NSString stringWithFormat: @"%@/Library/Caches/%@/Group/groupId%@/works/COMMON/",NSHomeDirectory(),getUD(@"UserID"),[model valueForKey:@"GroupID"]];
        //            imgName = [NSString stringWithFormat:@"%@_common.%@",[model valueForKey:@"ArtWorkID"],[oldFileName pathExtension]];
        //        }
        else if([column isEqual: @"ARTWORK_FILE_ORIGINAL"])
        {
            imgSavePath = [NSString stringWithFormat: @"%@/Library/Caches/%@/Group/groupId%@/works/ORIGINAL/",NSHomeDirectory(),getUD(@"UserID"),[model valueForKey:@"GroupID"]];
            imgName = [NSString stringWithFormat:@"%@_original.%@",[model valueForKey:@"ArtWorkID"],[oldFileName pathExtension]];
        }
        else if([column isEqual: @"ARTWORK_THUMBNAIL"])
        {
            imgSavePath = [NSString stringWithFormat: @"%@/Library/Caches/%@/Group/groupId%@/works/THUMBNAIL/",NSHomeDirectory(),getUD(@"UserID"),[model valueForKey:@"GroupID"]];
            imgName = [NSString stringWithFormat:@"%@_thumbnail.%@",[model valueForKey:@"ArtWorkID"],[oldFileName pathExtension]];
        }
        //        else if([column isEqual: @"ARTWORK_FILE_1600"])
        //        {
        //            imgSavePath = [NSString stringWithFormat: @"%@/Library/Caches/%@/Group/groupId%@/works/1600/",NSHomeDirectory(),getUD(@"UserID"),[model valueForKey:@"GroupID"]];
        //            imgName = [NSString stringWithFormat:@"%@_1600.%@",[model valueForKey:@"ArtWorkID"],[oldFileName pathExtension]];
        //        }
        imgUrl = [NSString stringWithFormat:@"http://www.artp.cc/%@",[model valueForKey:column]];
        
        if([type isEqual:@"download"])      //如果要下载图片
        {
            //把下载链接，保存地址，保存的图片名储存在字典中
            dic = @{@"imgUrl":imgUrl, @"imgSavePath":imgSavePath, @"imgName":imgName};
            //把字典添加到下载数组中
            [self.downloadArray addObject:dic];
        }
        else{       //不是要下载图片，即要删除图片
            dic = @{@"imgSavePath":imgSavePath, @"imgName":imgName};
            [self.removeArray addObject:dic];
        }
    }
}


@end
