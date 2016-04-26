//
//  CallListModel.h
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/24.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "BaseModel.h"

@interface CallListModel : BaseModel


@property (nonatomic, copy) NSString *ordertype;
@property (nonatomic, copy) NSString *orderid;
@property (nonatomic, copy) NSString *callid;
@property (nonatomic, copy) NSString *inserttime;
@property (nonatomic, copy) NSString *tableid;
@property (nonatomic, copy) NSString *tablename;
@property (nonatomic, copy) NSString *tablenumid;
@property (nonatomic, copy) NSString *tablenumname;
@property (nonatomic, copy) NSString *sumprice;
@property (nonatomic, strong)  NSArray *productList;
@property (nonatomic, copy) NSString *answer;


@end
