//
//  CommonClass.h
//  滴滴工程
//
//  Created by 华杉科技 on 2018/9/11.
//  Copyright © 2018年 chy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface CommonClass : UIView

/* 字典转模型 */
+ (NSMutableArray *)customModel:(NSString *)modelClass ToArray:(id)array;
+ (NSMutableArray *)customModelName:(NSString *)modelName dataArray:(NSArray *)dataArray;

/* 时间戳转换为时间 */
+(NSString *)dateFromIntervalString:(NSString *)strInterval;

//加载提示
//+ (void)showMBProgressHUD:(NSString *)showMessage andWhereView:(UIView *)view;
//+ (void)hideMBprogressHUD:(UIView *)view;

//判断网络是否连接
//+(BOOL)isConnectionAvailable;

+(NSString *)formatStringWithDate:(NSDate *)date;

@end
