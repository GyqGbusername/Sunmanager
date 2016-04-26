//
//  FeedBackVC.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/22.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "FeedBackVC.h"

@interface FeedBackVC ()

@property (strong, nonatomic) IBOutlet UIView *navi;

@property (nonatomic, strong) PlaceHolderTextView *phTextView;

@property (strong, nonatomic) IBOutlet UIButton *sure;

@end

@implementation FeedBackVC



- (void)viewWillAppear:(BOOL)animated {
    if (!self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = YES;
    }
}

- (IBAction)back:(id)sender {
    [self backAction];
}

- (PlaceHolderTextView *)phTextView  {
    if (!_phTextView) {
        _phTextView = [[PlaceHolderTextView alloc] init];
        _phTextView.layer.cornerRadius = 20;
        _phTextView.layer.masksToBounds = YES;
        _phTextView.placeholder = @"请输入您的反馈信息";
        _phTextView.font = [UIFont systemFontOfSize:14];
        _phTextView.scrollEnabled = NO;
    
        [self.view addSubview:_phTextView];
        [_phTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.navi.mas_bottom).offset (10);
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15);
            make.bottom.equalTo(self.sure.mas_top).offset (-10);
        }];
    }
    return _phTextView;
}
- (IBAction)sure:(id)sender {
    
    if (_phTextView.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"评论不能为空"];
        return;
    }
   
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, shopfeedback];

    NSDictionary *paramDic = @{
                               @"actionname":@"ShopFeedback",
                               @"shopid":@"1",
                               @"userid":@"1",
                               @"content":_phTextView.text,
                               };
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:JSONStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        if ([result[@"message"] isEqualToString:@"反馈成功"]) {
             [SVProgressHUD showInfoWithStatus:@"反馈成功"];
        }
    } withFail:^(NSError *error) {
       
        
    }];

    
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self phTextView];
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
