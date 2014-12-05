//
//  ViewController.m
//  scrollDev
//
//  Created by goshan on 11/22/14.
//  Copyright (c) 2014 goshan. All rights reserved.
//

#import "GHCategoryMenuController.h"
#import "UIColor+GHCategoryMenu.h"

@interface GHCategoryMenuController ()

@property(nonatomic, strong) NSArray *menuList;

@end

@implementation GHCategoryMenuController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCategoryMenu];
}


#pragma setup and init

- (void)setupWithMenuList:(NSArray *)list{
    self.menuList = list;
}

- (void)initCategoryMenu{
    CGFloat posX = 20.0;
    for (NSString *menuName in self.menuList){
        UILabel *menuItem = [[UILabel alloc] init];
        menuItem.text = menuName;
        menuItem.textColor = [UIColor GHCategoryMenuWordColor];
        menuItem.font = [UIFont boldSystemFontOfSize:11.0];
        [menuItem sizeToFit];
        menuItem.frame = CGRectMake(posX, 0, menuItem.frame.size.width, menuItem.frame.size.height);
        [self.menuScrollView addSubview:menuItem];
        posX += menuItem.frame.size.width + 20.0f;
    }
    
    [self.menuScrollView setContentSize:CGSizeMake(posX, self.menuScrollView.frame.size.height)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
