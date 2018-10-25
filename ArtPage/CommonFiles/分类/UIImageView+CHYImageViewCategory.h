//
//  UIImageView+SLImageViewCategory.h
//  GeneralPractice
//
//  Created by Travelcolor on 2018/8/12.
//  Copyright © 2018年 Travelcolor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CHYImageViewCategory)


//创建imageView

+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage*)image;

+ (UIImageView *)imageViewWithFrame:(CGRect)frame imageName:(NSString*)imageName;

@end
