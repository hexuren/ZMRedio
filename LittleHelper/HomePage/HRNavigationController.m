//
//  HRNavigationController.m
//  喜马拉雅FM(高仿品)
//
//  Created by apple-jd33 on 15/11/9.
//  Copyright © 2015年 HansRove. All rights reserved.
//

#import "HRNavigationController.h"
#import "HRPlayView.h"
// 播放
#import <AVFoundation/AVFoundation.h>
#import "MediaPlayer/MediaPlayer.h"
//#import "SettingViewController.h"
#import "TracksViewModel.h"

@interface HRNavigationController ()<PlayViewDelegate>
@property (nonatomic,strong) HRPlayView *playView;
@property (nonatomic,strong) NSString *imageName;

@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,assign) BOOL isSelected;
@end

@implementation HRNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 防止其他ViewController的导航被遮挡, 这个类的主要作用是 PlayView
    self.navigationBarHidden = NO;
    _isSelected = NO;
    
    // 开启两个通知接收(HRMeViewController传入)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidePlayView:) name:@"hidePlayView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPlayView:) name:@"showPlayView" object:nil];
    
    // 开启一个通知接受,播放URL 及图片
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playingWithInfoDictionary:) name:@"BeginPlay" object:nil];

    self.playView = [[HRPlayView alloc] init];
    self.playView.delegate = self;
    [self.view addSubview:_playView];
    [_playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
//        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(70);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    // 开始接受远程控制
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    // 接触远程控制
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}
// 重写父类成为响应者方法

- (BOOL)canBecomeFirstResponder{
    return YES;
}

// 隐藏图片
- (void)hidePlayView:(NSNotification *)notification
{
    self.playView.hidden = YES;
}

// 显示图片
- (void)showPlayView:(NSNotification *)notification
{
    self.playView.hidden = NO;
}

/** 通过播放地址 和 播放图片 */
- (void)playingWithInfoDictionary:(NSNotification *)notification {
    // 设置背景图
    NSURL *coverURL = notification.userInfo[@"coverURL"];
    NSURL *musicURL = notification.userInfo[@"musicURL"];
    [self.playView.contentIV sd_setImageWithURL:coverURL];
    
    // 支持后台播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 激活
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    // 开始播放
    APPDELEGATE.player = [AVPlayer playerWithURL:musicURL];
    [APPDELEGATE.player play];
    [self configNowPlayingInfoCenter];
    
    // 已改到背景变化时再变化
//    self.playView.playButton.selected = YES;
    
    //处理中断事件的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterreption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
    //播放完毕后发出通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PlayedidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:APPDELEGATE.player.currentItem];
}

#pragma mark - NSNotification
- (void)PlayedidEnd:(NSNotification *)notice {
    NSInteger currentIndex = [[CommonMethod readFromUserDefaults:@"currentPlayIndex"] integerValue];
    TracksViewModel *tracksVM = [CommonMethod readFromUserDefaults:@"currentTracksVM"];
    if (currentIndex < tracksVM.rowNumber) {
        currentIndex ++;
        [CommonMethod writeToUserDefaults:@(currentIndex) withKey:@"currentPlayIndex"];
        NSURL *coverURL = [tracksVM coverURLForRow:currentIndex];
        NSURL *musicURL = [tracksVM playURLForRow:currentIndex];
        [self.playView.contentIV sd_setImageWithURL:coverURL];
        // 支持后台播放
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        // 激活
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        APPDELEGATE.player = [AVPlayer playerWithURL:musicURL];
        [APPDELEGATE.player play];
        //播放完毕后发出通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PlayedidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:APPDELEGATE.player.currentItem];
    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayNext" object:nil];
}

#pragma mark - 后台控制
- (void)handleInterreption:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    AVAudioSessionInterruptionType type = [info[AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    if (type == AVAudioSessionInterruptionTypeBegan) {
        //Handle InterruptionBegan
        NSLog(@"interruptionTypeBegan");
    }else{
        AVAudioSessionInterruptionOptions options = [info[AVAudioSessionInterruptionOptionKey] unsignedIntegerValue];
        if (options == AVAudioSessionInterruptionOptionShouldResume) {
            //Handle Resume
            [APPDELEGATE.player play];
        }
    }
}

- (void)configNowPlayingInfoCenter{
    NSInteger currentIndex = [[CommonMethod readFromUserDefaults:@"currentPlayIndex"] integerValue];
    TracksViewModel *tracksVM = [CommonMethod readFromUserDefaults:@"currentTracksVM"];
    if (currentIndex < tracksVM.rowNumber) {
        [CommonMethod writeToUserDefaults:@(currentIndex) withKey:@"currentPlayIndex"];
        NSURL *coverURL = [tracksVM coverURLForRow:currentIndex];
        NSString *title = [tracksVM titleForRow:currentIndex];
        NSString *nickName = [tracksVM nickNameForRow:currentIndex];
        NSTimeInterval duration = [tracksVM playDurationForRow:currentIndex];
        UIImageView *coverImageView = [[UIImageView alloc]init];
        [coverImageView sd_setImageWithURL:coverURL];
        MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:(coverImageView.image != nil) ? coverImageView.image : [UIImage imageNamed:@"album_cover_bg"]];
        NSDictionary *dic = @{MPMediaItemPropertyTitle:[title length] ? title : @"音乐台",
                              MPMediaItemPropertyArtist:[nickName length] ? nickName : @"音乐台",
                              MPMediaItemPropertyArtwork:artWork,
                              MPNowPlayingInfoPropertyPlaybackRate:[NSNumber numberWithFloat:1.0],
                              MPMediaItemPropertyPlaybackDuration:[NSNumber numberWithDouble:duration]
                              };
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dic];
        
//        [self getImageWithURL:coverURL OnSucceed:^(UIImage *image) {
//            if (image == nil) {
//                image = [UIImage imageNamed:@"album_cover_bg"];
//            }
//            MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"album_cover_bg"]];
//            NSDictionary *dic = @{MPMediaItemPropertyTitle:[title length] ? title : @"音乐台",
//                                  MPMediaItemPropertyArtist:[nickName length] ? nickName : @"音乐台",
//                                  MPMediaItemPropertyArtwork:artWork,
//                                  MPNowPlayingInfoPropertyPlaybackRate:[NSNumber numberWithFloat:1.0],
//                                  MPMediaItemPropertyPlaybackDuration:[NSNumber numberWithDouble:duration]
//                                  };
//            [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dic];
//        }];
    }
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    //判断是否是后台音频
    DefineWeakSelf;
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlTogglePlayPause:
                //暂停或播放
                [weakSelf doPlay];
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                //上一首
                [weakSelf lastPlay];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                //下一首
                [weakSelf nextPlay];
                break;
                
            default:
                [weakSelf doPlay];
                break;
        }
    }
}

#pragma mark - Utilities
- (void)getImageWithURL:(NSURL *)url OnSucceed:(void(^)(UIImage *image))succeed {
    //获取图片管理
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    //获取缓存key
    NSString *cacheKey = [manager cacheKeyForURL:url];
    [manager cachedImageExistsForURL:url completion:^(BOOL isInCache) {
        if (isInCache) {
            UIImage *image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:cacheKey];
            //如果图片为空，则从本地获取图片
            if (!image) {
                image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheKey];
            }
            //如果还是不存在图片， 则取图标
            if (!image) {
                image = [UIImage imageNamed:@"album_cover_bg"];
            }
        }
        else{
            [manager loadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                //下载图片完成后， 存在图片
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        succeed(image);
                    });
                }else if (error){
                    //如果发生错误，则取图标
                    UIImage *palaceImage = [UIImage imageNamed:@"album_cover_bg"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        succeed(palaceImage);
                    });
                }
            }];
        }
    }];
}

- (void)doPlay{
    if (_isSelected) {
        [APPDELEGATE.player play];  // 继续播放
        _isSelected = NO;
    } else {
        [APPDELEGATE.player pause];  // 暂停播放, 以后会取消, 此处应该是跳转最后一个播放器控制器
        _isSelected = YES;
    }
}

- (void)lastPlay{
    NSInteger currentIndex = [[CommonMethod readFromUserDefaults:@"currentPlayIndex"] integerValue];
    TracksViewModel *tracksVM = [CommonMethod readFromUserDefaults:@"currentTracksVM"];
    if (currentIndex < tracksVM.rowNumber && currentIndex > 0) {
        currentIndex --;
        [CommonMethod writeToUserDefaults:@(currentIndex) withKey:@"currentPlayIndex"];
        NSURL *coverURL = [tracksVM coverURLForRow:currentIndex];
        NSURL *musicURL = [tracksVM playURLForRow:currentIndex];
        [self.playView.contentIV sd_setImageWithURL:coverURL];
        // 支持后台播放
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        // 激活
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        APPDELEGATE.player = [AVPlayer playerWithURL:musicURL];
        [APPDELEGATE.player play];
        [self configNowPlayingInfoCenter];
        //播放完毕后发出通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PlayedidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:APPDELEGATE.player.currentItem];
    }
}

- (void)nextPlay{
    NSInteger currentIndex = [[CommonMethod readFromUserDefaults:@"currentPlayIndex"] integerValue];
    TracksViewModel *tracksVM = [CommonMethod readFromUserDefaults:@"currentTracksVM"];
    if (currentIndex < tracksVM.rowNumber) {
        currentIndex ++;
        [CommonMethod writeToUserDefaults:@(currentIndex) withKey:@"currentPlayIndex"];
        NSURL *coverURL = [tracksVM coverURLForRow:currentIndex];
        NSURL *musicURL = [tracksVM playURLForRow:currentIndex];
        [self.playView.contentIV sd_setImageWithURL:coverURL];
        // 支持后台播放
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        // 激活
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        APPDELEGATE.player = [AVPlayer playerWithURL:musicURL];
        [APPDELEGATE.player play];
        [self configNowPlayingInfoCenter];
        //播放完毕后发出通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PlayedidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:APPDELEGATE.player.currentItem];
    }
}

#pragma mark - PlayView的代理方法
- (void)playButtonDidClick:(BOOL)selected {
    // 按钮被点击方法, 判断按钮的selected状态
    if (selected) {
        [APPDELEGATE.player play];  // 继续播放
    } else {
        [APPDELEGATE.player pause];  // 暂停播放, 以后会取消, 此处应该是跳转最后一个播放器控制器
    }
    _isSelected = selected;
}

- (void)dealloc {
    // 关闭消息中心
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
