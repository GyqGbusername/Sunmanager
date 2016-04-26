//
//  MacroFunction.h
//  SunnyManager
//
//  Created by mfwl on 16/4/22.
//  Copyright © 2016年 bf. All rights reserved.
//

#ifndef MacroFunction_h
#define MacroFunction_h

/* 避免循环持有 */
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define mFNotiCenter [NSNotificationCenter defaultCenter]

#endif /* MacroFunction_h */
