//
//  MusicDetailCell.m
//  BaseProject
//
//  Created by apple-jd33 on 16/2/4.
//  Copyright © 2015年 HansRove. All rights reserved.
//

#import "MusicDetailCell.h"

@implementation MusicDetailCell


- (void)bindAnchorTracksData:(NSDictionary *)tracksDictionary {

    NSURL *iconURL = [NSURL URLWithString:tracksDictionary[@"coverSmall"]];
    [self.coverIV sd_setImageWithURL:iconURL placeholderImage:[UIImage imageNamed:@"album_cover_bg"]];
    self.titleLb.text = tracksDictionary[@"title"];
    self.sourceLb.text = [NSString stringWithFormat:@"by %@",tracksDictionary[@"nickname"]];

    // 获取当前时时间戳
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳
    NSTimeInterval createTime = [tracksDictionary[@"createdAt"] floatValue]/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    NSString *updateStr = nil;
    NSInteger minutes = time/60;
    if (minutes<60) {
        updateStr = [NSString stringWithFormat:@"%ld分钟前",(long)minutes];
    } else {
        // 秒转小时
        NSInteger hours = time/60/60;
        
        if (hours<24) {
            updateStr = [NSString stringWithFormat:@"%ld小时前",(long)hours];
        } else {
            //秒转天数
            NSInteger days = time/3600/24;
            if (days < 30) {
                updateStr = [NSString stringWithFormat:@"%ld天前",(long)days];
            } else {
                //秒转月
                NSInteger months = time/3600/24/30;
                //秒转年
                NSInteger years = time/3600/24/30/12;
                if (months < 12) {
                    updateStr = [NSString stringWithFormat:@"%ld月前",(long)months];
                } else {
                    updateStr = [NSString stringWithFormat:@"%ld年前",(long)years];
                }
            }
        }
    }
    self.updateTimeLb.text = updateStr;
    
    NSString *playCount =tracksDictionary[@"playtimes"] ? [tracksDictionary[@"playtimes"] stringValue] : [tracksDictionary[@"playsCounts"] stringValue];
    self.playCountLb.text = playCount;
    
    NSTimeInterval duration = [tracksDictionary[@"duration"] floatValue];
    // 分
    NSInteger durMinutes = duration/60;
    // 秒
    NSInteger seconds = (NSInteger)duration%60;
    self.durationLb.text = [NSString stringWithFormat:@"%02ld:%02ld",(long)durMinutes,(long)seconds];
    
    NSString *favorCount = tracksDictionary[@"likes"] ? [tracksDictionary[@"likes"] stringValue]: [tracksDictionary[@"sharesCounts"] stringValue];
    self.favorCountLb.text = favorCount;
    NSString *commentCount = tracksDictionary[@"comments"] ? [tracksDictionary[@"comments"] stringValue]: [tracksDictionary[@"commentsCounts"] stringValue];
    self.commentCountLb.text = commentCount;
}

- (UIImageView *)coverIV {
    if(_coverIV == nil) {
        _coverIV = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverIV];
        [_coverIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
        }];
        _coverIV.layer.cornerRadius=50/2;
        //添加播放标识
        UIImageView *playIV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"find_album_play"]];
        [_coverIV addSubview:playIV];
        [playIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.center.mas_equalTo(0);
        }];
    }
    return _coverIV;
}

- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coverIV.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(self.updateTimeLb.mas_left).mas_equalTo(-15);
        }];
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}

- (UILabel *)updateTimeLb {
    if(_updateTimeLb == nil) {
        _updateTimeLb = [[UILabel alloc] init];
        [self.contentView addSubview:_updateTimeLb];
        _updateTimeLb.font=[UIFont systemFontOfSize:12];
        _updateTimeLb.textColor=[UIColor lightGrayColor];
        [_updateTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.right.mas_equalTo(-10);
//            make.width.mas_equalTo(60);
        }];
        _updateTimeLb.textAlignment=NSTextAlignmentRight;
    }
    return _updateTimeLb;
}

- (UILabel *)sourceLb {
    if(_sourceLb == nil) {
        _sourceLb = [[UILabel alloc] init];
        [self.contentView addSubview:_sourceLb];
        [_sourceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.mas_equalTo(self.titleLb.mas_leftMargin);
            make.top.mas_equalTo(self.titleLb.mas_bottom).mas_equalTo(4);
            make.rightMargin.mas_equalTo(self.titleLb.mas_rightMargin);
        }];
        _sourceLb.font=[UIFont systemFontOfSize:12];
        _sourceLb.textColor=[UIColor lightGrayColor];
    }
    return _sourceLb;
}

- (UILabel *)playCountLb {
    if(_playCountLb == nil) {
        _playCountLb = [[UILabel alloc] init];
        [self.contentView addSubview:_playCountLb];
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sound_play"]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 10));
            make.leftMargin.mas_equalTo(self.sourceLb.mas_leftMargin);
            make.bottom.mas_equalTo(-10);
            make.top.mas_equalTo(self.sourceLb.mas_bottom).mas_equalTo(8);
        }];
        [_playCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageView);
            make.left.mas_equalTo(imageView.mas_right).mas_equalTo(3);
        }];
        _playCountLb.textColor=[UIColor lightGrayColor];
        _playCountLb.font=[UIFont systemFontOfSize:10];
    }
    return _playCountLb;
}

- (UILabel *)favorCountLb {
    if(_favorCountLb == nil) {
        _favorCountLb = [[UILabel alloc] init];
        [self.contentView addSubview:_favorCountLb];
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sound_likes_n"]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.playCountLb);
            make.left.mas_equalTo(self.playCountLb.mas_right).mas_equalTo(7);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        _favorCountLb.textColor=[UIColor lightGrayColor];
        _favorCountLb.font=[UIFont systemFontOfSize:10];
        [_favorCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).mas_equalTo(3);
            make.centerY.mas_equalTo(imageView);
        }];
    }
    return _favorCountLb;
}

- (UILabel *)commentCountLb {
    if(_commentCountLb == nil) {
        _commentCountLb = [[UILabel alloc] init];
        [self.contentView addSubview:_commentCountLb];
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sound_comments"]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 10));
            make.left.mas_equalTo(self.favorCountLb.mas_right).mas_equalTo(7);
            make.centerY.mas_equalTo(self.favorCountLb);
        }];
        [_commentCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageView);
            make.left.mas_equalTo(imageView.mas_right).mas_equalTo(3);
        }];
        _commentCountLb.textColor=[UIColor lightGrayColor];
        _commentCountLb.font=[UIFont systemFontOfSize:10];
    }
    return _commentCountLb;
}

- (UILabel *)durationLb {
    if(_durationLb == nil) {
        _durationLb = [[UILabel alloc] init];
        [self.contentView addSubview:_durationLb];
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sound_duration"]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.commentCountLb.mas_right).mas_equalTo(7);
            make.centerY.mas_equalTo(self.commentCountLb);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        [_durationLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).mas_equalTo(3);
            make.centerY.mas_equalTo(imageView);
        }];
        _durationLb.font=[UIFont systemFontOfSize:10];
        _durationLb.textColor=[UIColor lightGrayColor];
    }
    return _durationLb;
}

- (UIButton *)downloadBtn {
    if(_downloadBtn == nil) {
        _downloadBtn = [UIButton buttonWithType:0];
        [_downloadBtn setBackgroundImage:[UIImage imageNamed:@"cell_download"] forState:0];
        DefineWeakSelf;
        [_downloadBtn bk_addEventHandler:^(id sender) {
            if ([weakSelf.delegate respondsToSelector:@selector(musicDetailCellDidClickDownloadButton:)]) {
                [weakSelf.delegate musicDetailCellDidClickDownloadButton:weakSelf.indexPath];
            }
            
            NSLog(@"下载按钮被点击...");
        } forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_downloadBtn];
        [_downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
    }
    return _downloadBtn;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //为了触发下载按钮的懒加载
        self.downloadBtn.hidden = YES;
        
        //设置cell被选中后的背景色
        UIView *view=[UIView new];
        view.backgroundColor=kRGBColor(243, 255, 254);
        self.selectedBackgroundView=view;
        //分割线距离左侧空间        
        self.separatorInset=UIEdgeInsetsMake(0, 76, 0, 0);
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
