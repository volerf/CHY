//
//  AboutObj.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/21.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AboutObj : NSObject

@property(nonatomic,strong) NSString *UserID;
@property(nonatomic,strong) NSString *ARTIST_ABOUT_CN;      //艺术家简介，中文
@property(nonatomic,strong) NSString *ARTIST_ABOUT_EN;      //艺术家简介，英文
@property(nonatomic,strong) NSString *ARTIST_LOCATION_COUNTRY_CN;   //艺术家国籍，中文
@property(nonatomic,strong) NSString *ARTIST_LOCATION_COUNTRY_EN;   //国籍，英文
@property(nonatomic,strong) NSString *ARTIST_LOCATION_CITY_CN;  //所在城市，中文
@property(nonatomic,strong) NSString *ARTIST_LOCATION_CITY_EN;  //所在城市，英文
@property(nonatomic,strong) NSString *GENDER_CN;        //性别，中文
@property(nonatomic,strong) NSString *GENDER_EN;        //性别，英文
@property(nonatomic,strong) NSString *TOOL_CN;      //创作工具，中文
@property(nonatomic,strong) NSString *TOOL_EN;      //创作工具，英文
@property(nonatomic,strong) NSString *CUSTOM_CN;    //自定义中文
@property(nonatomic,strong) NSString *CUSTOM_EN;    //自定义英文
@property(nonatomic,strong) NSString *ARTIST_RESUME_CN;     //简历，中文
@property(nonatomic,strong) NSString *ARTIST_RESUME_EN;     //简历，英文
@property(nonatomic,strong) NSString *ARTIST_NAME_CN;       //艺术家姓名，中文
@property(nonatomic,strong) NSString *ARTIST_NAME_EN;       //艺术家姓名，英文
@property(nonatomic,strong) NSString *ARTIST_ADDRESS_CN;    //住址，中文
@property(nonatomic,strong) NSString *ARTIST_ADDRESS_EN;    //住址，英文
@property(nonatomic,strong) NSString *ARTIST_EXPERTISE_CN;  //擅长的类型，中文
@property(nonatomic,strong) NSString *ARTIST_EXPERTISE_EN;  //擅长的类型，英文
@property(nonatomic,strong) NSString *ARTIST_HuoJiangJingLi_CN;     //获奖经历，中文
@property(nonatomic,strong) NSString *ARTIST_HuoJiangJingLi_EN;     //获奖经历，英文


@property(nonatomic,strong) NSString *LASTUPDATEDATE;   //最后一次修改时间
@property(nonatomic,strong) NSString *ARTIST_TEL;       //电话
@property(nonatomic,strong) NSString *ARTIST_IMAGE;     //艺术家图片
@property(nonatomic,strong) NSString *BIRTHDAY;         //生日
@property(nonatomic,strong) NSString *ARTIST_EMAIL;     //邮箱
@property(nonatomic,strong) NSString *AvailableForFreelance;    //是否接受商业委托








@end
