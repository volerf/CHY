//
//  SettingView.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/28.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SixItemView.h"
#import "LeftRightLabel.h"

@interface SettingView : UIView

@property(nonatomic,strong) LeftRightLabel *userName;
@property(nonatomic,strong) LeftRightLabel *domainName;
@property(nonatomic,strong) LeftRightLabel *userType;
@property(nonatomic,strong) LeftRightLabel *endDate;
@property(nonatomic,strong) LeftRightLabel *updateDate;
@property(nonatomic,strong) SixItemView *sixItem;

@end
