//
//  UIFont+GQHFont.m
//  Seed
//
//  Created by GuanQinghao on 21/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "UIFont+GQHFont.h"


@implementation UIFont (GQHFont)

// 最小字体 小字
+ (UIFont *)qh_smallestFont {
    
    return [UIFont systemFontOfSize:12.0f];
}

// 副文、列表副文
+ (UIFont *)qh_smallerFont {
    
    return [UIFont systemFontOfSize:15.0f];
}

// 正文、列表正文
+ (UIFont *)qh_defaultFont {
    
    return [UIFont systemFontOfSize:17.0f];
}

// 标题、按钮
+ (UIFont *)qh_biggerFont {
    
    return [UIFont systemFontOfSize:18.0f];
}

// 最大字体 导航、突出内容
+ (UIFont *)qh_biggestFont {
    
    return [UIFont systemFontOfSize:20.0f];
}

@end
