//
//  LeftRightLabel.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/8.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "LeftRightLabel.h"

@implementation LeftRightLabel

- (id)initWithLeftText:(NSString *)leftText andRightText:(NSString *)rightText
{
    if(self = [super init])
    {
        int i = 0;
        if([getUD(@"语言") isEqual:@"中文"])
        {
            i = 15;
        }else{
            i = 10;
        }
        
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.text = leftText;
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.textColor = [UIColor colorWithHexadecimal:0xa0a0a0];
        _leftLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightBold];
        [self addSubview:_leftLabel];
        [_leftLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.top.equalTo(0);
            make.size.equalTo(CGSizeMake(i * [leftText length], 30));
        }];
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.text = rightText;
        _rightLabel.textAlignment = NSTextAlignmentLeft;
        _rightLabel.textColor = [UIColor colorWithHexadecimal:0x626262];
        _rightLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_rightLabel];
        [_rightLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftLabel.right).offset(0);
            make.top.equalTo(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 40 - i * [leftText length], 30));
        }];
        
        [self layoutIfNeeded];
    }
    return self;
}

@end
