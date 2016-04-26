//
//  BaseViewController.h
//  SunnyManager
//
//  Created by mfwl on 16/4/22.
//  Copyright © 2016年 bf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController



@property (nonatomic, strong) NSDictionary *userInfo;
/**
 *  返回上一页
 */
-(void)backAction;

/**
 *  返回到跟视图
 */
-(void)backRootVCAction;

@end
