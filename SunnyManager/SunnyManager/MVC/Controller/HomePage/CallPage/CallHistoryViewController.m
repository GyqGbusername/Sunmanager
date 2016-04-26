//
//  CallHistoryViewController.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/24.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "CallHistoryViewController.h"
#import "CallListModel.h"
#import "DishesModel.h"


@interface CallHistoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *historyListTableView;
@property (nonatomic, strong) NSMutableArray *modelArr;
@property (nonatomic, strong) NSMutableArray *dishesArr;

@property (nonatomic, strong) NSArray *cellNameArr;

@end

@implementation CallHistoryViewController

- (void)dealloc {
    _historyListTableView.delegate = nil;
    _historyListTableView.dataSource = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _modelArr = [NSMutableArray arrayWithCapacity:0];
        _cellNameArr = @[@"CallTitleCell", @"CallLastCell", @"CallDishesCell"];
        
    }
    return self;
}


- (IBAction)back:(id)sender {
    [self backAction];
}

- (void)initUI {
    _historyListTableView.delegate = self;
    _historyListTableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    switch (_modelArr.count) {
        case 0:
            return 1;
            break;
            
        default:
            return _modelArr.count;
            break;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (_modelArr.count) {
        case 0:
            return 1;
            break;
        default: {
            CallListModel *callListModel = _modelArr[section];
            for (NSDictionary *dic in callListModel.productList) {
                DishesModel *dishesModel = [DishesModel modelWithDictionary:dic];
                [_dishesArr addObject:dishesModel];
            }
            return _dishesArr.count + 2;
        }
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = nil;
    BaseModel *model =  nil;
    switch (_modelArr.count) {
        case 0: {
            static NSString *cellIdentf = @"SoyTableViewCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentf];
            if (!cell) {
                cell = [CellFactory creatCellWithClassName:cellIdentf cellModel:model indexPath:indexPath];
            }
        }
            break;
            
        default: {
            model = _modelArr[indexPath.section];
            CallListModel *callListModel = (CallListModel *) model ;
            for (NSDictionary *dic in callListModel.productList) {
                DishesModel *dishesModel = [DishesModel modelWithDictionary:dic];
                [_dishesArr addObject:dishesModel];
            }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_modelArr.count) {
        case 0:
            return 60;
            break;
        default: {
            switch (indexPath.row) {
                case 0:
                    return 45;
                    break;
                case 5:
                    return 45;
                    break;
                default:
                    return 40;
                    break;
            }
        }
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (void)handleData {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, call_record_list];
    
    NSDictionary *paramDic = @{
                               @"actionname":@"CallRecordList",
                               @"shopid":self.userInfo[@"shopid"],
                               };
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:JSONStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        NSLog(@"%@", result);
        [self processDataWith:result[@"obj"]];
    } withFail:^(NSError *error) {
        
    }];
   
}

- (void)processDataWith:(NSArray *)dataArr {
    for (NSDictionary *dic in dataArr) {
        CallListModel *model = [CallListModel modelWithDictionary:dic];
        [_modelArr addObject:model];
    }
    [_historyListTableView reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleData];
    [self initUI];
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
