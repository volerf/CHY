//
//  NewsContentView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/8.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "NewsContentView.h"

@implementation NewsContentView

- (id)initWithNew:(NewsObj *)log
{
    if(self = [super init])
    {
        //日志标题
        _newsTitle = [[UILabel alloc] init];
        _newsTitle.font = [UIFont systemFontOfSize:18.0];
        _newsTitle.textColor = [UIColor colorWithHexadecimal:0xa0a0a0];
        _newsTitle.textAlignment = NSTextAlignmentLeft;
        [self.scrollView addSubview:_newsTitle];
        [_newsTitle makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(7);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 50, 24));
        }];
        //日期
        _createTime = [[UILabel alloc] init];
        _createTime.font = [UIFont systemFontOfSize:11.0];
        _createTime.textColor = [UIColor colorWithHexadecimal:0x626262];
        _createTime.textAlignment = NSTextAlignmentLeft;
        //转化日期类型
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
        NSDate *createDate = [format dateFromString:log.SUBMIT_DATE];
        [format setDateFormat:@"yyyy-MM-dd"];
        _createTime.text = [format stringFromDate:createDate];

        [self.scrollView addSubview:_createTime];
        [_createTime makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.newsTitle.bottom).offset(0);
            make.left.equalTo(7);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 50, 15));
        }];
        NSString *contentStr;
        if([getUD(@"语言") isEqual:@"中文"])
        {
            _newsTitle.text = log.NAME_CN;
            contentStr = log.CONTENT_CN;
        }
        else{
            _newsTitle.text = log.NAME_EN;
            contentStr = log.CONTENT_EN;
        }
        
        //日志内容
//        _contentLabel = [[UILabel alloc] init];
//        _contentLabel.numberOfLines = 0;
//        _contentLabel.attributedText = [self setHtmlStr: contentStr];
//        [self addSubview:_contentLabel];
//
//        CGSize contentSize = [contentStr boundingRectWithSize:CGSizeMake(SCREENWIDTH - 50, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil].size;
//        CGSize size = [_contentLabel sizeThatFits:contentSize];
//        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(25);
//            make.width.equalTo(SCREENWIDTH - 50);
//            make.top.equalTo(self.createTime.bottom).offset(15);
//            make.height.equalTo(size.height);
//        }];
        
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        [self setBackgroundColor:[UIColor clearColor]];
        [self setOpaque:NO];
        CGFloat width = [[UIScreen mainScreen] bounds].size.width - 50;
        CGFloat fontSize = 13.0;
        NSMutableString *str = [NSMutableString stringWithFormat:@"<html>\
                                <head>\
                                <title></title>\
                                <meta name=\"viewport\" content=\"width=device-width, minimum-scale=1.0, initial-scale=1.0, maximum-scale=1.0, user-scalable=1\" />\
                                </head>\
                                <style>\
                                img {\
                                display:table-cell;\
                                text-align:center;\
                                vertical-align:middle;\
                                max-width:%fpx;\
                                width:expression(this.width<%fpx?\"auto\":\"%fpx\");\
                                max-height:auto;\
                                margin:auto;\
                                }</style>\
                                <body width=\"%fpx\" style=\"\"><div style=\"width:%fpx;height:40px;\"></div><div class=\"header\" style=\"color:#a0a0a0;word-break : break-all;overflow:hidden;width: %fpx;font-size:%fpx\">%@</div></body></html>", width, width, width, width, width, width, fontSize, contentStr];
        
        [str replaceOccurrencesOfString:@"<img" withString:@"<img onclick =\"imgClicked(this)\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [contentStr length] - 1)];
        
        [self loadHTMLString:str baseURL:nil];
        
        
//        [self layoutIfNeeded];
//        self.scrollView.contentSize = CGSizeMake(SCREENWIDTH, self.contentWebView.frame.origin.y + self.contentWebView.frame.size.height + 20);
    }
    return self;
}

#pragma --mark UIWebViewDelegate method
//请求结束
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //改变字体大小
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '80%'"];
    //改变背景颜色
//    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.backgroundColor = '#2d2d2d'"];
    //改变字体颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#a0a0a0'"];
    
    [webView stringByEvaluatingJavaScriptFromString: @"function imgClicked(element) {\
     document.location = element.src;\
     }"];
}

/**
 * 每当webView即将发送一个请求之前，都会调用这个方法
 * 返回YES：允许加载这个请求；返回NO：禁止加载这个请求
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *str = [request.mainDocumentURL pathExtension];
    if ([str isEqualToString:@"png"]||[str isEqualToString:@"jpg"]||[str isEqualToString:@"jpeg"]||[str isEqualToString:@"gif"])
    {
        NSLog(@"%@", [[request URL] absoluteString]);
        
        return NO;
    }
    
    return YES;
}


//文本转换
//- (NSMutableAttributedString *)setHtmlStr:(NSString *)html
//{
//    NSAttributedString *briefAttrStr = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//
//    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:briefAttrStr];
//    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(0, briefAttrStr.length)];
//    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexadecimal:0xb3b4b4] range:NSMakeRange(0, briefAttrStr.length)];
//    return attr;
//}

@end











