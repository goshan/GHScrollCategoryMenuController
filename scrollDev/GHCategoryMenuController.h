//
//  ViewController.h
//  scrollDev
//
//  Created by goshan on 11/22/14.
//  Copyright (c) 2014 goshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHCategoryMenuController : UIViewController

@property(nonatomic, strong) UIScrollView *categoryMenuView;
@property(nonatomic, strong) UIScrollView *listView;

@property(nonatomic, strong) NSArray *listDate;

- (id)initWithFrame:(CGRect)frame andMenuHeight:(CGFloat)menuHeight;

@end

