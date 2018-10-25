//
//  NewsTableViewCell.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/30.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *headImgView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *dateLabel;
@property(nonatomic,strong) UIButton *shareBtn;

@end
