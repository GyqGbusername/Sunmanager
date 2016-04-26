//
//  HomePageVC.m
//  SunnyManager
//
//  Created by mfwl on 16/4/22.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "HomePageVC.h"
#import "QueueViewController.h"
#import "AppointmentViewController.h"
#import "CallListViewController.h"
#import "OrderViewController.h"
#import "BillViewController.h"

@interface HomePageVC ()
@property (strong, nonatomic) IBOutlet UILabel *titleLb;

@property (strong, nonatomic) IBOutlet UIButton *queue;
@property (strong, nonatomic) IBOutlet UIButton *appi;

@property (strong, nonatomic) IBOutlet UIButton *call;

@property (strong, nonatomic) IBOutlet UIButton *order;
@property (strong, nonatomic) IBOutlet UIButton *bill;

@end

@implementation HomePageVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    
    }
    return self;
}
- (IBAction)opreation:(UIButton *)sender {
    switch (sender.tag) {
        case 1: {
            QueueViewController *queueVC = [[QueueViewController alloc] init];
            [self.navigationController pushViewController:queueVC animated:YES];
        }
            
            break;
        case 2: {
            AppointmentViewController *ment = [[AppointmentViewController alloc] init];
            [self.navigationController pushViewController:ment animated:YES];
        }
            
            break;
        case 3: {
            CallListViewController *callList = [[CallListViewController alloc] init];
            [self.navigationController pushViewController:callList animated:YES];
        }
            
            break;
        case 4: {
            OrderViewController *order = [[OrderViewController alloc] init];
            [self.navigationController pushViewController:order animated:YES];
        }
            
            break;
        case 5: {
            BillViewController *bill = [[BillViewController alloc] init];
            [self.navigationController pushViewController:bill animated:YES];
        }
            
            break;
   
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    if (!self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBar.hidden = YES;

    }
    if (self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = NO;
    }
}
- (void)setKit {
    _titleLb.text = _titleName;
    _queue.layer.borderWidth = 1;
    _queue.layer.borderColor = k_Color_Lightgrey.CGColor;
    _appi.layer.borderWidth = 1;
    _appi.layer.borderColor = k_Color_Lightgrey.CGColor;
    _call.layer.borderWidth = 1;
    _call.layer.borderColor = k_Color_Lightgrey.CGColor;
    _order.layer.borderWidth = 1;
    _order.layer.borderColor = k_Color_Lightgrey.CGColor;
    _bill.layer.borderWidth = 1;
    _bill.layer.borderColor = k_Color_Lightgrey.CGColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setKit];
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
