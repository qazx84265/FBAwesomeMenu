//
//  FBAwesomeMenu.h
//  FBAwesomeMenuDemo
//
//  Created by 123 on 16/5/27.
//  Copyright © 2016年 com.pureLake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBAwesomeMenuItem.h"

typedef NS_ENUM(NSInteger, FBAwesomeMenuStyle) {
    FBAwesomeMenuStyleCircle = 0,
    FBAwesomeMenuStyleLine
};

typedef void (^animCompleteBlock)();
typedef void (^animationCompleteBlock)(BOOL isExpand);
//typedef void (^didMenuItemSelect)(NSInteger index);

@interface FBAwesomeMenu : UIView

@property (nonatomic, assign) BOOL hideWhenTapOutsideMenu; //Default is YES

@property (nonatomic, strong) NSArray<FBAwesomeMenuItem*>* menuItems;

@property (nonatomic, assign) FBAwesomeMenuStyle style;

@property (nonatomic, copy) animationCompleteBlock completeBlk;

//@property (nonatomic, copy) didMenuItemSelect selectBlk;


- (void)showMenu;

- (void)hideMenu;

- (instancetype)initWithFrame:(CGRect)frame
                    menuItems:(NSArray<FBAwesomeMenuItem*>*)items
                        style:(FBAwesomeMenuStyle)style
                 animComplete:(animationCompleteBlock)complete;

@end
