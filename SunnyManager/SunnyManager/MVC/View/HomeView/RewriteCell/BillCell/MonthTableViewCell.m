//
//  MonthTableViewCell.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/25.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "MonthTableViewCell.h"
#import "DetailsDayModel.h"

@interface MonthTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *month;
@property (strong, nonatomic) IBOutlet UILabel *count;

@property (strong, nonatomic) IBOutlet UILabel *price;
@property (nonatomic, strong) DetailsDayModel *detailsModel;

@end

@implementation MonthTableViewCell

- (void)setModel:(BaseModel *)model {
    _detailsModel = (DetailsDayModel *)model;
    _month.text = [NSString stringWithFormat:@"%@月", [_detailsModel.monthDay substringWithRange:NSMakeRange(5,2)]];
    _count.text = [NSString stringWithFormat:@"本月共%@笔", _detailsModel.dayordercount];
    _price.text = [NSString stringWithFormat:@"共收入: %@", _detailsModel.dayordersumprice];

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
