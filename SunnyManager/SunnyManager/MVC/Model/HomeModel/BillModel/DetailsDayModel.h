//
//  DetailsDayModel.h
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/25.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "BaseModel.h"

@interface DetailsDayModel : BaseModel

@property (nonatomic, copy) NSString *ordertype;
@property (nonatomic, copy) NSString *orderid;
@property (nonatomic, copy) NSString *ordernum;
@property (nonatomic, copy) NSString *inserttime;
@property (nonatomic, copy) NSString *tablenumid;
@property (nonatomic, copy) NSString *tablenumname;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *sumprice;
@property (nonatomic, copy) NSString *dayordercount;
@property (nonatomic, copy) NSString *dayordersumprice;
@property (nonatomic, copy) NSString *monthDay;

@end
