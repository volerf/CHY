//
//  ImgLabelBtn.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/9.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "ImgLabelBtn.h"

@implementation ImgLabelBtn

- (id)initWithImgName:(NSString *)imgName andLabelText:(NSString *)text
{
    if(self = [super init])
    {
        _leftImgView = [[UIImageView alloc] initWithImage:UIImageFile(imgName, @"png")];
        [self addSubview:_leftImgView];
        [_leftImgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY);
            make.left.equalTo(20);
            make.size.equalTo(CGSizeMake(21, 21));
        }];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:[UIImage imageNamed:@"btn_允许显示_nor"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"btn_允许显示_sel"] forState:UIControlStateSelected];
        [self addSubview:_rightBtn];
        [_rightBtn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-20);
            make.centerY.equalTo(self.centerY);
            make.size.equalTo(CGSizeMake(34, 21));
        }];
        
        _centerLabel = [[UILabel alloc] init];
        _centerLabel.font = [UIFont systemFontOfSize:13.0];
        _centerLabel.textColor = [UIColor colorWithHexadecimal:0xa0a0a0];
        _centerLabel.textAlignment = NSTextAlignmentLeft;
        _centerLabel.text = text;
        [self addSubview:_centerLabel];
        [_centerLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerY);
            make.left.equalTo(self.leftImgView.right).offset(8);
            make.right.equalTo(self.rightBtn.left).offset(-8);
            make.height.equalTo(53);
        }];
        
        _lineImgView = [[UIImageView alloc] init];
        _lineImgView.backgroundColor = [UIColor colorWithHexadecimal:0xa0a0a0];
        [self addSubview:_lineImgView];
        [_lineImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.bottom.equalTo(-1);
            make.width.equalTo(SCREENWIDTH);
            make.height.equalTo(1);
        }];
        
    }
    return self;
}


@end












