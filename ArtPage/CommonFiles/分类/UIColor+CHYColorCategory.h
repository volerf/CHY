//
//  UIColor+CHYColorCategory.h
//  滴滴工程
//
//  Created by 华杉科技 on 2018/8/21.
//  Copyright © 2018年 chy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CHYColorCategory)

+(UIColor *)colorWithRed:(CGFloat)red
                   green:(CGFloat)green
                    blue:(CGFloat)blue;

//十六进制颜色
+(UIColor *)colorWithHexadecimal:(int)hexNum;

@end
