//
//  UIImageView+SLImageViewCategory.m
//  GeneralPractice
//
//  Created by Travelcolor on 2018/8/12.
//  Copyright © 2018年 Travelcolor. All rights reserved.
//

#import "UIImageView+CHYImageViewCategory.h"

@implementation UIImageView (CHYImageViewCategory)

+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image
{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    
    [imageView setImage:image];
    
    return  imageView;
    
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName
{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    [imageView setImage:image];
    
    return imageView;
    
}

@end
