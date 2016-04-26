//
//  QueueViewController.m
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/23.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "QueueViewController.h"
#import "QueueModel.h"


@interface QueueViewController () <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *queueListTableView;

@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation QueueViewController

- (void)dealloc {
    _queueListTableView.dataSource = nil;
    _queueListTableView.delegate = nil;
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

- (void)viewWillAppear:(BOOL)animated {
    if (!self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = YES;
    }
}

- (void)initUI {
    _queueListTableView.delegate = self;
    _queueListTableView.dataSource = self;

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
            static NSString *cellIdentf = @"QueueCell";
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
            return 90;
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
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", BASEURL, get_queue_list];

    NSDictionary *paramDic = @{
                               @"actionname":@"LineupList",
                               @"shopid":self.userInfo[@"shopid"],
                               };
    [HTTPTOOL POSTWithURL:urlStr withBody:paramDic withBodyStyle:JSONStyle withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        [self processDataWith:result[@"obj"]];
    } withFail:^(NSError *error) {
        
    }];
}

- (void)processDataWith:(NSArray *)dataArr {
    for (NSDictionary *dic in dataArr) {
        QueueModel *model = [QueueModel modelWithDictionary:dic];
        [_modelArr addObject:model];
    }
    [_queueListTableView reloadData];
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
