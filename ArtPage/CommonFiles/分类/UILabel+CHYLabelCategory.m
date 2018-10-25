//
//  UILabel+SLLabelCategory.m
//  GeneralPractice
//
//  Created by Travelcolor on 2018/8/12.
//  Copyright © 2018年 Travelcolor. All rights reserved.
//

#import "UILabel+CHYLabelCategory.h"

@implementation UILabel (CHYLabelCategory)
/**
 创建label

 @param frame 位置 大小
 @param color 背景颜色
 @param text 文字
 @param textcolor 文字颜色
 @param font 字体大小
 @param numberOfLines 行数
 @param adjustsFontSizeToFitWidth 根据字体大小调整
 @return label
 */
+ (UILabel *)labelWithFrame:(CGRect)frame
             backgroundColor:(UIColor *)color
                        text:(NSString *)text
                   textColor:(UIColor *)textcolor
                        fontSize:(float)size
               textAlignment:(NSTextAlignment)textAlignment
               numberOfLines:(int)numberOfLines
   adjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = color;
    label.text = text;
    label.textColor = textcolor;
    label.font = [UIFont systemFontOfSize:size];
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
    return label;
}

+ (UILabel *)labelWithBgColor:(UIColor *)color
                         text:(NSString *)text
                    textColor:(UIColor *)textcolor
                     fontSize:(float)size
                textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = color;
    label.text = text;
    label.textColor = textcolor;
    label.font = [UIFont systemFontOfSize:size];
    label.textAlignment = textAlignment;
    
    return label;
}


@end
















