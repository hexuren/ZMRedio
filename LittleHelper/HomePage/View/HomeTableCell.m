//
//  HomeTableCell.m
//  KdFM
//
//  Created by hexuren on 17/6/20.
//  Copyright © 2017年 hexuren. All rights reserved.
//

#import "HomeTableCell.h"

@interface HomeTableCell ()

@property (strong, nonatomic) UIImageView *homeImage;
@property (strong, nonatomic) UILabel *homeTitle;
@property (strong, nonatomic) UILabel *homeIntro;
@property (strong, nonatomic) UIView *separateLine;

@end

@implementation HomeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.homeImage];
        [self.contentView addSubview:self.homeTitle];
        [self.contentView addSubview:self.homeIntro];
        [self.contentView addSubview:self.separateLine];
    }
    return self;
}

- (void)updateCellValueWithDict:(NSDictionary *)categoryListModel{
    [self.homeImage sd_setImageWithURL:[NSURL URLWithString:categoryListModel[@"coverLarge"]] placeholderImage:[UIImage imageNamed:@"album_cover_bg"]];
    [self.homeTitle setText:categoryListModel[@"title"]];
    [self.homeIntro setText:categoryListModel[@"intro"]];
}

-(UIImageView *)homeImage{
    if (_homeImage == nil) {
        _homeImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 86, 86)];
        [_homeImage.layer setMasksToBounds:YES];
        [_homeImage.layer setCornerRadius:43];
    }
    return _homeImage;
}

-(UILabel *) homeTitle {
    if( _homeTitle == nil ) {
        _homeTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 10, SCREEN_WIDTH - 156, 50)];
        [_homeTitle setNumberOfLines:0];
    }
    return _homeTitle;
}

-(UILabel *) homeIntro {
    if( _homeIntro == nil ) {
        _homeIntro = [[UILabel alloc] initWithFrame:CGRectMake(136, CGRectGetMaxY(self.homeTitle.frame)+ 5, SCREEN_WIDTH - 156, 40)];
        [_homeIntro setNumberOfLines:0];
        [_homeIntro setFont:gFontSub12];
        [_homeIntro setTextColor:gTextColorSub];
    }
    return _homeIntro;
}

- (UIView *)separateLine{
    if (_separateLine == nil) {
        _separateLine = [[UIView alloc]initWithFrame:CGRectMake(136,104, SCREEN_WIDTH - 146, 0.5)];
        [_separateLine setBackgroundColor:UIColorFromHex(0xe1e4e6)];
    }
    return _separateLine;
}

@end
