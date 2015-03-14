//
//  UIColor+GHCategoryMenu.m
//  scrollDev
//
//  Created by goshan on 12/6/14.
//  Copyright (c) 2014 goshan. All rights reserved.
//

#import "UIColor+GHCategoryMenu.h"

@implementation UIColor (GHCategoryMenu)

+ (UIColor *)GHCategoryMenuBlockColor{
    return [UIColor colorWithRed:0.275 green:0.482 blue:0.922 alpha:1.000];
}

+ (UIColor *)GHCategoryMenuWordColor{
    return [UIColor lightGrayColor];
}

+ (UIColor *)GHCategoryMenuBackgroundColor{
    return [UIColor whiteColor];
}

+ (UIColor *)GHCategoryMenuWordSelectedColor{
    return [UIColor colorWithWhite:0.333 alpha:1.000];
}

+ (UIColor *)GHCategoryMenuBorderColor{
    return [UIColor whiteColor];
}

@end
