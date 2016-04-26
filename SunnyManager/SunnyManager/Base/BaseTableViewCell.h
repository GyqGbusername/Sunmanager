//
//  BaseTableViewCell.h
//  SunnyManager
//
//  Created by mfwl on 16/4/22.
//  Copyright © 2016年 bf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseModel;

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) BaseModel *model;

@end
