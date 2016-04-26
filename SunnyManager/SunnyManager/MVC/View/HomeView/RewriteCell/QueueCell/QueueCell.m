//
//  QueueCell.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/23.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "QueueCell.h"
#import "QueueModel.h"
#import "TableModel.h"

@interface QueueCell () <STPickerSingleDelegate>

@property (strong, nonatomic) IBOutlet UILabel *deskNum;

@property (strong, nonatomic) IBOutlet UILabel *deskType;

@property (strong, nonatomic) IBOutlet UILabel *waitNum;

@property (strong, nonatomic) IBOutlet UILabel *connectPeople;

@property (strong, nonatomic) IBOutlet UILabel *queueTime;

@property (strong, nonatomic) IBOutlet UIButton *call;

@property (strong, nonatomic) IBOutlet UIButton *pass;

@property (strong, nonatomic) IBOutlet UIButton *dining;

@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) QueueModel *queueModel;

@end

@implementation QueueCell

- (IBAction)operation:(UIButton *)sender {
    switch (sender.tag) {
        case 6: {
            [self queueCall];
        }
            break;
        case 7: {
            
            [self queueList];
        }
            
            break;
        case 8: {
            [self queuePass];
        }
            break;
    }
}



#warning  呼叫推送 接口有问题

- (void)queueCall {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, k_url_get_pushinfo];
}




- (void)queueList {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, unuser_desk];
    
    NSDictionary *paramDic = @{
                               @"actionname":@"UnUseTable",
                               @"shopid":self.userInfo[@"shopid"],
                               @"tableid":@"1",
                               @"tabletype":@"1"
                               };
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:JSONStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        NSLog(@"%@",result);
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
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL , sure_queue];

    NSDictionary *paramDic = @{
                               @"actionname":@"ConfirmTablenum",
                               @"shopid":@"1",
                               @"tableid": _queueModel.tableid,
                               @"lineupid" : _queueModel.lineupid,
                               @"tablenumid" : selectedModel.tablenumid,
                               @"tablenumname":selectedModel.tablenumname
                               };
    
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:stringStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        NSLog(@"%@", result[@"message"]);
    } withFail:^(NSError *error) {
        
    }];
}


- (void)queuePass {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, queue_passnum];
    NSDictionary *paramDic = @{
                               @"actionname":@"LineUpPassNum",
                               @"lineupid":_queueModel.lineupid
                               };
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:stringStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        NSLog(@"%@", result[@"message"]);
        if ([result[@"message"] isEqualToString:@"成功"]) {
            [SVProgressHUD showSuccessWithStatus:@"已过号"];
        }
    } withFail:^(NSError *error) {
        
    }];
}

- (void)setModel:(BaseModel *)model {
    _queueModel = (QueueModel *)model;
    _connectPeople.text = [NSString stringWithFormat:@"联系人: %@", _queueModel.username];
    _queueTime.text = [NSString stringWithFormat:@"排队时间: %@", _queueModel.inserttime];
    _deskType.text = [NSString stringWithFormat:@"%@人桌", _queueModel.tabletype];
    _deskNum.text = [NSString stringWithFormat:@"%@", _queueModel.tablename];
    _waitNum.text = [NSString stringWithFormat:@"%@单等待", _queueModel.lineupcount];
}

- (void)initUI {
    _call.layer.cornerRadius = 4;
    _call.layer.masksToBounds = YES;
    _call.layer.borderWidth =1;
    _call.layer.borderColor = k_Color_Lightgrey.CGColor;
    _pass.layer.cornerRadius = 4;
    _pass.layer.masksToBounds = YES;
    _pass.layer.borderWidth =1;
    _pass.layer.borderColor = k_Color_Lightgrey.CGColor;
    _dining.layer.cornerRadius = 4;
    _dining.layer.masksToBounds = YES;
    _dining.layer.borderWidth =1;
    _dining.layer.borderColor = k_Color_Lightgrey.CGColor;
}

- (void)awakeFromNib {
    [self initUI];
}

@end
