//
//  DownloadView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "DownloadView.h"

@implementation DownloadView

- (id)init
{
    if(self = [super init])
    {
        _str1 = @"数据同步 | 执行该步骤将会下载您在ArtPage上的全部图片与相关数据，200张图片的下载容量约为20M，建议在WIFI环境下使用该功能，以免产生额外的流量费用。";
        _str2 = @"数据同步中 | 取消下载会暂时停止同步数据，下次同步时会继续从本次下载的进度开始同步。";
        _str3 = @"数据同步已完成 | 您在ArtPage上的全部图片与相关数据已同步到当前设备中。如需管理分组及作品，请使用浏览器访问网页端ArtPage。";
        
        //第一条横线
        _line1 = [[UILabel alloc] init];
        _line1.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_line1];
        [_line1 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(90);
            make.left.right.equalTo(0);
            make.height.equalTo(1);
        }];
        
        
        [self setMessageLabelWithText:_str1 andRangeText:@"数据同步"];
        
        
        //download按钮
        _downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downloadBtn setImage:UIImageFile(@"btn_开始下载", @"png") forState:UIControlStateNormal];
        [_downloadBtn setImage:UIImageFile(@"btn_取消下载", @"png") forState:UIControlStateSelected];
        [self addSubview:_downloadBtn];
        [_downloadBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line2.bottom).offset(20);
            make.centerX.equalTo(self.centerX);
            make.size.equalTo(CGSizeMake(280, 47));
        }];
        
        //返回按钮
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"btn_返回"] forState:UIControlStateNormal];
        [self addSubview:_backBtn];
        [_backBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(17);
            make.bottom.equalTo(-10);
            make.size.equalTo(CGSizeMake(22, 37));
        }];
        
        UILabel *progress = [[UILabel alloc] init];
        progress.text = @"%";
        progress.textColor = [UIColor colorWithHexadecimal:0xcccccc];
        progress.font = [UIFont systemFontOfSize:50.0];
        progress.textAlignment = NSTextAlignmentRight;
        [self addSubview:progress];
        [progress makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-20);
            make.bottom.equalTo(-10);
            make.width.equalTo(50);
            make.height.equalTo(50);
        }];
        
        //进度数组
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.text = @"0.00";
        _progressLabel.textColor = [UIColor colorWithHexadecimal:0xcccccc];
        _progressLabel.font = [UIFont systemFontOfSize:50.0];
        _progressLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_progressLabel];
        [_progressLabel makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(progress.left).offset(0);
            make.bottom.equalTo(-10);
            make.left.equalTo(50);
            make.height.equalTo(50);
        }];
        
    }
    return self;
}

//初始化Message
- (void)setMessageLabelWithText:(NSString *)str andRangeText:(NSString *)rangText
{
    //提示信息Label
    _messageLabel.attributedText = nil;
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.numberOfLines = 0;
    _messageLabel.font = [UIFont systemFontOfSize:14.0];
    _messageLabel.textColor = [UIColor colorWithHexadecimal:0xa0a0a0];
    _messageLabel.attributedText = [self setAttribute: str andRangeString:rangText];
    CGSize contentSize = [_str1 boundingRectWithSize:CGSizeMake(SCREENWIDTH - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
    CGSize size = [_messageLabel sizeThatFits:contentSize];
    
    [self addSubview:_messageLabel];
    [_messageLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.bottom).offset(20);
        make.left.equalTo(20);
        make.width.equalTo(SCREENWIDTH - 40);
        make.height.equalTo(size.height);
    }];
    
    //第二条横线
    _line2.backgroundColor = [UIColor clearColor];
    _line2 = [[UILabel alloc] init];
    _line2.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_line2];
    [_line2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.bottom).offset(20);
        make.left.right.equalTo(0);
        make.height.equalTo(1);
    }];
}

//属性字符串
-(NSMutableAttributedString *)setAttribute:(NSString *)str andRangeString:(NSString *)rangeStr
{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:7.0];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [str length])];
    
    NSRange range = [[attributeStr string] rangeOfString:rangeStr];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightBold] range:range];
    return attributeStr;
}

@end
















