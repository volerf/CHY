//
//  AboutArtPageView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/9.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "AboutArtPageView.h"
#define tColor [UIColor colorWithHexadecimal:0xa0a0a0]

@implementation AboutArtPageView

- (id)init
{
    if(self = [super init])
    {
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, SCREENWIDTH, 1)];
        line1.backgroundColor = tColor;
        [self addSubview:line1];
        
        //版本号
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.text = @"当前版本号 1.0";
        _versionLabel.textColor = tColor;
        _versionLabel.textAlignment = NSTextAlignmentLeft;
        _versionLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightBold];
        [self addSubview:_versionLabel];
        [_versionLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line1.bottom).offset(0);
            make.left.equalTo(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, 54));
        }];
        //线2
        UILabel *line2 = [[UILabel alloc] init];
        line2.backgroundColor = tColor;
        [self addSubview:line2];
        [line2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.versionLabel.bottom).offset(0);
            make.left.equalTo(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
        }];
        //介绍
        _intrLabel = [[UILabel alloc] init];
        _intrLabel.text = @"介绍";
        _intrLabel.textColor = tColor;
        _intrLabel.textAlignment = NSTextAlignmentLeft;
        _intrLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightBold];
        [self addSubview:_intrLabel];
        [_intrLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line2.bottom).offset(15);
            make.left.equalTo(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, 30));
        }];
        //artpage
        _artpLabel = [[UILabel alloc] init];
        _artpLabel.text = @"ArtPage,让作品展示与商业合作更加简单。";
        _artpLabel.textColor = tColor;
        _artpLabel.textAlignment = NSTextAlignmentLeft;
        _artpLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_artpLabel];
        [_artpLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.intrLabel.bottom).offset(0);
            make.left.equalTo(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, 30));
        }];
        //介绍内容
        NSString *str = @"iPhone版ArtPage,可“一键式同步”用户在Web端的数据，以便使用者在离线状态也能够浏览作品与履历。";
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = tColor;
        _contentLabel.font = [UIFont systemFontOfSize:15.0];
        _contentLabel.attributedText = [self setAttributedStr:str];
        CGSize contentSize = [str boundingRectWithSize:CGSizeMake(SCREENWIDTH - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil].size;
        CGSize size = [_contentLabel sizeThatFits:contentSize];
        
        [self addSubview:_contentLabel];
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.artpLabel.bottom).offset(0);
            make.left.equalTo(20);
            make.width.equalTo(SCREENWIDTH - 40);
            make.height.equalTo(size.height);
        }];
        //线3
        UILabel *line3 = [[UILabel alloc] init];
        line3.backgroundColor = tColor;
        [self addSubview:line3];
        [line3 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.bottom).offset(20);
            make.left.equalTo(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
        }];
        //意见
        _ideaLabel = [[UILabel alloc] init];
        _ideaLabel.text = @"意见反馈";
        _ideaLabel.textColor = tColor;
        _ideaLabel.textAlignment = NSTextAlignmentLeft;
        _ideaLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightBold];
        [self addSubview:_ideaLabel];
        [_ideaLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line3.bottom).offset(15);
            make.left.equalTo(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, 30));
        }];
        //邮箱
        _emailLabel = [[UILabel alloc] init];
        _emailLabel.text = @"邮箱：vip@artp.cc";
        _emailLabel.textColor = tColor;
        _emailLabel.textAlignment = NSTextAlignmentLeft;
        _emailLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_emailLabel];
        [_emailLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.ideaLabel.bottom).offset(0);
            make.left.equalTo(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, 30));
        }];
        //qq
        _qqLabel = [[UILabel alloc] init];
        _qqLabel.text = @"QQ：2757388400";
        _qqLabel.textColor = tColor;
        _qqLabel.textAlignment = NSTextAlignmentLeft;
        _qqLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_qqLabel];
        [_qqLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.emailLabel.bottom).offset(0);
            make.left.equalTo(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, 30));
        }];
        //线4
        UILabel *line4 = [[UILabel alloc] init];
        line4.backgroundColor = tColor;
        [self addSubview:line4];
        [line4 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.qqLabel.bottom).offset(20);
            make.left.equalTo(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
        }];
        //网址
        _httpLabel = [[UILabel alloc] init];
        _httpLabel.text = @"网址：http://www.artp.cc";
        _httpLabel.textColor = tColor;
        _httpLabel.textAlignment = NSTextAlignmentLeft;
        _httpLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_httpLabel];
        [_httpLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line4.bottom).offset(0);
            make.left.equalTo(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, 54));
        }];
        //线5
        UILabel *line5 = [[UILabel alloc] init];
        line5.backgroundColor = tColor;
        [self addSubview:line5];
        [line5 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.httpLabel.bottom).offset(0);
            make.left.equalTo(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
        }];
        
        [self layoutIfNeeded];
        self.contentSize = CGSizeMake(SCREENWIDTH, self.httpLabel.frame.origin.y + self.httpLabel.frame.size.height + 20);
    }
    return self;
}

//属性字符串
- (NSMutableAttributedString *)setAttributedStr:(NSString *)str
{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:7.0];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [str length])];
    
    return attributeStr;
}


@end















