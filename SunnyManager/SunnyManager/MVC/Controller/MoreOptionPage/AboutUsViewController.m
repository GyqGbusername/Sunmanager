//
//  AboutUsViewController.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/22.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewWillAppear:(BOOL)animated {
    if (!self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = YES;
    }
}

- (IBAction)back:(id)sender {
    [self backAction];
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
