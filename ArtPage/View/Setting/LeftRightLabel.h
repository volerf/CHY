//
//  LeftRightLabel.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/8.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftRightLabel : UIView

@property(nonatomic,strong) UILabel *leftLabel;
@property(nonatomic,strong) UILabel *rightLabel;

- (id)initWithLeftText:(NSString *)leftText andRightText:(NSString *)rightText;

@end
