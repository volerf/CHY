//
//  AboutView.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/29.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "AboutView.h"

@implementation AboutView

- (id)init
{
    if(self = [super init])
    {
        //获取数据
        [self gainAboutData];
        
        _headImgView = [[UIImageView alloc] init];
        _headImgView.image = [UIImage imageWithData: [NSData dataWithContentsOfFile:_baseInfoDic_CN[@"头像"]]];
        [self addSubview:_headImgView];
        [_headImgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(5);
            make.left.equalTo(20);
            make.size.equalTo(CGSizeMake(120, 160));
        }];
        
        //基本信息
        _baseInfoLabel = [[UILabel alloc] init];
        _baseInfoLabel.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightBold];
        _baseInfoLabel.textColor = [UIColor colorWithHexadecimal:0xa0a0a0];
        _baseInfoLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_baseInfoLabel];
        [_baseInfoLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImgView.bottom).offset(10);
            make.left.equalTo(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, 38));
        }];
        //横线
        UILabel *line1 = [[UILabel alloc] init];
        line1.backgroundColor = [UIColor grayColor];
        [self addSubview:line1];
        [line1 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.baseInfoLabel.bottom).offset(0);
            make.left.equalTo(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
        }];
        //姓名
        _nameInfo = [self setInfoWithTopView:line1];
        //区域
        _locationInfo = [self setInfoWithTopView:self.nameInfo];
        //性别
        _genderInfo = [self setInfoWithTopView:self.locationInfo];
        //工具
        _toolInfo = [self setInfoWithTopView:self.genderInfo];
        //擅长
        _expertiseInfo = [self setInfoWithTopView:self.toolInfo];
        //委托
        _availInfo = [self setInfoWithTopView:self.expertiseInfo];
        
        //工作经历
        _expressLabel = [[UILabel alloc] init];
        _expressLabel.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightBold];
        _expressLabel.textColor = [UIColor colorWithHexadecimal:0xa0a0a0];
        _expressLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_expressLabel];
        [_expressLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.availInfo.bottom).offset(25);
            make.left.equalTo(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, 38));
        }];
        
        //横线2
        UILabel *line2 = [[UILabel alloc] init];
        line2.backgroundColor = [UIColor grayColor];
        [self addSubview:line2];
        [line2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.expressLabel.bottom).offset(0);
            make.left.equalTo(0);
            make.size.equalTo(CGSizeMake(SCREENWIDTH, 1));
        }];
        
        NSString *str = @"";
        if([getUD(@"语言") isEqual:@"中文"])
        {
            _baseInfoLabel.text = @"基本信息";
            
            [_nameInfo setTitle:@"真实姓名" andText:_baseInfoDic_CN[@"真实姓名"]];
            [_locationInfo setTitle:@"所在区域" andText:_baseInfoDic_CN[@"所在区域"]];
            [_genderInfo setTitle:@"性别" andText:_baseInfoDic_CN[@"性别"]];
            [_toolInfo setTitle:@"创作工具" andText:_baseInfoDic_CN[@"创作工具"]];
            [_expertiseInfo setTitle:@"擅长领域" andText:_baseInfoDic_CN[@"擅长领域"]];
            [_availInfo setTitle:@"商业委托" andText:_baseInfoDic_CN[@"商业委托"]];
            
            _expressLabel.text = @"工作经历";
            str = _baseInfoDic_CN[@"工作经历"];
        }
        else{
            _baseInfoLabel.text = @"Basic information";
            
            [_nameInfo setTitle:@"Artist name" andText:_baseInfoDic_EN[@"Artist name"]];
            [_locationInfo setTitle:@"Location" andText:_baseInfoDic_EN[@"Location"]];
            [_genderInfo setTitle:@"Gender" andText:_baseInfoDic_EN[@"Gender"]];
            [_toolInfo setTitle:@"Tool" andText:_baseInfoDic_EN[@"Tool"]];
            [_expertiseInfo setTitle:@"expertise" andText:_baseInfoDic_EN[@"expertise"]];
            [_availInfo setTitle:@"avail" andText:_baseInfoDic_EN[@"avail"]];
            
            _expressLabel.text = @"Work experience";
            str = _baseInfoDic_EN[@"Work experience"];
        }
        
        //内容
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:14.0];
        _contentLabel.textColor = [UIColor colorWithHexadecimal:0x626262];
        _contentLabel.attributedText = [self setAttribute: str];
        CGSize contentSize = [str boundingRectWithSize:CGSizeMake(SCREENWIDTH - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil].size;
        CGSize size = [_contentLabel sizeThatFits:contentSize];
        
        [self addSubview:_contentLabel];
        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line2.bottom).offset(10);
            make.left.equalTo(20);
            make.size.equalTo(CGSizeMake(SCREENWIDTH - 40, size.height));
        }];
        
        [self layoutIfNeeded];
        self.contentSize = CGSizeMake(SCREENWIDTH, _contentLabel.frame.origin.y + _contentLabel.frame.size.height + 40);
        
    }
    return self;
}

- (AboutInfoView *)setInfoWithTopView:(UIView *)topView
{
    AboutInfoView *info = [[AboutInfoView alloc] init];
    [self addSubview:info];
    [info makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.bottom).offset(0);
        make.left.equalTo(0);
        make.width.equalTo(SCREENWIDTH);
        make.height.equalTo(30);
    }];
    return info;
}

//属性字符串
-(NSMutableAttributedString *)setAttribute:(NSString *)str
{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:7.0];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [str length])];
    return attributeStr;
}


//准备要显示数据
- (void)gainAboutData
{
    //获取关于数据
    AboutObj *about = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:@"AboutObj" andSelectCondition:@{@"UserID":getUD(@"UserID")}][0];
    //获取头像图片路径
    NSString *oldFileName = [[NSFileManager defaultManager] displayNameAtPath:about.ARTIST_IMAGE];
    NSString *imgSavePath = [NSString stringWithFormat: @"%@/Library/Caches/%@/About/",NSHomeDirectory(),getUD(@"UserID")];
    NSString *imgName = [NSString stringWithFormat:@"ARTIST_IMAGE.%@",[oldFileName pathExtension]];
    NSString *filePath = [NSString stringWithFormat:@"%@%@",imgSavePath,imgName];
    /*-----------获取中文基本信息---------*/
    //获取中文住址
    NSString *address_cn = [NSString stringWithFormat:@"%@ %@",about.ARTIST_LOCATION_COUNTRY_CN,about.ARTIST_LOCATION_CITY_CN];
    NSString *avail_cn;     //是否接受商业委托
    if([about.AvailableForFreelance isEqual:@"1"])
    {
        avail_cn = @"接受";
    }else{
        avail_cn = @"不接受";
    }
    _baseInfoDic_CN = @{@"真实姓名":about.ARTIST_NAME_CN,@"所在区域":address_cn,@"性别":about.GENDER_CN,@"创作工具":about.TOOL_CN,@"擅长领域":about.ARTIST_EXPERTISE_CN,@"商业委托":avail_cn,@"工作经历":about.ARTIST_HuoJiangJingLi_CN,@"头像":filePath};
    
    /*-----------获取英文基本信息---------*/
    //获取英文住址
    NSString *address_en = [NSString stringWithFormat:@"%@ %@",about.ARTIST_LOCATION_COUNTRY_EN,about.ARTIST_LOCATION_CITY_EN];
    NSString *avail_en;     //是否接受商业委托
    if([about.AvailableForFreelance isEqual:@"1"])
    {
        avail_en = @"accept";
    }else{
        avail_en = @"Don't accept";
    }
    _baseInfoDic_EN = @{@"Artist name":about.ARTIST_NAME_EN, @"Location":address_en, @"Gender":about.GENDER_EN, @"Tool":about.TOOL_EN, @"expertise":about.ARTIST_EXPERTISE_EN, @"avail":avail_en, @"Work experience":about.ARTIST_HuoJiangJingLi_EN};
}

@end














