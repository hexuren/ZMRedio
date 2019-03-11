//
//  HomeViewController.m
//  Lantu
//
//  Created by hexuren on 17/7/24.
//  Copyright © 2017年 hexuren. All rights reserved.
//

#import "HomeViewController.h"
#import "APPRequest+FMList.h"
#import "ContentCategoryModel.h"
#import "HomeTableCell.h"
#import "DestinationViewController.h"
#import "iAppInfos.h"
#import "EAIntroView.h"
#import "HMSegmentedControl.h"

@import CocoaAsyncSocket; 

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSString *chanelName;
@property (strong, nonatomic) NSMutableArray *musicList;
@property (strong, nonatomic) UITableView *oneTableView;
@property (strong, nonatomic) NSMutableArray *oneInfoArr;
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    [self setUpView];
//    [self requestDefault];
}

- (void)setUpData{
    //    [self setupGuideview];
    _chanelName = @"ZM电台";
    //1综合台、2文艺台、3音乐台、4新闻台、5故事台
    self.title = _chanelName;
    _oneInfoArr = [NSMutableArray new];
    [self loadDataWithType:1];
}

- (void)setUpView{
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.oneTableView];
    [self.view addSubview:self.webView];
    DefineWeakSelf;
    self.oneTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadDataWithType:1];
    }];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

#pragma mark - setter

- (UITableView *)oneTableView{
    if (!_oneTableView){
        _oneTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 70) style:UITableViewStylePlain];
        [_oneTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _oneTableView.delegate = self;
        _oneTableView.dataSource = self;
        _oneTableView.tableFooterView = [UIView new];
    }
    return _oneTableView;
}

- (NSMutableArray *)musicList{
    if (_musicList == nil) {
        _musicList = [NSMutableArray new];
    }
    return _musicList;
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _webView.hidden = YES;
    }
    return _webView;
}

#pragma mark - Utilities


- (void)loadDataWithType:(NSInteger )type{
    DefineWeakSelf;
    NSString *typeStr = @"音乐台";
    //1综合台、2文艺台、3音乐台、4新闻台、5故事台
    switch (type) {
            case 1:
            typeStr = @"综合台";
            break;
            case 2:
            typeStr = @"文艺台";
            break;
            case 3:
            typeStr = @"音乐台";
            break;
            case 4:
            typeStr = @"新闻台";
            break;
            case 5:
            typeStr = @"故事台";
            break;
        default:
            break;
    }
    [APPRequest getCategoryListWithtagName:typeStr successBlock:^(NSURLSessionDataTask *dataTask, id response) {
        ContentCategoryModel *contentCategory = [ContentCategoryModel new];
        contentCategory = response;
        if ([contentCategory.msg isEqualToString:@"成功"]) {
            [weakSelf.oneInfoArr removeAllObjects];
            [weakSelf.oneInfoArr addObjectsFromArray:contentCategory.list];
            [weakSelf.oneTableView reloadData];
            [weakSelf endRefreshing];
        }
        else{
            [weakSelf endRefreshing];
            [SVProgressHUD showErrorWithStatus:contentCategory.msg];
        }
    } errorBlock:^(NSURLSessionDataTask *dataTask, FailureResponseModel *failureResponse) {
        [weakSelf endRefreshing];
        [SVProgressHUD showErrorWithStatus:failureResponse.errorMessage];
    }];
}

- (void)requestDefault{
    if (1) {
        self.title = @"";
        self.navigationController.navigationBarHidden = YES;
        _webView.hidden = NO;
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate.window addSubview:self.webView];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://weibo.com/wuzhimi1992"]]];
    }
}

- (void)endRefreshing{
    [self.oneTableView.mj_header endRefreshing];
}

- (void)setupGuideview{
    // 第一次启动
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    iAppInfos *infoMgr = [iAppInfos sharedInfo];
    
    NSString *firstLaunchKey = [NSString stringWithFormat:@"FirstLaunch%@", infoMgr.appVersion];
    if (![defaults objectForKey:firstLaunchKey]) {
        [defaults setObject:@"FirstLaunch" forKey:firstLaunchKey];
        [defaults synchronize];
        
        //        NSArray *imageNameArray = @[@"image_guide_page1", @"image_guide_page2", @"image_guide_page3", @"image_guide_page4"];
        CGRect frame = CGRectZero;
        frame.size.height = SCREEN_HEIGHT;
        frame.size.width = SCREEN_WIDTH;
        
        EAIntroPage *page1 = [EAIntroPage page];
        page1.title = @"Hello world";
        page1.desc = @"description";
        page1.bgImage = [UIImage imageNamed:@"bg1"];
        // custom
        EAIntroPage *page2 = [EAIntroPage page];
        page2.title = @"This is page 2";
        page2.titleFont = [UIFont fontWithName:@"Georgia-BoldItalic" size:20];
        page2.titlePositionY = 220;
        page2.desc = @"description 2";
        page2.descFont = [UIFont fontWithName:@"Georgia-Italic" size:18];
        page2.descPositionY = 200;
        page2.bgImage = [UIImage imageNamed:@"bg2"];
        page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title2"]];
        page2.titleIconPositionY = 100;
        // custom view from nib
        //        EAIntroPage *page3 = [EAIntroPage pageWithCustomViewFromNibNamed:@"IntroPage"];
        //        page3.bgImage = [UIImage imageNamed:@"bg2"];
        EAIntroView *intro = [[EAIntroView alloc] initWithFrame:frame andPages:@[page1,page2]];
        [intro showInView:APPDELEGATE.window.rootViewController.view animateDuration:0.0];
    }
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.oneInfoArr count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Cell";
    HomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[HomeTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if ([self.oneInfoArr count]) {
        NSMutableDictionary *dic = self.oneInfoArr[indexPath.row];
        [cell updateCellValueWithDict:dic];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 106;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic = self.oneInfoArr[indexPath.row];
    //跳转到专辑播放页
    NSInteger albumId = [dic[@"albumId"] integerValue];
    NSString *title = dic[@"title"];
    DestinationViewController *vc = [[DestinationViewController alloc] initWithAlbumId:albumId title:title];
    // 隐藏状态栏及底部栏
    vc.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.hidden = YES;
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
