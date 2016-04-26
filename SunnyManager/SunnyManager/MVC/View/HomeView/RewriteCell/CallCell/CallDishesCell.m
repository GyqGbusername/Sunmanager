//
//  CallDishesCell.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/24.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "CallDishesCell.h"
#import "DishesModel.h"

@interface CallDishesCell ()

@property (nonatomic, strong) DishesModel *dishesModel;

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *count;

@end

@implementation CallDishesCell


- (void)setModel:(BaseModel *)model {
    _dishesModel = (DishesModel *)model;
    _name.text = [NSString stringWithFormat:@"%@ ￥%@", _dishesModel.productname,_dishesModel.productsumprice];
    _count.text = [NSString stringWithFormat:@"X %@", _dishesModel.count];
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
