//
//  HomeCollectionViewCell.m
//  MiniHelper
//
//  Created by hexuren on 17/8/22.
//  Copyright © 2017年 hexuren. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell ()

@property(strong,nonatomic)UIImageView *imgV;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *priceLab;

@end

@implementation HomeCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame])
    {
        [self.layer setBorderWidth:1.0];
        [self.layer setBorderColor:gMainColor.CGColor];
        [self.imgV setUserInteractionEnabled:YES];
        [self.contentView addSubview:self.imgV];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.priceLab];
    }
    return self;
}

- (void)updateCellValueWithDict:(NSDictionary *)categoryListModel{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:categoryListModel[@"coverMiddle"]] placeholderImage:[UIImage imageNamed:@"album_cover_bg"]];
    [self.titleLab setText:categoryListModel[@"title"]];
    [self.priceLab setText:categoryListModel[@"intro"]];
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 90)];
        _imgV.contentMode = UIViewContentModeScaleAspectFit;
        
        
    }
    return _imgV;
}

-(UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab =[[ UILabel alloc]initWithFrame:CGRectMake(0, 90, self.frame.size.width, 30)];
        [_titleLab setTextAlignment:NSTextAlignmentCenter];
        [_titleLab setNumberOfLines:0];
        [_titleLab setFont:gFontMain15];
        [_titleLab setTextColor:gTextColorMain];
    }
    return _titleLab;
}

-(UILabel *)priceLab
{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, self.frame.size.width, 40)];
        [_priceLab setTextAlignment:NSTextAlignmentCenter];
        [_priceLab setNumberOfLines:0];
        [_priceLab setFont:gFontSub12];
        [_priceLab setTextColor:gTextColorSub];
    }
    return _priceLab;
}


@end
