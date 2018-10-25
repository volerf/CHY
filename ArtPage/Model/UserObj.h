//
//  UserObj.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/21.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObj : NSObject

@property(nonatomic,strong) NSString *UserID;
@property(nonatomic,strong) NSString *endDate;
@property(nonatomic,strong) NSString *ACCOUNT_DOMAIN;
@property(nonatomic,strong) NSString *ACCOUNT_TYPE2;

@property(nonatomic,strong) NSString *lastSync;

@end
