//
//  UITextField+SLTextFieldCategory.m
//  GeneralPractice
//
//  Created by Travelcolor on 2018/8/12.
//  Copyright © 2018年 Travelcolor. All rights reserved.
//

#import "UITextField+CHYTextFieldCategory.h"

@implementation UITextField (CHYTextFieldCategory)


//创建textField,无图片，有密码。

+(UITextField *)textFieldWithFrame:(CGRect )frame
                     backgroundColor:(UIColor*)color
                     secureTextEntry:(BOOL)secureTextEntry
                         placeholder:(NSString *)str
                clearsOnBeginEditing:(BOOL)clearsOnBeginEditing
                       andDelegate:(id)vc
{
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = frame ;
    textField.backgroundColor = color;
    textField.secureTextEntry =secureTextEntry;
    textField.placeholder = str;
    textField.delegate = vc;
    textField.clearsOnBeginEditing =clearsOnBeginEditing;
    return textField;
}

//创建textField,无图片，无密码。

+(UITextField *)textFieldWithFrame:(CGRect )frame
                     backgroundColor:(UIColor*)color
                         placeholder:(NSString *)str
                clearsOnBeginEditing:(BOOL)clearsOnBeginEditing
                       andDelegate:(id)vc
{
    
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = frame;
    textField.backgroundColor = color;
    textField.placeholder = str;
    textField.delegate = vc;
    textField.clearsOnBeginEditing = clearsOnBeginEditing;
    return textField;
    
}



//创建textField,有图片，无密码。

+(UITextField *)textFieldWithFrame:(CGRect )frame
                          background:(UIImage *)image
                         placeholder:(NSString *)str
                clearsOnBeginEditing:(BOOL)clearsOnBeginEditing
                       andDelegate:(id)vc
{
    
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = frame ;
    textField.background = image ;
    textField.placeholder = str;
    textField.delegate = vc;
    textField.clearsOnBeginEditing =clearsOnBeginEditing;
    return textField;
}

//创建textField,有图片，有密码。

+(UITextField *)textFieldWithFrame:(CGRect )frame
                          background:(UIImage *)image
                     secureTextEntry:(BOOL)secureTextEntry
                         placeholder:(NSString *)str
                clearsOnBeginEditing:(BOOL)clearsOnBeginEditing
                       andDelegate:(id)vc
{
    
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = frame ;
    textField.background = image ;
    textField.secureTextEntry =secureTextEntry;
    textField.delegate = vc;
    textField.placeholder = str;
    textField.clearsOnBeginEditing =clearsOnBeginEditing;
    return textField;
}

@end
