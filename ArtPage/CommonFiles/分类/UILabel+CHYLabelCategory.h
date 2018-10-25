//
//  UILabel+SLLabelCategory.h
//  GeneralPractice
//
//  Created by Travelcolor on 2018/8/12.
//  Copyright © 2018年 Travelcolor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CHYLabelCategory)

/**
 创建lable
 */
+ (UILabel *)labelWithFrame:(CGRect)frame
            backgroundColor:(UIColor *)color
                       text:(NSString *)text
                  textColor:(UIColor *)textcolor
                       fontSize:(float)size
              textAlignment:(NSTextAlignment)textAlignment
              numberOfLines:(int)numberOfLines
  adjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth;

//Masonry下
+ (UILabel *)labelWithBgColor:(UIColor *)color
                         text:(NSString *)text
                    textColor:(UIColor *)textcolor
                     fontSize:(float)size
                textAlignment:(NSTextAlignment)textAlignment;

@end
