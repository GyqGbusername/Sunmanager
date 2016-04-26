//
//  CallTitleCell.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/24.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "CallTitleCell.h"
#import "CallListModel.h"

@interface CallTitleCell ()

@property (nonatomic, strong) CallListModel *callListModel;
@property (strong, nonatomic) IBOutlet UILabel *deskType;
@property (strong, nonatomic) IBOutlet UILabel *time;

@end

@implementation CallTitleCell

- (void)setModel:(BaseModel *)model {
    _callListModel = (CallListModel *)model;
    _deskType.text = [NSString stringWithFormat: @"合计: %@", _callListModel.tablename];
    _time.text = _callListModel.inserttime;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
