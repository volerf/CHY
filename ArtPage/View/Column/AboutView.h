//
//  AboutView.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/29.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutInfoView.h"
#import "AboutObj.h"

@interface AboutView : UIScrollView

@property(nonatomic,strong) NSDictionary *baseInfoDic_CN;
@property(nonatomic,strong) NSDictionary *baseInfoDic_EN;

@property(nonatomic,strong) UIImageView *headImgView;
@property(nonatomic,strong) UILabel *baseInfoLabel;
@property(nonatomic,strong) UIImage *line1;
@property(nonatomic,strong) AboutInfoView *nameInfo;
@property(nonatomic,strong) AboutInfoView *locationInfo;
@property(nonatomic,strong) AboutInfoView *genderInfo;
@property(nonatomic,strong) AboutInfoView *toolInfo;
@property(nonatomic,strong) AboutInfoView *expertiseInfo;
@property(nonatomic,strong) AboutInfoView *availInfo;
@property(nonatomic,strong) UILabel *expressLabel;
@property(nonatomic,strong) UILabel *contentLabel;


@end
