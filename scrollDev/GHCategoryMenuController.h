//
//  ViewController.h
//  scrollDev
//
//  Created by goshan on 11/22/14.
//  Copyright (c) 2014 goshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHCategoryMenuController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *menuScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentViewListScrollView;

- (void)setupWithMenuList:(NSArray *)list;

@end

