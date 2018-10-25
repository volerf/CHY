//
//  WorkInfoView.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/5.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkInfoView : UIScrollView

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *contentLabel;


- (id)initWithTitle:(NSString *)title andContent:(NSString *)content width:(CGFloat)width;

@end
