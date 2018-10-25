//
//  CommonDefine.h
//  滴滴工程
//
//  Created by 华杉科技 on 2018/8/23.
//  Copyright © 2018年 chy. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

//屏幕宽高
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
//控制器背景颜色
#define bgColor [UIColor colorWithRed:30 green:30 blue:30]

//网络请求链接
#define ArtPageURL [NSURL URLWithString:@"http://www.artp.cc/pages/jsonService/jsonForIPad.aspx"]
//向NSUserDefaults添加和取出数据
#define setUD(obj,key) [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key]
#define getUD(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define remUD(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]
//使用imageWithContentOfFile找图片
#define UIImageFile(fileName,fileType) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:fileType]]


#endif /* CommonDefine_h */
