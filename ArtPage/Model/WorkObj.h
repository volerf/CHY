//
//  WorkObj.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/21.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkObj : NSObject

@property(nonatomic,strong) NSString *GroupID;
@property(nonatomic,strong) NSString *ArtWorkID;
@property(nonatomic,strong) NSString *ARTWORK_NAME_CN;
@property(nonatomic,strong) NSString *ARTWORK_NAME_EN;
@property(nonatomic,strong) NSString *ARTWORK_DESC_CN;
@property(nonatomic,strong) NSString *ARTWORK_DESC_EN;
@property(nonatomic,strong) NSString *ARTWORK_FILE_COMMON;
@property(nonatomic,strong) NSString *ARTWORK_FILE_ORIGINAL;
@property(nonatomic,strong) NSString *ARTWORK_THUMBNAIL;
@property(nonatomic,strong) NSString *ARTWORK_FILE_1600;

@property(nonatomic,strong) NSString *ARTWORK_SORT;
@property(nonatomic,strong) NSString *ARTWORK_TAG;
@property(nonatomic,strong) NSString *ARTWORK_CREATEDATE;
@property(nonatomic,strong) NSString *ARKWORK_LASTUPDATEDATE;


@end
