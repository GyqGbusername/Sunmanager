//
//  AppointmentListModel.h
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/24.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "BaseModel.h"

@interface AppointmentListModel : BaseModel


@property (nonatomic, copy) NSString *arrivetime;
@property (nonatomic, copy) NSString *bookingid;
@property (nonatomic, copy) NSString *bookingnum;
@property (nonatomic, copy) NSString *bookstate;
@property (nonatomic, copy) NSString *contacts;
@property (nonatomic, copy) NSString *personcount;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *rearrivetime;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *tablenumid;
@property (nonatomic, copy) NSString *tablenumname;
@property (nonatomic, copy) NSString *tabletype;
@property (nonatomic, copy) NSString *orderdate;

@end
