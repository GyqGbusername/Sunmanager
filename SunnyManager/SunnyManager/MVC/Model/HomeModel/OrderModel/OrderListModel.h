//
//  OrderListModel.h
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/25.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "BaseModel.h"

@interface OrderListModel : BaseModel


@property (nonatomic, copy) NSString *batchnum;
@property (nonatomic, copy) NSString *bsumprice;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *inserttime;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *productname;
@property (nonatomic, strong)  NSArray *productList;
@property (nonatomic, copy) NSString *productid;


@end
