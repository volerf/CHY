//
//  SetColumnView.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/9.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImgLabelBtn.h"

@interface SetColumnView : UIView

@property(nonatomic,strong) UILabel *msgLabel;
@property(nonatomic,strong) ImgLabelBtn *publicWork;
@property(nonatomic,strong) ImgLabelBtn *nonPublicWork;
@property(nonatomic,strong) ImgLabelBtn *news;
@property(nonatomic,strong) ImgLabelBtn *about;

@end
