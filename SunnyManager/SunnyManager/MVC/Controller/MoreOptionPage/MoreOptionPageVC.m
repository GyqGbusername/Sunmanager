//
//  MoreOptionPageVC.m
//  SunnyManager
//
//  Created by mfwl on 16/4/22.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "MoreOptionPageVC.h"
#import "FeedBackVC.h"
#import "AboutUsViewController.h"
#import "LoginVC.h"

@interface MoreOptionPageVC ()

@property (strong, nonatomic) IBOutlet UIView *feedBack;

@property (strong, nonatomic) IBOutlet UIView *update;

@property (strong, nonatomic) IBOutlet UIView *aboutUs;
@property (strong, nonatomic) IBOutlet UILabel *versionLb;

@end

@implementation MoreOptionPageVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navigationController.navigationBar.hidden = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    if(!self.navigationController.navigationBar.hidden) {
        self.navigationController.navigationBar.hidden = YES;
    }
    if (self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void)addTap {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_feedBack addGestureRecognizer:tap];
    UITapGestureRecognizer *tapo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_update addGestureRecognizer:tapo];
    UITapGestureRecognizer *tapt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_aboutUs addGestureRecognizer:tapt];
    
    
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if ([tap.view isEqual:_feedBack]) {
        FeedBackVC *feed = [[FeedBackVC alloc] init];
        [self.navigationController pushViewController:feed animated:YES];
    } else if ([tap.view isEqual:_update]) {
        [self selectUpdate];
       
    } else {
        AboutUsViewController *about = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:about animated:YES];
    }
    
}
- (void)selectUpdate {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL , queryversion];

    NSDictionary *paramDic = @{
                               @"actionname":@"QueryShopVersion",
                               @"type":@"1"
                               };
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:JSONStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        NSLog(@"%@", result);
        if ([result[@"code"] integerValue]==200) {
            [SVProgressHUD showInfoWithStatus:@"已获取最新版本信息"];
            NSDictionary *dic = result[@"obj"][0];
            _versionLb.text = [NSString stringWithFormat:@"最新版本%@",dic[@"name"]];
            [self openWith:dic[@"url"]];
           
        }
    } withFail:^(NSError *error) {
        
    }];
    
}
- (void)openWith:(NSString *)urlStr {
    
    BOOL res = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]];
    
    if (res) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        
    }
    
}


- (IBAction)exit:(id)sender {
    [self saveNSUserDefaultsWith:@"YES" with:@{}];
    [self presentViewController:[LoginVC sharedManager] animated:YES completion:^{
        
    }];
}


/* 保存数据到NSUserDefaults */
- (void)saveNSUserDefaultsWith:(NSString *)str with:(NSDictionary *)dic {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:str forKey:@"FirstLogin"];
    [userDefaults setObject:dic forKey:@"userInfoRecord"];
    
    /* 这里建议同步存储到磁盘中，不写也可以建议写 */
    [userDefaults synchronize];
}

- (id)readNSUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:@"FirstLogin"]; /* 读取 */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTap];
    // Do any additional setup after loading the view from its nib.
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
