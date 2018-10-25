//
//  UIColor+CHYColorCategory.m
//  滴滴工程
//
//  Created by 华杉科技 on 2018/8/21.
//  Copyright © 2018年 chy. All rights reserved.
//

#import "UIColor+CHYColorCategory.h"

@implementation UIColor (CHYColorCategory)

+(UIColor *)colorWithRed:(CGFloat)red
                   green:(CGFloat)green
                    blue:(CGFloat)blue
{
    UIColor *customColor = [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1];
    
    return customColor;
}

+(UIColor *)colorWithHexadecimal:(int)hexNum
{
    return [UIColor colorWithRed:((float)((hexNum & 0xFF0000) >> 16))/255.0 green:((float)((hexNum & 0xFF00) >> 8))/255.0 blue:((float)(hexNum & 0xFF))/255.0 alpha:1.0];
}

@end
