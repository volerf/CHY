//
//  UIButton+SLButtonCategory.h
//  
//
//  Created by Travelcolor on 2018/8/12.
//

#import <UIKit/UIKit.h>

@interface UIButton (CHYButtonCategory)

/**
 创建图片按钮

 @param normalName 正常图片
 @param highlightedName 高亮图片
 @param action 响应方法
 @return button
 */
+ (UIButton *)buttonWithNormalImage:(NSString *)normalName
                   highlightedImage:(NSString *)highlightedName
                          addTarget:(id)target
                             action:(SEL)action;
/**
 创建按钮
 */
+(UIButton *)buttonWithFrame:(CGRect )frame
             backgroundColor:(UIColor *)color
                    setTitle:(NSString *)title
               setTitleColor:(UIColor *)TitleColor
                       state:(UIControlState)state
                   addTarget:(id)target
                      action:(SEL)action
            forControlEvents:(UIControlEvents)controlEvents;

+(UIButton *)buttonWithFrame:(CGRect )frame
             backgroundColor:(UIColor*)color
                   addTarget:(id)target
                      action:(SEL)action
            forControlEvents:(UIControlEvents)controlEvents;

+(UIButton *)buttonWithFrame:(CGRect )frame
          setBackgroundImage:(UIImage *)image
                    setTitle:(NSString *)title
               setTitleColor:(UIColor *)TitleColor
                   addTarget:(id)target
                      action:(SEL)action
            forControlEvents:(UIControlEvents)controlEvents;


@end
