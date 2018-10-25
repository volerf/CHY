//
//  UITextField+SLTextFieldCategory.h
//  GeneralPractice
//
//  Created by Travelcolor on 2018/8/12.
//  Copyright © 2018年 Travelcolor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CHYTextFieldCategory)

/** 创建textField,无图片，有密码 */

+(UITextField *)textFieldWithFrame:(CGRect )frame
                     backgroundColor:(UIColor*)color
                     secureTextEntry:(BOOL)secureTextEntry
                         placeholder:(NSString *)str
              clearsOnBeginEditing:(BOOL)clearsOnBeginEditing
                       andDelegate:(id)vc;

/** 创建textField,无图片，无密码 */
+(UITextField *)textFieldWithFrame:(CGRect )frame
                     backgroundColor:(UIColor*)color
                         placeholder:(NSString *)str
                clearsOnBeginEditing:(BOOL)clearsOnBeginEditing
                       andDelegate:(id)vc;

/** 创建textField,有图片，无密码 */
+(UITextField *)textFieldWithFrame:(CGRect )frame
                          background:(UIImage *)image
                         placeholder:(NSString *)str
                clearsOnBeginEditing:(BOOL)clearsOnBeginEditing
                       andDelegate:(id)vc;

/** 创建textField,有图片，有密码 */
+(UITextField *)textFieldWithFrame:(CGRect )frame
                          background:(UIImage *)image
                     secureTextEntry:(BOOL)secureTextEntry
                         placeholder:(NSString *)str
                clearsOnBeginEditing:(BOOL)clearsOnBeginEditing
                       andDelegate:(id)vc;

@end
