//
//  UIButton+SLButtonCategory.m
//  
//
//  Created by Travelcolor on 2018/8/12.
//

#import "UIButton+CHYButtonCategory.h"

@implementation UIButton (CHYButtonCategory)

+ (UIButton *)buttonWithNormalImage:(NSString *)normalName
                   highlightedImage:(NSString *)highlightedName
                          addTarget:(id)target
                             action:(SEL)action
{
    // 设置按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedName] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+(UIButton *)buttonWithFrame:(CGRect )frame
             backgroundColor:(UIColor*)color
                    setTitle:(NSString *)title
               setTitleColor:(UIColor *)TitleColor
                       state:(UIControlState)state
                   addTarget:(id)target action:(SEL)action
            forControlEvents:(UIControlEvents)controlEvents
{

    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:TitleColor forState:state];
    button.backgroundColor = color;
    [button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    return button;
}



+(UIButton *)buttonWithFrame:(CGRect )frame
             backgroundColor:(UIColor*)color
                   addTarget:(id)target action:(SEL)action
            forControlEvents:(UIControlEvents)controlEvents
{
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = color;
    [button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    return button;
}

+(UIButton *)buttonWithFrame:(CGRect )frame
          setBackgroundImage:(UIImage *)image
                    setTitle:(NSString *)title
               setTitleColor:(UIColor *)TitleColor
                   addTarget:(id)target
                      action:(SEL)action
            forControlEvents:(UIControlEvents)controlEvents
{
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:TitleColor forState:UIControlStateNormal];
    [button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    return button;
}

@end
