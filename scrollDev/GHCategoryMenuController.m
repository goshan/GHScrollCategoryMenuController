//
//  ViewController.m
//  scrollDev
//
//  Created by goshan on 11/22/14.
//  Copyright (c) 2014 goshan. All rights reserved.
//

#import "GHCategoryMenuController.h"
#import "UIColor+GHCategoryMenu.h"


const CGFloat menuItemPaddingHorizontal = 10.0;
const CGFloat menuItemPaddingVertical = 5.0;
const CGFloat menuItemFontSize = 17.0;

@interface GHCategoryMenuController ()

@property(nonatomic, strong) UILabel *colorBlockLabel;

@property(nonatomic, strong) NSArray *menuList;
@property(nonatomic, strong) NSMutableArray *menuItemList;

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
    self.menuItemList = [[NSMutableArray alloc] init];
    CGFloat posX = 0;
    for (NSString *menuName in self.menuList){
        UILabel *menuItem = [[UILabel alloc] init];
        menuItem.text = menuName;
        menuItem.textColor = [UIColor GHCategoryMenuWordColor];
        menuItem.font = [UIFont boldSystemFontOfSize:menuItemFontSize];
        menuItem.textAlignment = NSTextAlignmentCenter;
        [menuItem sizeToFit];
        CGRect frame = menuItem.frame;
        frame.size.height += 2 * menuItemPaddingVertical;
        frame.size.width += 2 * menuItemPaddingHorizontal;
        [menuItem setFrame:frame];
        //added by goshan(@2014/12/06): make menu item vertical center
        CGFloat posY = (self.menuScrollView.frame.size.height - menuItem.frame.size.height) / 2;
        menuItem.frame = CGRectMake(posX, posY, menuItem.frame.size.width, menuItem.frame.size.height);
        [self.menuScrollView addSubview:menuItem];
        [self.menuItemList addObject:menuItem];
        posX += menuItem.frame.size.width;
    }
    //set color block
    UILabel *menuItem = self.menuItemList.firstObject;
    self.colorBlockLabel = [[UILabel alloc] initWithFrame:menuItem.frame];
    self.colorBlockLabel.backgroundColor = [UIColor GHCategoryMenuBlockColor];
    self.colorBlockLabel.clipsToBounds = YES;
    self.colorBlockLabel.layer.cornerRadius = self.colorBlockLabel.frame.size.height / 2;
    [self.menuScrollView insertSubview:self.colorBlockLabel atIndex:0];
    
    self.menuScrollView.showsHorizontalScrollIndicator = NO;
    self.menuScrollView.showsVerticalScrollIndicator = YES;
    [self.menuScrollView setContentSize:CGSizeMake(posX, self.menuScrollView.frame.size.height)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
