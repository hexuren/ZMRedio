//
//  PlateConfig.h
//  lantu
//
//  Created by Eric Wang on 16/2/20.
//  Copyright © 2016年 Eric. All rights reserved.
//

#ifndef PlateConfig_h
#define PlateConfig_h


#if IsParent_APP

#else

#define kRGBColor(R,G,B)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define gCommonBackgroundColor UIColorFromHex(0xffffff)
#define gMainColor [UIColor colorWithRed:0.99 green:0.63 blue:0.16 alpha:1.00]
#define gThickLineColor UIColorFromHex(0xf2f2f2)
#define gThinLineColor UIColorFromHex(0xeeeeee)

#define gTextColorMain UIColorFromHex(0x4d4d4d)
#define gTextColorSpecial UIColorFromHex(0xca0051)
#define gTextColorSub UIColorFromHex(0x8d8d8d)
#define gTextColorDetail UIColorFromHex(0xc8c8c8)
#define gTextDownload UIColorFromHex(0x222222)



//点名特别颜色
#define gTextColorSign UIColorFromHex(0xd9edf6)
//按钮背景特别颜色
#define gButtonBackGroundColorSign UIColorFromHex(0xffa200)


#define gFontSelected18 [UIFont systemFontOfSize:18.0]
#define gFontMain15 [UIFont systemFontOfSize:15.0]
#define gFontSub12 [UIFont systemFontOfSize:13.0]
#define gFontDetail10 [UIFont systemFontOfSize:10.5]

#endif


#endif /* PlateConfig_h */
