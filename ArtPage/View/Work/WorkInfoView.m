//
//  WorkInfoView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/5.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "WorkInfoView.h"

@implementation WorkInfoView

- (id)initWithTitle:(NSString *)title andContent:(NSString *)content width:(CGFloat)width
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        
        _titleLabel = [UILabel labelWithBgColor:[UIColor clearColor] text:title textColor:[UIColor colorWithHexadecimal:0xa0a0a0] fontSize:18.0 textAlignment:NSTextAlignmentLeft];
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(20);
            make.width.equalTo(width - 40);
            make.height.equalTo(40);
        }];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:12.0];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.attributedText = [self setAttribute:content];
        [self addSubview:_contentLabel];
        
        CGSize contentSize = [content boundingRectWithSize:CGSizeMake(width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil].size;
        CGSize size = [_contentLabel sizeThatFits:contentSize];
        
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.top.equalTo(self.titleLabel.bottom).offset(0);
            make.width.equalTo(width - 40);
            make.height.equalTo(size.height);
        }];
        
        [self layoutIfNeeded];
        self.contentSize = CGSizeMake(width, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height);
        
    }
    return self;
}

- (NSMutableAttributedString *)setAttribute:(NSString *)str
{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:12.0];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [str length])];
    return attributeStr;
}

@end











