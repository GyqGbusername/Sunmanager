//
//  CallLastCell.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/24.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "CallLastCell.h"
#import "CallListModel.h"

@interface CallLastCell ()

@property (nonatomic, strong) CallListModel *callListModel;
@property (strong, nonatomic) IBOutlet UILabel *sumPrice;
@property (strong, nonatomic) IBOutlet UIButton *reply;

@end

@implementation CallLastCell

- (void)setModel:(BaseModel *)model {
    _callListModel = (CallListModel *)model;
    _sumPrice.text = [NSString stringWithFormat: @"合计: %@", _callListModel.sumprice];
    switch ([_callListModel.answer integerValue]) {
        case 1:
            [_reply setTitle:@"未应答" forState:(UIControlStateNormal)];
            _reply.backgroundColor = k_Color_Lightgrey;
            _reply.enabled = NO;
            break;
        case 2:
            [_reply setTitle:@"已应答" forState:(UIControlStateNormal)];
            _reply.backgroundColor = k_Color_Lightgrey;
            _reply.enabled = NO;
            break;
            
        case 3:
            [_reply setTitle:@"已拒绝" forState:(UIControlStateNormal)];
            _reply.backgroundColor = k_Color_Lightgrey;
            _reply.enabled = NO;
            break;
    
    }
}

- (IBAction)relpy:(UIButton *)sender {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, call_reply];
    
    NSDictionary *paramDic = @{
                               @"actionname":@"CallAnswer",
                               @"ordertype":_callListModel.ordertype,
                               @"callid":_callListModel.callid,
                               @"orderid":_callListModel.orderid,
                               @"shopid":@"1"
                               };
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:JSONStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        
    } withFail:^(NSError *error) {
        
    }];

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
