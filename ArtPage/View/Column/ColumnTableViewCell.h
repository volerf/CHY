//
//  ColumnTableViewCell.h
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/26.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColumnTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *headImgView;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) UIButton *shareBtn;

@end
