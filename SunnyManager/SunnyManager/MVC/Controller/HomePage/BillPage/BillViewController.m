//
//  BillViewController.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/25.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "BillViewController.h"
#import "DayModel.h"
#import "DetailsDayModel.h"

@interface BillViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *btBV;
@property (strong, nonatomic) IBOutlet UILabel *lineLb;

@property (nonatomic, strong) NSMutableArray *modelArr;
@property (strong, nonatomic) IBOutlet UITableView *dayTableView;
@property (strong, nonatomic) IBOutlet UILabel *all;

@property (nonatomic , strong) DayModel *dayModel;
@property (nonatomic, strong) NSDictionary *tempDic;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation BillViewController

- (void)dealloc {
    _dayTableView.delegate = nil;
    _dayTableView.dataSource = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}
- (IBAction)back:(id)sender {
    [self backAction];
}

- (void)viewWillAppear:(BOOL)animated {
    if (!self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden = YES;
    }
    if (!self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = YES;
    }
}


- (IBAction)choose:(UIButton *)sender {
    for (NSInteger i = 0; i < 3; i ++) {
        UIButton *bt = _btBV.subviews[i];
        [bt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    [sender setTitleColor:k_Color_Nav forState:(UIControlStateNormal)];
    [UIView animateWithDuration:0.3 animations:^{
        [_lineLb setFrame:CGRectMake(sender.frame.origin.x, 38, sender.frame.size.width, 2)];
    } completion:^(BOOL finished) {
        
    }];
    [self handleDataWith:[NSString stringWithFormat:@"%ld", sender.tag - 14]];
    
}

- (void)handleDataWith:(NSString *)sender {
     _modelArr = [NSMutableArray arrayWithCapacity:0];
    switch ([sender integerValue]) {
        case 1: {
            _selectedIndex = 1;
            NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, day_bill];
            
            NSDictionary *paramDic = @{
                                       @"actionname":@"DayBillList",
                                       @"shopid":self.userInfo[@"shopid"],
                                       @"searchdate":@"2016-04-12"
                                       };
            [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:stringStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
                NSLog(@"%@", result);
                _tempDic = result[@"obj"][0];
                _dayModel = [DayModel modelWithDictionary:_tempDic[@"dayBillObj"]];
                _all.text = [NSString stringWithFormat:@"今日总计%@笔  共收入: ￥%@", _dayModel.daytotalcount, _dayModel.daytotalmoney];
                for (NSDictionary *dic in _dayModel.dayBillList) {
                    DetailsDayModel *detailsModel = [DetailsDayModel modelWithDictionary:dic];
                    NSLog(@"%@", detailsModel.inserttime);
                    [_modelArr addObject:detailsModel];
                }
                [_dayTableView reloadData];
            } withFail:^(NSError *error) {
                
            }];
        }
            break;
            
        case 2: {
            _selectedIndex = 2;
        }
            
            break;
        case 3: {
            _selectedIndex = 3;
            NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, month_bill];
            NSDictionary *paramDic = @{
                                       @"actionname":@"MonthBillList",
                                       @"shopid":self.userInfo[@"shopid"],
                                       @"searchmonth":@"2016-04"
                                       };
            [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:stringStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
                NSLog(@"%@", result);
                _tempDic = result[@"obj"][0];
                _dayModel = [DayModel modelWithDictionary:_tempDic[@"monthBillObj"]];
                _all.text = [NSString stringWithFormat:@"本月总计%@笔  共收入: ￥%@", _dayModel.monthordercount, _dayModel.monthordersumprice];
                for (NSDictionary *dic in _dayModel.monthBillList) {
                    DetailsDayModel *detailsModel = [DetailsDayModel modelWithDictionary:dic];
         
                    [_modelArr addObject:detailsModel];
                }
                
                [_dayTableView reloadData];
            } withFail:^(NSError *error) {
                
            }];
        }
            break;
    }
   
}




- (void)initUI {
    _dayTableView.delegate = self;
    _dayTableView.dataSource = self;
    
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
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = nil;
    BaseModel *model =  nil;
    switch (_selectedIndex) {
        case 1: {
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
                    model = _modelArr[indexPath.section]; // model
                    static NSString *cellIdentf = @"BillTableViewCell";
                    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentf];
                    if (!cell) {
                        cell = [CellFactory creatCellWithClassName:cellIdentf cellModel:model indexPath:indexPath];
                    } else  /* 当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免 */
                    {
                        while ([cell.contentView.subviews lastObject] != nil) {
                            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
                        }
                    }
                    
                }
                    break;
            }

        }
            
            break;
        case 2: {
            
        }
            
            break;
        default: {
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
                    model = _modelArr[indexPath.section]; // model
                    static NSString *cellIdentf = @"MonthTableViewCell";
                    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentf];
                    if (!cell) {
                        cell = [CellFactory creatCellWithClassName:cellIdentf cellModel:model indexPath:indexPath];
                    } else  /* 当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免 */
                    {
                        while ([cell.contentView.subviews lastObject] != nil) {
                            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
                        }
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
    switch (_selectedIndex) {
        case 1: {
            switch (_modelArr.count) {
                case 0:
                    return 60;
                    break;
                    
                default:
                    return 130;
                    break;
            }
        }
            
            break;
        case 2:  {
            switch (_modelArr.count) {
                case 0:
                    return 60;
                    break;
                    
                default:
                    return 50;
                    break;
            }
        }

            
            break;
        default: {
            switch (_modelArr.count) {
                case 0:
                    return 60;
                    break;
                    
                default:
                    return 50;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDataWith:@"1"];
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
