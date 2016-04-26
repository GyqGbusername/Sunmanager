//
//  BaseViewController.m
//  SunnyManager
//
//  Created by mfwl on 16/4/22.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
         self.userInfo = [self readNSUserDefaults];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    //设置HUD的样式
    self.view.backgroundColor = k_Color_BACKCOLOR;
    [self setHUDStyle];
   
    // Do any additional setup after loading the view.
}
- (id)readNSUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults dictionaryForKey:@"userInfoRecord"]; /* 读取 */
}
-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}


#pragma mark - 私有方法

-(void)setHUDStyle
{
    [SVProgressHUD setFont:[UIFont systemFontOfSize:13]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:22/255.0 green:22/255.0 blue:22/255.0 alpha:0.7]];
    [SVProgressHUD setRingThickness:1.5];
}

#pragma mark - 公共方法
/**
 *  返回上一页
 */
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  返回跟视图
 */
-(void)backRootVCAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
