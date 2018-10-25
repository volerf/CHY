//
//  WorkImgView.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/11.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkImgScaleView : UIScrollView<UIScrollViewDelegate>

@property(nonatomic,strong) UIImageView *imgView;

- (id)initWithImage:(UIImage *)image;

@end
