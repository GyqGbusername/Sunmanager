//
//  OrderDetailsViewController.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/25.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "OrderDetailsModel.h"
#import "OrderModel.h"
#import "CallListModel.h"
#import "DishesModel.h"



@interface OrderDetailsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *deskNum;
@property (strong, nonatomic) IBOutlet UILabel *namePhone;
@property (strong, nonatomic) IBOutlet UILabel *ordertime;

@property (nonatomic, strong) NSMutableArray *modelArr;
@property (nonatomic, strong) NSMutableArray *dishesArr;
@property (nonatomic, strong) NSArray *cellNameArr;
@property (strong, nonatomic) IBOutlet UITableView *orderDetailsTableView;

@property (nonatomic, strong) OrderDetailsModel *tempModel;

@property (strong, nonatomic) IBOutlet UILabel *sumPrice;

@property (strong, nonatomic) IBOutlet UIButton *prepare;


@end

@implementation OrderDetailsViewController

- (void)dealloc {
    _orderDetailsTableView.delegate = nil;
    _orderDetailsTableView.dataSource = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _modelArr = [NSMutableArray arrayWithCapacity:0];
        _cellNameArr = @[@"CallTitleCell", @"CallLastCell", @"CallDishesCell"];
    }
    return self;
}

- (IBAction)back:(id)sender {
    [self backAction];
}

- (void)setModel:(OrderModel *)model {
    if (_model != model) {
        _model = model;
    }
    [self handleData];
}

- (void)handleData {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, order_details];
    
//    NSDictionary *paramDic = @{
//                               @"actionname":@"ShopOrderDetail",
//                               @"shopid":self.userInfo[@"shopid"],
//                               @"ordertype":_model.ordertype,
//                               @"orderid":_model.orderid
//                               };
    NSDictionary *paramDic = @{
                               @"actionname":@"ShopOrderDetail",
                               @"shopid":self.userInfo[@"shopid"],
                               @"ordertype":@"1",
                               @"orderid":@"8"
                               };
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:stringStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        NSLog(@"%@", result);
        [self processDataWith:result[@"obj"]];
    } withFail:^(NSError *error) {
        
    }];
}

- (void)processDataWith:(NSArray *)dataArr {
    NSDictionary *dic =  dataArr[0];
    _tempModel = [OrderDetailsModel modelWithDictionary:dic];
    _deskNum.text = [NSString stringWithFormat:@"桌号: %@", _tempModel.tablenumname];
    _namePhone.text = [NSString stringWithFormat:@"%@  %@", _tempModel.username, _tempModel.phone];
    _ordertime.text = [NSString stringWithFormat:@"下单时间: %@", _tempModel.orderdate];
    _sumPrice.text = [NSString stringWithFormat:@"总计: ￥%@", _tempModel.sumprice];
    switch ([_tempModel.isPreparation integerValue]) {
        case 0:
            _prepare.enabled = NO;
            _prepare.backgroundColor = k_Color_Lightgrey;
            break;
        case 1:
            _prepare.enabled = YES;
            _prepare.backgroundColor = k_Color_btColor;
            break;
        
    }
    
    [_orderDetailsTableView reloadData];
}




- (void)initUI {
    
    _orderDetailsTableView.delegate = self;
    _orderDetailsTableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return _tempModel.uncalllist.count + 2;
            break;
        case 1:
            return _tempModel.unbatchnumlist.count + 2;
            break;
        case 2:
            return _tempModel.calllist.count + 2;
            break;
        default:
            return _tempModel.batchnumlist.count + 2;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = nil;
    BaseModel *model = _tempModel;
    switch (indexPath.section) {
        case 0: {
            CallListModel *callListModel = (CallListModel *) model;
            for (NSDictionary *dic in _tempModel.uncalllist) {
                DishesModel *dishesModel = [DishesModel modelWithDictionary:dic];
                [_dishesArr addObject:dishesModel];
            }
            if (indexPath.row == 0) {
                cell = [tableView dequeueReusableCellWithIdentifier:_cellNameArr[0]];
                if (!cell) {
                    cell = [CellFactory creatCellWithClassName:_cellNameArr[0] cellModel:model indexPath:indexPath];
                }
            } else if (indexPath.row == _tempModel.uncalllist.count + 1) {
                cell = [tableView dequeueReusableCellWithIdentifier:_cellNameArr[2]];
                if (!cell) {
                    cell = [CellFactory creatCellWithClassName:_cellNameArr[2] cellModel:model indexPath:indexPath];
                }
            } else {
                model = _dishesArr[indexPath.row - 1];
                cell = [tableView dequeueReusableCellWithIdentifier:_cellNameArr[1]];
                if (!cell) {
                    cell = [CellFactory creatCellWithClassName:_cellNameArr[1] cellModel:model indexPath:indexPath];
                }
            }
        }
            break;
        case 1: {
            switch (indexPath.row) {
                case 0: {
                    cell = [tableView dequeueReusableCellWithIdentifier:_cellNameArr[0]];
                    if (!cell) {
                        cell = [CellFactory creatCellWithClassName:_cellNameArr[0] cellModel:model indexPath:indexPath];
                    }
                }
                    
                    break;
                case 5: {
                    cell = [tableView dequeueReusableCellWithIdentifier:_cellNameArr[2]];
                    if (!cell) {
                        cell = [CellFactory creatCellWithClassName:_cellNameArr[2] cellModel:model indexPath:indexPath];
                    }
                }
                    break;
                    
                default: {
                    model = _dishesArr[indexPath.row - 1];
                    cell = [tableView dequeueReusableCellWithIdentifier:_cellNameArr[1]];
                    if (!cell) {
                        cell = [CellFactory creatCellWithClassName:_cellNameArr[1] cellModel:model indexPath:indexPath];
                    }
                }
                    
                    break;
            }
        }
            
            break;
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    cell = [tableView dequeueReusableCellWithIdentifier:_cellNameArr[0]];
                    if (!cell) {
                        cell = [CellFactory creatCellWithClassName:_cellNameArr[0] cellModel:model indexPath:indexPath];
                    }
                }
                    
                    break;
                case 5: {
                    cell = [tableView dequeueReusableCellWithIdentifier:_cellNameArr[2]];
                    if (!cell) {
                        cell = [CellFactory creatCellWithClassName:_cellNameArr[2] cellModel:model indexPath:indexPath];
                    }
                }
                    break;
                    
                default: {
                    model = _dishesArr[indexPath.row - 1];
                    cell = [tableView dequeueReusableCellWithIdentifier:_cellNameArr[1]];
                    if (!cell) {
                        cell = [CellFactory creatCellWithClassName:_cellNameArr[1] cellModel:model indexPath:indexPath];
                    }
                }
                    
                    break;
            }
        }
            
            break;
            
        default: {
            switch (indexPath.row) {
                case 0: {
                    cell = [tableView dequeueReusableCellWithIdentifier:_cellNameArr[0]];
                    if (!cell) {
                        cell = [CellFactory creatCellWithClassName:_cellNameArr[0] cellModel:model indexPath:indexPath];
                    }
                }
                    
                    break;
                case 5: {
                    cell = [tableView dequeueReusableCellWithIdentifier:_cellNameArr[2]];
                    if (!cell) {
                        cell = [CellFactory creatCellWithClassName:_cellNameArr[2] cellModel:model indexPath:indexPath];
                    }
                }
                    break;
                    
                default: {
                    model = _dishesArr[indexPath.row - 1];
                    cell = [tableView dequeueReusableCellWithIdentifier:_cellNameArr[1]];
                    if (!cell) {
                        cell = [CellFactory creatCellWithClassName:_cellNameArr[1] cellModel:model indexPath:indexPath];
                    }
                }
                    
                    break;
            }
        }
            
            break;
    }
   
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
}


- (IBAction)prepare:(id)sender {
    [self prepareFood];
}
- (void)prepareFood {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, order_preparefood];
    NSDictionary *paramDic = @{
                               @"actionname":@"PreparationProduct",
                               @"shopid":self.userInfo[@"shopid"],
                               @"ordertype":_model.ordertype,
                               @"orderid":_model.orderid
                               };
    
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:stringStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        NSLog(@"%@", result);
       
    } withFail:^(NSError *error) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleData];
//    [self initUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
