//
//  UIAlertController+CHYCustomAlert.m
//  滴滴工程
//
//  Created by 华杉科技 on 2018/8/23.
//  Copyright © 2018年 chy. All rights reserved.
//

#import "UIAlertController+CHYCustomAlert.h"

@implementation UIAlertController (CHYCustomAlert)

//弹出框提示信息
+(UIAlertController *)alertCancelWithTitle:(NSString *)title andMessage:(NSString *)msg andCancelInfo:(NSString *)cancel
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        ;
    }];
    [alert addAction:action];
    
    return alert;
}

@end
