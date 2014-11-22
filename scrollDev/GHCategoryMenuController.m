//
//  ViewController.m
//  scrollDev
//
//  Created by goshan on 11/22/14.
//  Copyright (c) 2014 goshan. All rights reserved.
//

#import "GHCategoryMenuController.h"

@interface GHCategoryMenuController ()

@property(nonatomic, assign) CGFloat offsetX;

@end

@implementation GHCategoryMenuController

- (id)initWithFrame:(CGRect)frame andMenuHeight:(CGFloat)menuHeight{
    self = [super init];
    if (self){
        self.categoryMenuView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 44, frame.size.width, menuHeight)];
        self.listView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, menuHeight+44, frame.size.width, frame.size.height - menuHeight)];
        self.offsetX = 0.0;
    }
    return self;
}

//comment by goshan @2014/11/22: overwrite setter of listDate

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    for (UIViewController *viewController in self.listDate){
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        [item setTitle:viewController.title forState:UIControlStateNormal];
        NSDictionary *dict = @{NSFontAttributeName: item.titleLabel.font};
        CGSize size = [viewController.title sizeWithAttributes:dict];
        [item setFrame:CGRectMake(self.offsetX, 0.0, size.width, self.categoryMenuView.bounds.size.height)];
        [self.categoryMenuView addSubview:item];
        self.offsetX += size.width;
    }
    self.categoryMenuView.backgroundColor = [UIColor redColor];
    [self.categoryMenuView setContentSize:CGSizeMake(self.offsetX, self.categoryMenuView.bounds.size.height)];
    self.categoryMenuView.scrollEnabled = YES;
    [self.view addSubview:self.categoryMenuView];
    //[self.view addSubview:self.listView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
