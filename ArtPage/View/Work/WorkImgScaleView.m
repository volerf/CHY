//
//  WorkImgView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/11.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "WorkImgScaleView.h"

@implementation WorkImgScaleView

- (id)initWithImage:(UIImage *)image
{
    if(self = [super init])
    {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bouncesZoom = YES;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 3.0;
        
        
        UIImageView *textImage = [[UIImageView alloc] initWithImage:image];
        
        //移除上一个imgView
//        [_imgView removeFromSuperview];
        
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.frame = [self setImageView:textImage];
        _imgView.image = image;
        [self addSubview:_imgView];
        
        self.contentSize = self.imgView.frame.size;
        
        
    }
    return self;
}

//根据图片的比例设置尺寸
- (CGRect)setImageView:(UIImageView *)imageView
{
    CGFloat imageW = imageView.frame.size.width;
    CGFloat imageH = imageView.frame.size.height;
    CGRect imgFrame;
    CGFloat CGscale;
    
    if((SCREENWIDTH / SCREENHEIGHT) > (imageW / imageH))
    {
        CGscale = SCREENHEIGHT / imageH;
        imageW = imageW * CGscale;
        imgFrame = CGRectMake((SCREENWIDTH - imageW) / 2, 0, imageW, SCREENHEIGHT);
        return imgFrame;
    }
    else
    {
        CGscale = SCREENWIDTH / imageW;
        imageH = imageH * CGscale;
        imgFrame = CGRectMake(0, (SCREENHEIGHT - imageH) / 2, SCREENWIDTH, imageH);
        return imgFrame;
    }
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0;
    self.imgView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgView;
}

@end
