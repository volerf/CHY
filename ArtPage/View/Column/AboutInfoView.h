//
//  AboutInfoView.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/29.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutInfoView : UIView

@property(nonatomic,strong) UILabel *leftLabel;
@property(nonatomic,strong) UILabel *rightLabel;

- (void)setTitle:(NSString *)title andText:(NSString *)text;

@end
