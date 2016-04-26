//
//  LoginVC.h
//  SunnyManager
//
//  Created by mfwl on 16/4/22.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "BaseViewController.h"

@protocol LoginVCDelegate <NSObject>

- (void)loginWith:(NSDictionary *)dic;

@end

@interface LoginVC : BaseViewController

@property (nonatomic, assign) id <LoginVCDelegate> delegate;

+ (LoginVC *)sharedManager;

@end
