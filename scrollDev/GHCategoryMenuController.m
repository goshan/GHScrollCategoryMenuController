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

@property(nonatomic, assign) NSInteger currentPage;
@property(nonatomic, assign) CGFloat previouseContenScrollViewOffsetDis;

@property(nonatomic, strong) UILabel *colorBlockLabel;

@property(nonatomic, strong) NSArray *menuList;
@property(nonatomic, strong) NSMutableArray *menuItemList;
@property(nonatomic, strong) NSMutableArray *contentViewList;

@property(nonatomic, assign) BOOL isDraging;

@end

@implementation GHCategoryMenuController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCategoryMenu];
    [self setupContentListView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma setup and init

- (void)setupWithMenuList:(NSArray *)list{
    self.menuList = list;
}

- (void)setupCategoryMenu{
    self.menuItemList = [[NSMutableArray alloc] init];
    CGFloat posX = 0;
    for (int i=0; i<self.menuList.count; i++){
        NSString *menuName = self.menuList[i];
        UILabel *menuItem = [[UILabel alloc] init];
        menuItem.text = menuName;
        menuItem.textColor = [UIColor GHCategoryMenuWordColor];
        menuItem.font = [UIFont boldSystemFontOfSize:menuItemFontSize];
        menuItem.textAlignment = NSTextAlignmentCenter;
        menuItem.tag = i;
        [menuItem sizeToFit];
        menuItem.frame = CGRectMake(posX, 0, menuItem.frame.size.width + 2 * menuItemPaddingHorizontal, self.menuScrollView.frame.size.height);
        menuItem.clipsToBounds = YES;
        menuItem.layer.borderWidth = 1.0;
        
        
        
        [self.menuScrollView addSubview:menuItem];
        [self.menuItemList addObject:menuItem];
        posX += menuItem.frame.size.width;
        
        //add tap gesture in menu item
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryMenuDidPressed:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [menuItem addGestureRecognizer:tapGesture];
        menuItem.userInteractionEnabled = YES;
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
    self.menuScrollView.bounces = NO;
}

- (void)setupContentListView{
    self.contentViewList = [[NSMutableArray alloc] init];
    CGFloat posX = 0.0;
    for (NSString *menuName in self.menuList){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(posX, 0, self.contentViewListScrollView.frame.size.width, self.contentViewListScrollView.frame.size.height)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        label.text = menuName;
        [view addSubview:label];
        view.layer.borderColor = [UIColor blackColor].CGColor;
        view.layer.borderWidth = 1.0;
        [self.contentViewListScrollView addSubview:view];
        posX += self.contentViewListScrollView.frame.size.width;
    }
    [self.contentViewListScrollView setContentSize:CGSizeMake(self.contentViewListScrollView.frame.size.width * self.menuList.count, self.contentViewListScrollView.frame.size.height)];
    self.contentViewListScrollView.pagingEnabled = YES;
    self.contentViewListScrollView.showsHorizontalScrollIndicator = NO;
    self.contentViewListScrollView.showsVerticalScrollIndicator = NO;
    self.contentViewListScrollView.bounces = NO;
}

#pragma private method

- (void)jumpToPage:(NSInteger)currentPage{
    self.currentPage = currentPage;
    
    //1. set offset of menuScrollView
    UIView *currentMenuItem = self.menuItemList[self.currentPage];
    CGFloat menuOffsetX = currentMenuItem.center.x - self.menuScrollView.frame.size.width / 2;
    //** the left and right bound item reset
    menuOffsetX = MAX(0, menuOffsetX);
    menuOffsetX = MIN(menuOffsetX, self.menuScrollView.contentSize.width - self.menuScrollView.frame.size.width);
    [self.menuScrollView scrollRectToVisible:CGRectMake(menuOffsetX, 0, self.menuScrollView.frame.size.width, self.menuScrollView.frame.size.height) animated:YES];
    //2. set offset of contentScrollView
    CGFloat contentOffsetX = self.contentViewListScrollView.frame.size.width * self.currentPage;
    [self.contentViewListScrollView scrollRectToVisible:CGRectMake(contentOffsetX, 0, self.contentViewListScrollView.frame.size.width, self.contentViewListScrollView.frame.size.height) animated:YES];
    //3. update font color of categoryMenu
    for (UILabel *item in self.menuItemList){
        item.textColor = [UIColor GHCategoryMenuWordColor];
    }
    UILabel *newItem = self.menuItemList[self.currentPage];
    newItem.textColor = [UIColor GHCategoryMenuWordSelectedColor];
    //4. update color block frame
    [UIView animateWithDuration:0.3 animations:^{
        self.colorBlockLabel.frame = newItem.frame;
    }];
    //5. reset self.previouseContenScrollViewOffsetDis
    self.previouseContenScrollViewOffsetDis = 0.0;
}

#pragma gesture

- (void)categoryMenuDidPressed:(id)sender{
    UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)sender;
    UILabel *item = (UILabel *)tapGesture.view;
    NSInteger pageToJump = item.tag;
    [self jumpToPage:pageToJump];
}

#pragma scroll delegate

- (NSArray *)findFromAndToItemWithCurrentOffsetDis:(CGFloat)currentOffsetDis{
    UILabel *fromItem = nil;
    UILabel *toItem = nil;
    if (currentOffsetDis > 0){
        //be the right of the center
        if (currentOffsetDis > self.previouseContenScrollViewOffsetDis){
            //scrolling to right
            fromItem = self.menuItemList[self.currentPage];
            if (self.currentPage != self.menuList.count - 1){
                toItem = self.menuItemList[self.currentPage+1];
            }
        }
        else if (currentOffsetDis < self.previouseContenScrollViewOffsetDis){
            //back to the center
            if (self.currentPage != self.menuList.count - 1){
                fromItem = self.menuItemList[self.currentPage+1];
            }
            toItem = self.menuItemList[self.currentPage];
        }
    }
    else if (currentOffsetDis < 0) {
        //be the left of the center
        if (currentOffsetDis > self.previouseContenScrollViewOffsetDis){
            //back to the center
            if (self.currentPage != 0){
                fromItem = self.menuItemList[self.currentPage-1];
            }
            toItem = self.menuItemList[self.currentPage];
        }
        else if (currentOffsetDis < self.previouseContenScrollViewOffsetDis){
            //scrolling to the left
            fromItem = self.menuItemList[self.currentPage];
            if (self.currentPage != 0){
                toItem = self.menuItemList[self.currentPage-1];
            }
        }
    }
    else {
        //must be back to the center
        if (currentOffsetDis > self.previouseContenScrollViewOffsetDis){
            //back to the center from left
            if (self.currentPage != 0){
                fromItem = self.menuItemList[self.currentPage-1];
            }
            toItem = self.menuItemList[self.currentPage];
        }
        else if (currentOffsetDis < self.previouseContenScrollViewOffsetDis){
            //back to the center from right
            if (self.currentPage != self.menuList.count - 1){
                fromItem = self.menuItemList[self.currentPage+1];
            }
            toItem = self.menuItemList[self.currentPage];
        }
    }
    return @[fromItem, toItem];
}

- (void) scrollMenuViewWithContentScrollDis:(CGFloat)contentViewScrollDis fromItem:(UILabel *)fromItem toItem:(UILabel *)toItem{
    CGFloat menuOffsetOrigin = fromItem.center.x - self.menuScrollView.frame.size.width / 2;
    menuOffsetOrigin = MAX(0, menuOffsetOrigin);
    menuOffsetOrigin = MIN(menuOffsetOrigin, self.menuScrollView.contentSize.width - self.menuScrollView.frame.size.width);
    CGFloat menuOffsetTarget = toItem.center.x - self.menuScrollView.frame.size.width / 2;
    menuOffsetTarget = MAX(0, menuOffsetTarget);
    menuOffsetTarget = MIN(menuOffsetTarget, self.menuScrollView.contentSize.width - self.menuScrollView.frame.size.width);
    
    CGFloat menuScrollDis = abs(menuOffsetOrigin - menuOffsetTarget);
    CGFloat menuDisRealtime = menuScrollDis * contentViewScrollDis / self.contentViewListScrollView.frame.size.width;
    self.menuScrollView.contentOffset = CGPointMake(self.menuScrollView.contentOffset.x + menuDisRealtime, 0);
}

- (void) updateColorBlockWithContentScrollDis:(CGFloat)contentViewScrollDis fromItem:(UILabel *)fromItem toItem:(UILabel *)toItem{
    CGFloat blockLengthToChange = toItem.frame.size.width - fromItem.frame.size.width;
    CGFloat blockOriginXToChange = toItem.frame.origin.x - fromItem.frame.origin.x;
    CGFloat blockLengthRealtime = blockLengthToChange * abs(contentViewScrollDis) / self.contentViewListScrollView.frame.size.width;
    CGFloat blockOriginXRealtime = blockOriginXToChange * abs(contentViewScrollDis) / self.contentViewListScrollView.frame.size.width;
    CGRect frame = self.colorBlockLabel.frame;
    frame.size.width += blockLengthRealtime;
    frame.origin.x += blockOriginXRealtime;
    self.colorBlockLabel.frame = frame;
}

- (void) updateCurrentPageWithCurrentOffsetDis:(CGFloat)currentOffsetDis{
    NSInteger newPage = self.currentPage;
    if (currentOffsetDis > 0){
        //scroll to right
        newPage = floor(self.contentViewListScrollView.contentOffset.x / self.contentViewListScrollView.frame.size.width);
    }
    else if (currentOffsetDis < 0){
        //scroll to left
        newPage = ceil(self.contentViewListScrollView.contentOffset.x / self.contentViewListScrollView.frame.size.width);
    }
    if (self.currentPage != newPage){
        self.previouseContenScrollViewOffsetDis = 0;
    }
    else {
        self.previouseContenScrollViewOffsetDis = currentOffsetDis;
    }
    self.currentPage = newPage;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.contentViewListScrollView){
        self.isDraging = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.contentViewListScrollView){
        if (self.isDraging){
            //the offset before scroll
            CGFloat previousBasicOffsetX = self.contentViewListScrollView.frame.size.width * self.currentPage;
            //scroll distance this time
            CGFloat listScrollViewOffsetDis = self.contentViewListScrollView.contentOffset.x - previousBasicOffsetX;
            
            //find the from and to item
            NSArray *itemsRelations = [self findFromAndToItemWithCurrentOffsetDis:listScrollViewOffsetDis];
            UILabel *fromItem = itemsRelations.firstObject;
            UILabel *toItem = itemsRelations.lastObject;
            
            CGFloat contentViewScrollDis = listScrollViewOffsetDis - self.previouseContenScrollViewOffsetDis;
            //caculate the distance of menuScrollView
            [self scrollMenuViewWithContentScrollDis:contentViewScrollDis fromItem:fromItem toItem:toItem];
            //caculate the position of the colorBlockLabel
            
            //caculate the length colorBlockLabel
            [self updateColorBlockWithContentScrollDis:contentViewScrollDis fromItem:fromItem toItem:toItem];
            
            //update self.currentPage and self.previousContentScrollViewOffsetDis for continuous scroll
            [self updateCurrentPageWithCurrentOffsetDis:listScrollViewOffsetDis];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //update self.currentPage after scrolling
    self.isDraging = NO;
    NSInteger newPage = self.contentViewListScrollView.contentOffset.x / self.contentViewListScrollView.frame.size.width;
    [self jumpToPage:newPage];
}

@end
