//
//  QueueModel.h
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/23.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "BaseModel.h"

@interface QueueModel : BaseModel

@property (nonatomic, copy) NSString *inserttime;
@property (nonatomic, copy) NSString *lineupcount;
@property (nonatomic, copy) NSString *lineupid;
@property (nonatomic, copy) NSString *lineupnum;
@property (nonatomic, copy) NSString *tableid;
@property (nonatomic, copy) NSString *tablename;
@property (nonatomic, copy) NSString *tabletype;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *username;

@end
