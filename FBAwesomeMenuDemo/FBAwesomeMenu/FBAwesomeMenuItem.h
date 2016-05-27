//
//  FBAwesomeMenuItem.h
//  PrettyCamera
//
//  Created by 123 on 16/5/25.
//  Copyright © 2016年 com.pureLake. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FBAwesomeMenuItemDelegate <NSObject>

- (void)menuItemTapped;
@end

typedef void (^tapBlock)(NSInteger index);

@interface FBAwesomeMenuItem : UIView
@property (nonatomic, copy) NSString* menuTitle;
@property (nonatomic, assign) NSInteger itemIndex;

@property (nonatomic, weak) id<FBAwesomeMenuItemDelegate> itemDelegate;

@property (nonatomic, copy) tapBlock tapBlk;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title index:(NSInteger)idx tapHandler:(tapBlock)tapBlk;
@end
