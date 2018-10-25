//
//  ImgLabelBtn.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/9.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgLabelBtn : UIView

@property(nonatomic,strong) UIImageView *leftImgView;
@property(nonatomic,strong) UILabel *centerLabel;
@property(nonatomic,strong) UIButton *rightBtn;

@property(nonatomic,strong) UIImageView *lineImgView;

- (id)initWithImgName:(NSString *)imgName andLabelText:(NSString *)text;

@end
