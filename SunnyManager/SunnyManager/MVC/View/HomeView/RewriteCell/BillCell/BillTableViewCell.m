//
//  BillTableViewCell.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/25.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "BillTableViewCell.h"
#import "DetailsDayModel.h"

@interface BillTableViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *orderNum;
@property (strong, nonatomic) IBOutlet UILabel *sumPrice;
@property (strong, nonatomic) IBOutlet UILabel *deskNum;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *time;

@property (nonatomic, strong) DetailsDayModel *detailsModel;

@end

@implementation BillTableViewCell

- (void)setModel:(BaseModel *)model {
    _detailsModel = (DetailsDayModel *)model;
    _orderNum.text = [NSString stringWithFormat:@"订单号: %@", _detailsModel.ordernum];
    _sumPrice.text = [NSString stringWithFormat:@"账单总额: %@", _detailsModel.sumprice];
    _deskNum.text = [NSString stringWithFormat:@"桌位: %@", _detailsModel.tablenumname];
    _name.text = [NSString stringWithFormat:@"联系人: %@", _detailsModel.username];
    _time.text = [NSString stringWithFormat:@"就餐时间: %@", _detailsModel.inserttime];
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
