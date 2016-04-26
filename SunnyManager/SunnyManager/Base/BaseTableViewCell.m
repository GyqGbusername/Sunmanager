//
//  BaseTableViewCell.m
//  SunnyManager
//
//  Created by mfwl on 16/4/22.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell




- (id)readNSUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults dictionaryForKey:@"userInfoRecord"]; /* 读取 */
}

- (void)awakeFromNib {
    
    [self userInfo];

    // Initialization code
}
- (NSDictionary *)userInfo {
    if (!_userInfo) {
        _userInfo = [self readNSUserDefaults];
    }
    return _userInfo;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
