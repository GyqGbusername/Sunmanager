//
//  LoginVC.m
//  SunnyManager
//
//  Created by mfwl on 16/4/22.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "LoginVC.h"


@interface LoginVC ()
@property (strong, nonatomic) IBOutlet UITextField *userName;

@property (strong, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation LoginVC


+ (LoginVC *)sharedManager
{
    static LoginVC *sharedLoginManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedLoginManagerInstance = [[self alloc] init];
    });
    return sharedLoginManagerInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (IBAction)login:(id)sender {
    if (_userName.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"账号不能为空"];
        return;
    }
    if (_pwd.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        return;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, login_action];
    NSDictionary *paramDic = @{
                               @"actionname":@"Businesslogin",
                               @"loginname":_userName.text,
                               @"tokentype":@"2",
                               @"token":@"",
                               @"pwd":_pwd.text
                               };
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:JSONStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        NSDictionary *dic = result[@"obj"][0];
         [self recordLoginWith:dic];
    } withFail:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"账号或密码不正确"];

    }];
   
}

- (void)recordLoginWith:(id)dic {
    [self saveNSUserDefaultsWith:@"NO" with:dic];
    [self.delegate loginWith:dic];
    [self dismissViewControllerAnimated:YES completion:^{
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
