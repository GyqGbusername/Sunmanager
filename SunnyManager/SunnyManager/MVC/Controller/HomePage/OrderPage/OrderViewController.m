//
//  OrderViewController.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/24.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderModel.h"
#import "OrderDetailsViewController.h"

@interface OrderViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *orderListTableView;

@property (strong, nonatomic) IBOutlet UIView *navi;
@property (strong, nonatomic) IBOutlet UILabel *naviTitile;
@property (strong, nonatomic) IBOutlet UIButton *naviBack;

@property (nonatomic, strong) NSMutableArray *modelArr;
@property (strong, nonatomic) IBOutlet UIView *btBV;
@property (strong, nonatomic) IBOutlet UILabel *lineLb;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;


@end

@implementation OrderViewController

- (void)dealloc {
    _searchBar.delegate = nil;
    _orderListTableView.dataSource = nil;
    _orderListTableView.delegate = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (IBAction)back:(id)sender {
    [self backAction];
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
    [self handleDataWith:[NSString stringWithFormat:@"%ld", sender.tag - 11]];
}




- (void)viewWillAppear:(BOOL)animated {
    if (!self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden = YES;
    }
    if (!self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = YES;
    }
}



- (void)handleDataWith:(NSString *)sender {
    _modelArr = [NSMutableArray arrayWithCapacity:0];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, get_order_list];
  
    NSDictionary *paramDic = @{
                               @"actionname":@"ShopOrderList",
                               @"shopid":self.userInfo[@"shopid"],
                               @"ordertype":[NSString stringWithFormat:@"%@", sender]
                               };
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:stringStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        NSLog(@"%@", result);
        [self processDataWith:result[@"obj"]];
    } withFail:^(NSError *error) {
        
    }];
}

- (void)processDataWith:(NSArray *)dataArr {
    for (NSDictionary *dic in dataArr) {
        OrderModel *model = [OrderModel modelWithDictionary:dic];
        [_modelArr addObject:model];
    }
    [_orderListTableView reloadData];
}

- (void)initUI {
    _searchBar.delegate = self;
    _orderListTableView.delegate = self;
    _orderListTableView.dataSource = self;
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
            static NSString *cellIdentf = @"OrderTableViewCell";
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
            return 164;
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (_modelArr.count) {
        case 0:
            return CGFLOAT_MIN;
            break;
            
        default:
            return 10;
            break;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_modelArr.count) {
        case 0:
            
            break;
            
        default:{
            OrderDetailsViewController *details = [[OrderDetailsViewController alloc] init];
            OrderModel *tempModel = _modelArr[indexPath.section];
            details.model = tempModel;
            [self.navigationController pushViewController:details animated:YES];
        }
            break;
    }
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
