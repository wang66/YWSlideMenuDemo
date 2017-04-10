//
//  PublicDefine.h
//  SegmentScrollVCDemo
//
//  Created by 王亚文 on 2017/4/9.
//  Copyright © 2017年 wyw. All rights reserved.
//

#ifndef PublicDefine_h
#define PublicDefine_h

#define FONT(x) [UIFont systemFontOfSize:x]

#define BFONT(x) [UIFont boldSystemFontOfSize:x]

#define IMAGE(x) [UIImage imageNamed:x]

#define Width_MainScreen [[UIScreen mainScreen] bounds].size.width

#define Height_MainScreen [[UIScreen mainScreen] bounds].size.height

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:1.]

#define Color_Random              [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]

#define Color_White      [UIColor whiteColor]




#endif /* PublicDefine_h */
