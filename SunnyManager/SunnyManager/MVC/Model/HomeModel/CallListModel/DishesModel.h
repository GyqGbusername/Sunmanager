//
//  DishesModel.h
//  SunnyManager
//
//  Created by 关宇琼 on 16/4/24.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "BaseModel.h"

@interface DishesModel : BaseModel

@property (nonatomic, copy) NSString *productid;
@property (nonatomic, copy) NSString *productname;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *productsumprice;

@end
