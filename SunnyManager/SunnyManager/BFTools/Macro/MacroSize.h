//
//  MacroSize.h
//  SunnyManager
//
//  Created by mfwl on 16/4/22.
//  Copyright © 2016年 bf. All rights reserved.
//

#ifndef MacroSize_h
#define MacroSize_h

#define layoutWidth layoutAttributes.frame.size.width
#define layoutHeight layoutAttributes.frame.size.height
#define applyFrame (CGRectMake(0, 0, layoutWidth, layoutHeight))


#define viewWidth self.frame.size.width
#define viewHeight self.frame.size.height


#define kScreen_Height      ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width       ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Frame       (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))

#endif /* MacroSize_h */
