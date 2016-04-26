//
//  AppointmentListCell.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/24.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "AppointmentListCell.h"
#import "AppointmentListModel.h"
#import "TableModel.h"
#import "STPickerSingle.h"

@interface AppointmentListCell () <STPickerSingleDelegate>

@property (strong, nonatomic) IBOutlet UILabel *orderNum;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *peopleNum;
@property (strong, nonatomic) IBOutlet UILabel *phoneNum;
@property (strong, nonatomic) IBOutlet UILabel *reachTime;
@property (strong, nonatomic) IBOutlet UILabel *deskType;
@property (strong, nonatomic) IBOutlet UILabel *note;
@property (strong, nonatomic) IBOutlet UIButton *reach;
@property (strong, nonatomic) IBOutlet UIButton *accept;
@property (strong, nonatomic) IBOutlet UIButton *refuse;


@property (nonatomic, strong) NSMutableArray *modelArr;
@property (nonatomic, strong) AppointmentListModel *appModel;

@end

@implementation AppointmentListCell

- (void)setModel:(BaseModel *)model {
    _appModel = (AppointmentListModel *)model;
    _orderNum.text = [NSString stringWithFormat:@"订单编号: %@", _appModel.bookingnum];
    _time.text = [NSString stringWithFormat:@"%@",_appModel.orderdate];
    _name.text = [NSString stringWithFormat:@"预订人: %@", _appModel.contacts];
    _peopleNum.text = [NSString stringWithFormat:@"用餐人数: %@", _appModel.personcount];
    _phoneNum.text = [NSString stringWithFormat:@"联系电话: %@", _appModel.phone];
    _reachTime.text = [NSString stringWithFormat:@"预定到达时间: %@", _appModel.rearrivetime];
    switch ([_appModel.tabletype integerValue]) {
        case 1:
            _deskType.text = [NSString stringWithFormat:@"座位类型: %@", @"卡台"];
            break;
        default:
            _deskType.text = [NSString stringWithFormat:@"座位类型: %@", @"包间"];
            break;
    }
    _note.text = [NSString stringWithFormat:@"备注: %@",_appModel.remark];
    switch ([_appModel.bookstate integerValue]) {
        case 1:
            _reach.enabled = NO;
            _reach.backgroundColor = k_Color_BACKCOLOR;
            _accept.enabled = YES;
            _accept.backgroundColor = k_Color_btColor;
            _refuse.enabled = YES;
            _refuse.backgroundColor = k_Color_Nav;
            break;
            
        default:
            _reach.enabled = YES;
            _reach.backgroundColor = k_Color_btColor;
            _accept.enabled = NO;
            _accept.backgroundColor = k_Color_BACKCOLOR;
            _refuse.enabled = NO;
            _refuse.backgroundColor = k_Color_BACKCOLOR;
            break;
    }
}


- (IBAction)operation:(UIButton *)sender {
    switch (sender.tag) {
        case 9:
            [self appointReach];
            break;
            
        case 10:
            [self getUndistributedTable];
            break;
            
        case 11:
            [self appointRefuse];
            break;
    }
}

- (void)appointReach {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, appoint_reach];
    NSDictionary *paramDic = @{
                               @"actionname":@"ConfirmToShop",
                               @"bookingid":_appModel.bookingid,
                               @"tablenumid":_appModel.tablenumid
                               };
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:stringStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        NSLog(@"%@", result[@"message"]);
        if ([result[@"message"] isEqualToString:@"确认到店成功"]) {
            [SVProgressHUD showSuccessWithStatus:@"客人已到店"];
        }
    } withFail:^(NSError *error) {
        
    }];
}

- (void)appointRefuse {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, appoint_refuse];
    NSDictionary *paramDic = @{
                               @"actionname":@"RefuseBooking",
                               @"bookingid":_appModel.bookingid
                               };
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:stringStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        NSLog(@"%@", result);
        if ([result[@"message"] isEqualToString:@"成功"]) {
            [SVProgressHUD showSuccessWithStatus:@"已拒绝"];
        }
    } withFail:^(NSError *error) {
        
    }];
}

- (void)getUndistributedTable {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, appoint_refuse];
    NSDictionary *paramDic = @{
                               @"actionname":@"GetUnuseTablenum",
                               @"shopid":self.userInfo[@"shopid"],
                               @"personcount":_appModel.personcount,
                               @"tabletype":_appModel.tabletype,
                               @"arrivetime":_appModel.arrivetime
                               };
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:stringStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        NSLog(@"%@", result);
        [self processDataWith:result[@"obj"]];
    } withFail:^(NSError *error) {
        
    }];
}
- (void)processDataWith:(NSArray *)dataArr {
    _modelArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in dataArr) {
        TableModel *model = [TableModel modelWithDictionary:dic];
        [_modelArr addObject:model];
    }
    [self STPickerShow];
}

- (void)STPickerShow  {
    
    STPickerSingle *pickerSingle = [[STPickerSingle alloc] init];
    [pickerSingle setArrayData:_modelArr];
    [pickerSingle setTitle:@"请选择桌位"];
    
    [pickerSingle setContentMode:STPickerContentModeBottom];
    [pickerSingle setDelegate:self];
    [pickerSingle show];
}
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(TableModel *)selectedModel {
    [self postDeskNumAndQueueNumWith:selectedModel];
    
}

- (void)postDeskNumAndQueueNumWith:(TableModel *)selectedModel {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL , book_appoint];
   
    NSDictionary *paramDic = @{
                               @"actionname":@"BookConfirmTab",
                               @"bookingid":_appModel.bookingid,
                               @"tablenumid": selectedModel.tablenumid,
                               @"tablenumname" : selectedModel.tablenumname,
                               @"shopid":self.userInfo[@"shopid"]
                               };
    
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:stringStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        NSLog(@"%@", result[@"message"]);
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
