//
//  AboutInfoView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/29.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "AboutInfoView.h"

@implementation AboutInfoView

- (id)init
{
    if(self = [super init])
    {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.textColor = [UIColor colorWithHexadecimal:0xa0a0a0];
        _leftLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
        [self addSubview:_leftLabel];
        [_leftLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.centerY.equalTo(self.centerY);
            make.size.equalTo(CGSizeMake(70, 30));
        }];
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textAlignment = NSTextAlignmentLeft;
        _rightLabel.textColor = [UIColor colorWithHexadecimal:0x626262];
        _rightLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_rightLabel];
        [_rightLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftLabel.right).offset(0);
            make.centerY.equalTo(self.centerY);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 90, 30));
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title andText:(NSString *)text
{
    _leftLabel.text = title;
    _rightLabel.text = text;
}

@end









