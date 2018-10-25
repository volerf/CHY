//
//  CommonClass.m
//  滴滴工程
//
//  Created by 华杉科技 on 2018/9/11.
//  Copyright © 2018年 chy. All rights reserved.
//

#import "CommonClass.h"
//#import "MBProgressHUD.h"
//#import "Reachability.h"

@implementation CommonClass

NSString *result = nil;

//这个方法可以直接把从json中得到的数组中的字典转化为具体的对象，其里面都是封装好的具体对象。
+ (NSMutableArray *)customModel:(NSString *)modelClass ToArray:(id)array
{
    //存放类中属性的数量
    unsigned int propertyCount = 0;
    
    //获取类中所有属性信息的集合并计算属性个数赋值给propertyCount
    objc_property_t *properties = class_copyPropertyList(NSClassFromString(modelClass), &propertyCount);
    
    //创建一个数组存放对象
    NSMutableArray *objectArr = [[NSMutableArray alloc] initWithCapacity:1];
    
    //遍历数组array取出对象存放到数组
    for(int i = 0; i < [array count]; i++)
    {
        id dic = [array objectAtIndex:i];
        
        //若数组的对象不是字典就跳过
        if(![dic isKindOfClass:[NSDictionary class]])
        {
            continue;
        }
        
        //创建一个传过来的字符串对应类型的对象
        id model = [[NSClassFromString(modelClass) alloc] init];
        
        //        [model setValuesForKeysWithDictionary:dic];
        
        //遍历类中所有属性
        for(int j = 0; j < propertyCount; j++)
        {
            //获取类中的第j个属性的信息
            objc_property_t property = properties[j];
            
            //获取类中第j个属性名称并转化成字符串
            NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            
            //获取数组第i个字典内第j个键对应的值
            id value = [dic objectForKey:propertyName];
            
            //判断值是否存在
            if(!value || [value isKindOfClass:[NSNull class]])
            {
                continue;
            }
            
            //给对象名为propertyName的属性赋值
            [model setValue:value forKey:propertyName];
            
        }
        //把赋值完成的对象加到数组中
        [objectArr addObject:model];
    }
    
    
    return objectArr;
}

//字典转模型
+ (NSMutableArray *)customModelName:(NSString *)modelName dataArray:(NSArray *)dataArray
{
    //创建一个存放模型的结果数组
    NSMutableArray *resultArr = [[NSMutableArray alloc] initWithCapacity:1];
    
    //循环遍历数据数组，取出数据，转化为模型对象，保存到模型数组
    for(int i = 0; i < [dataArray count]; ++i)
    {
        //取出数据数组中的一个对象
        id dataDic = dataArray[i];
        //判断该对象是不是字典，防止数据本身有问题导致崩溃
        if(![dataDic isKindOfClass:[NSDictionary class]])
        {
            continue;
        }
        //通过modelName创建一个对象
        id model = [[NSClassFromString(modelName) alloc] init];
        //给对象赋值
        [model setValuesForKeysWithDictionary:dataDic];
        //保存到数组
        [resultArr addObject:model];
    }
    return resultArr;
}

//时间戳
+(NSString *)dateFromIntervalString:(NSString *)strInterval
{
    NSTimeInterval interval = [strInterval doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

//加载提示
//+ (void)showMBProgressHUD:(NSString *)showMessage andWhereView:(UIView *)view
//{
//    MBProgressHUD *loadingView = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    loadingView.label.text = showMessage;
//}
//
//+ (void)hideMBprogressHUD:(UIView *)view
//{
//    [MBProgressHUD hideHUDForView:view animated:YES];
//}

//判断是否有网络连接
//+(BOOL)isConnectionAvailable
//{
//    BOOL isExistenceNetwork = YES;
//
//    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
//    switch ([reach currentReachabilityStatus]) {
//        case NotReachable:
//            isExistenceNetwork = NO;
//            break;
//        case ReachableViaWiFi:
//            isExistenceNetwork = YES;
//            break;
//        case ReachableViaWWAN:
//            isExistenceNetwork = YES;
//            break;
//    }
//
//    return isExistenceNetwork;
//}

//date转字符串
+(NSString *)formatStringWithDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

@end
