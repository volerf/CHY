//
//  SetColumnView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/10/9.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "SetColumnView.h"

@implementation SetColumnView

- (id)init
{
    if(self = [super init])
    {
        NSString *str;
        NSString *blodStr;
        NSString *public;
        NSString *non_public;
        NSString *news;
        NSString *about;
        if([getUD(@"语言") isEqual:@"中文"])
        {
            str = @"栏目设定 | 在这里，您可以暂时停用导航中的某些栏目，以应对不同的展示需求。停用后栏目内容不会被删除。";
            blodStr = @"栏目设定";
            public = @"公开分组";
            non_public = @"非公开分组";
            news = @"日志";
            about = @"关于";
        }
        else{
            str = @"Columns set | here, you can temporarily disable the navigation of some columns, in response to a different presentation requirements.After stopping column content will not be deleted.";
            blodStr = @"Columns set";
            public = @"public Works";
            non_public = @"non-public";
            news = @"news";
            about = @"about";
        }
        
        UIImageView *line1 = [[UIImageView alloc] initWithImage:UIImageFile(@"img_首页输入框底线", @"png")];
        [self addSubview:line1];
        [line1 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(90);
            make.left.equalTo(0);
            make.width.equalTo(SCREENWIDTH);
            make.height.equalTo(1);
        }];
        
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.numberOfLines = 0;
        _msgLabel.textColor = [UIColor colorWithHexadecimal:0xa0a0a0];
        _msgLabel.attributedText = [self setAttributedStr:str andBlodStr:blodStr];
        CGSize contentSize = [str boundingRectWithSize:CGSizeMake(SCREENWIDTH - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil].size;
        CGSize size = [_msgLabel sizeThatFits:contentSize];
        
        [self addSubview:_msgLabel];
        [_msgLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line1.bottom).offset(20);
            make.left.equalTo(20);
            make.width.equalTo(SCREENWIDTH - 40);
            make.height.equalTo(size.height);
        }];
        
        UIImageView *line2 = [[UIImageView alloc] initWithImage:UIImageFile(@"img_首页输入框底线", @"png")];
        [self addSubview:line2];
        [line2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.msgLabel.bottom).offset(20);
            make.left.equalTo(0);
            make.width.equalTo(SCREENWIDTH);
            make.height.equalTo(1);
        }];
        
        //公开分组
        _publicWork = [self setImgWithImgName:@"btn_setColumn_公开作品" labelText:public andTopView:line2];
        if([getUD(@"publicWorkIsShow") isEqual:@"NO"])
        {
            _publicWork.rightBtn.selected = YES;
        }
        //非公开作品
        _nonPublicWork = [self setImgWithImgName:@"btn_setColumn_非公开作品" labelText:non_public andTopView:self.publicWork];
        if([getUD(@"nonPublicWorkIsShow") isEqual:@"NO"])
        {
            _nonPublicWork.rightBtn.selected = YES;
        }
        //日志
        _news = [self setImgWithImgName:@"btn_setColumn_日志" labelText:news andTopView:self.nonPublicWork];
        if([getUD(@"newsIsShow") isEqual:@"NO"])
        {
            _news.rightBtn.selected = YES;
        }
        //关于
        _about = [self setImgWithImgName:@"btn_setColumn_关于" labelText:about andTopView:self.news];
        if([getUD(@"aboutIsShow") isEqual:@"NO"])
        {
            _about.rightBtn.selected = YES;
        }
    }
    return self;
}

- (void)isShow:(UIButton *)btn
{
    //公开分组
    if(btn == _publicWork.rightBtn)
    {
        if(!btn.selected)
        {
            btn.selected = YES;
            setUD(@"NO", @"publicWorkIsShow");
        }
        else{
            btn.selected = NO;
            setUD(@"YES", @"publicWorkIsShow");
        }
    }       //非公开分组
    else if(btn == _nonPublicWork.rightBtn)
    {
        if(!btn.selected)
        {
            btn.selected = YES;
            setUD(@"NO", @"nonPublicWorkIsShow");
        }
        else{
            btn.selected = NO;
            setUD(@"YES", @"nonPublicWorkIsShow");
        }
    }       //日志
    else if(btn == _news.rightBtn)
    {
        if(!btn.selected)
        {
            btn.selected = YES;
            setUD(@"NO", @"newsIsShow");
        }
        else{
            btn.selected = NO;
            setUD(@"YES", @"newsIsShow");
        }
    }       //关于
    else if(btn == _about.rightBtn)
    {
        if(!btn.selected)
        {
            btn.selected = YES;
            setUD(@"NO", @"aboutIsShow");
        }
        else{
            btn.selected = NO;
            setUD(@"YES", @"aboutIsShow");
        }
    }
}

- (ImgLabelBtn *)setImgWithImgName:(NSString *)imgName labelText:(NSString *)text andTopView:(UIView *)topView
{
    ImgLabelBtn *ilb = [[ImgLabelBtn alloc] initWithImgName:imgName andLabelText:text];
    [ilb.rightBtn addTarget:self action:@selector(isShow:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ilb];
    [ilb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.bottom).offset(0);
        make.left.equalTo(0);
        make.width.equalTo(SCREENWIDTH);
        make.height.equalTo(53);
    }];
    return ilb;
}

- (NSMutableAttributedString *)setAttributedStr:(NSString *)str andBlodStr:(NSString *)blodStr
{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:7.0];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [str length])];
    
    NSRange range = [str rangeOfString:blodStr];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0 weight:UIFontWeightBold] range:range];
    
    return attributeStr;
}

@end





















