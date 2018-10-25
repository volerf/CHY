//
//  DownloadView.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadView : UIView

@property(nonatomic,strong) UILabel *line1;
@property(nonatomic,strong) UILabel *messageLabel;
@property(nonatomic,strong) UILabel *line2;
@property(nonatomic,strong) UIButton *downloadBtn;
@property(nonatomic,strong) UIButton *backBtn;
@property(nonatomic,strong) UILabel *progressLabel;

@property(nonatomic,strong) NSString *str1;
@property(nonatomic,strong) NSString *str2;
@property(nonatomic,strong) NSString *str3;

- (void)setMessageLabelWithText:(NSString *)str andRangeText:(NSString *)rangText;

@end
