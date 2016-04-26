//
//  DayModel.h
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/25.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "BaseModel.h"

@interface DayModel : BaseModel

@property (nonatomic, copy) NSString *daytotalcount;
@property (nonatomic, copy) NSString *daytotalmoney;
@property (nonatomic, strong) NSDictionary *dayBillList;

@property (nonatomic, copy) NSString *monthordercount;
@property (nonatomic, copy) NSString *monthordersumprice;
@property (nonatomic, strong) NSDictionary *monthBillList;

@end
