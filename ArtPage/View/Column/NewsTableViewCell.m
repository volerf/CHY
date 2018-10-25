//
//  NewsTableViewCell.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/30.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = bgColor;
        //栏目头像图片
        _headImgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headImgView];
        [_headImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(10);
            make.bottom.equalTo(-10);
            make.width.equalTo(105);
        }];
        //栏目标题
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        _titleLabel.textColor = [UIColor colorWithHexadecimal:0xa0a0a0];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(28);
            make.left.equalTo(self.headImgView.right).offset(10);
            make.width.equalTo(SCREENWIDTH - 125 - 40);
            make.height.equalTo(18);
        }];
        //栏目内容
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:11.0];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.textColor = [UIColor colorWithHexadecimal:0x626262];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.bottom).offset(6);
            make.left.equalTo(self.headImgView.right).offset(10);
            make.width.equalTo(SCREENWIDTH - 105 - 40);
            make.bottom.equalTo(-28);
        }];
        //分享按钮
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_shareBtn];
        [_shareBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(34);
            make.bottom.equalTo(-34);
            make.width.equalTo(22);
            make.left.equalTo(self.titleLabel.right).offset(5);
        }];
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
