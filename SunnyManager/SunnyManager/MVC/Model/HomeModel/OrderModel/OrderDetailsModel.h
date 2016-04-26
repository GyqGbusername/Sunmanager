//
//  OrderDetailsModel.h
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/25.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "BaseModel.h"

@interface OrderDetailsModel : BaseModel


@property (nonatomic, copy) NSString *tablenumid;
@property (nonatomic, copy) NSString *tablenumname;
@property (nonatomic, copy)  NSString *userid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *orderdate;
@property (nonatomic, copy) NSString *sumprice;
@property (nonatomic, copy) NSString *pay;

@property (nonatomic, copy) NSString *isPreparation;

@property (nonatomic, strong) NSArray *unbatchnumlist;
@property (nonatomic, strong) NSArray *uncalllist;
@property (nonatomic, strong) NSArray *batchnumlist;
@property (nonatomic, strong) NSArray *calllist;





@end
