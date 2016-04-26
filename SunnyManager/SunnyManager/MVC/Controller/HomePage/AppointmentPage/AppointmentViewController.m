//
//  Appointment ViewController.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/24.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "AppointmentViewController.h"
#import "AppointmentListModel.h"

@interface AppointmentViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *appiontmentTableView;

@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation AppointmentViewController

- (void)dealloc {
    _appiontmentTableView.delegate = nil;
    _appiontmentTableView.dataSource = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _modelArr = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (IBAction)back:(id)sender {
    [self backAction];
}

- (void)handleData {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, booking_list];
    NSDictionary *paramDic = @{
                               @"actionname":@"BookingList",
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
        AppointmentListModel *model = [AppointmentListModel modelWithDictionary:dic];
        [_modelArr addObject:model];
    }
    [_appiontmentTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    if (!self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = YES;
    }
}

- (void)initUI {
    _appiontmentTableView.delegate = self;
    _appiontmentTableView.dataSource = self;
    _appiontmentTableView.tableFooterView = [[UIView alloc] init];
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
            static NSString *cellIdentf = @"AppointmentListCell";
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
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_modelArr.count) {
        case 0:
            return 60;
            break;
            
        default:
            return 280;
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
