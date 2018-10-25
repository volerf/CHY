//
//  UIAlertController+CHYCustomAlert.h
//  滴滴工程
//
//  Created by 华杉科技 on 2018/8/23.
//  Copyright © 2018年 chy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (CHYCustomAlert)

//弹出提示框，只提示信息
+(UIAlertController *)alertCancelWithTitle:(NSString *)title andMessage:(NSString *)msg andCancelInfo:(NSString *)cancel;

@end
