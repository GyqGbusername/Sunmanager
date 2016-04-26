//
//  OrderModel.h
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/24.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "BaseModel.h"

@interface OrderModel : BaseModel



@property (nonatomic, copy) NSString *ordertype;
@property (nonatomic, copy) NSString *orderid;
@property (nonatomic, copy) NSString *ordernum;
@property (nonatomic, copy) NSString *lineupnum;
@property (nonatomic, copy) NSString *lineupstate;
@property (nonatomic, copy) NSString *booknum;
@property (nonatomic, copy) NSString *bookstate;
@property (nonatomic, copy) NSString *inserttime;
@property (nonatomic, copy) NSString *meal;
@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *pay;
@property (nonatomic, copy) NSString *tablenumid;
@property (nonatomic, copy) NSString *tablenumname;
@property (nonatomic, copy)  NSString *userid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *sumprice;

@end
