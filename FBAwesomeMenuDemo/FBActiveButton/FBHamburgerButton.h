//
//  FBHamburgerButton.h
//  PrettyCamera
//
//  Created by 123 on 16/5/23.
//  Copyright © 2016年 com.pureLake. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, FBHamburgerButtonAnimationStyle) {
    FBHamburgerButtonAnimationStyleRound = 0,  //Default
    FBHamburgerButtonAnimationStyleCross
//    FBHamburgerButtonAnimationStyleArrow
};


@interface FBHamburgerButton : UIButton
@property (nonatomic, assign) BOOL showMenu;

- (instancetype)initWithFrame:(CGRect)frame animStyle:(FBHamburgerButtonAnimationStyle)style;
@end

