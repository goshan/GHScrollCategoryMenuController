//
//  ViewController.h
//  scrollDev
//
//  Created by goshan on 11/22/14.
//  Copyright (c) 2014 goshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, strong) IBOutlet UIScrollView *categoryMenuView;
@property(nonatomic, strong) IBOutlet UIScrollView *listView;

- (void) initWithMenuList:(NSArray *)list;

@end

