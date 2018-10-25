//
//  NewsObj.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/21.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsObj : NSObject

@property(nonatomic,strong) NSString *UserID;
@property(nonatomic,strong) NSString *NAME_CN;
@property(nonatomic,strong) NSString *NAME_EN;
@property(nonatomic,strong) NSString *SUBMIT_DATE;
@property(nonatomic,strong) NSString *IMAGE_URL;
@property(nonatomic,strong) NSString *CONTENT_EN;
@property(nonatomic,strong) NSString *CONTENT_CN;
@property(nonatomic,strong) NSString *CLICK;
@property(nonatomic,strong) NSString *LASTUPDATEDATE;
@property(nonatomic,strong) NSString *ID;

@end
