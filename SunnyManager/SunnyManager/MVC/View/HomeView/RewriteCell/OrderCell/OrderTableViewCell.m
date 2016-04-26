//
//  OrderTableViewCell.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/25.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "OrderModel.h"

@interface OrderTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *orderNum;
@property (strong, nonatomic) IBOutlet UILabel *payState;
@property (strong, nonatomic) IBOutlet UILabel *nowState;
@property (strong, nonatomic) IBOutlet UILabel *deskNum;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *allPrice;

@property (nonatomic, strong) OrderModel *orderModel;

@end

@implementation OrderTableViewCell

- (void)setModel:(BaseModel *)model {
    _orderModel = (OrderModel *)model;
    _orderNum.text = [NSString stringWithFormat:@"订单号: %@", _orderModel.ordernum];
    switch ([_orderModel.meal integerValue]) {
        case 1:
            _nowState.text = @"待点餐";
            break;
            
        case 2:
            _nowState.text = @"已点餐";
            break;
    }
    switch ([_orderModel.pay integerValue]) {
        case 1:
            _payState.text = @"待结账";
            _payState.textColor = k_Color_Nav;
            break;
            
        case 2:
            _payState.text = @"已结账";
            break;
        case 3:
            _payState.text = @"部分未结";
            _payState.textColor = k_Color_Nav;
            break;
            
        case 4:
            _payState.text = @"线下已结账";
            break;
        case 5:
            _payState.text = @"完成结账";
            break;
    }
    _deskNum.text = [NSString stringWithFormat:@"桌位: %@", _orderModel.tablenumname];
    _name.text = [NSString stringWithFormat:@"用餐人: %@", _orderModel.username];
    _time.text = [NSString stringWithFormat:@"用餐时间: %@", _orderModel.inserttime];
    _allPrice.text = [NSString stringWithFormat:@"合计: %@", _orderModel.sumprice];
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
