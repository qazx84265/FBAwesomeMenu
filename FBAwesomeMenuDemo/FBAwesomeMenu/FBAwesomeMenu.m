//
//  FBAwesomeMenu.m
//  FBAwesomeMenuDemo
//
//  Created by 123 on 16/5/27.
//  Copyright © 2016年 com.pureLake. All rights reserved.
//

#import "FBAwesomeMenu.h"
#import "UIColor+Random.h"

#define kInnerEdgeAngle 15
#define kInnerLayerRadius 165.0
#define kInnerMenuRadius 130
#define kInnerMenuItemCount 3
#define kInnerMenuItemAngle (90-kInnerEdgeAngle*2)/(kInnerMenuItemCount-1)

#define kOuterEdgeAngle 13
#define kOuterLayerRadius 235.0
#define kOuterMenuRadius 200
#define kOuterMenuItemCount 5
#define kOuterMenuItemAngle (90-kOuterEdgeAngle*2)/(kOuterMenuItemCount-1)



@interface FBAwesomeMenu(){
    CGPoint _mOrigMenuItemCenter;
}
@property (nonatomic, strong) CAShapeLayer* innerLayer;
@property (nonatomic, strong) CAShapeLayer* outerLayer;
@property (nonatomic, strong) UIBezierPath* innerLayerStartPath;
@property (nonatomic, strong) UIBezierPath* innerLayerEndPath;
@property (nonatomic, strong) UIBezierPath* outerLayerStartPath;
@property (nonatomic, strong) UIBezierPath* outerLayerEndPath;
@end

@implementation FBAwesomeMenu


- (instancetype)initWithFrame:(CGRect)frame
                    menuItems:(NSArray<FBAwesomeMenuItem *> *)items
                        style:(FBAwesomeMenuStyle)style {
    if (self = [super initWithFrame:frame]) {

        [self commonInit];
        
        self.menuItems = [items copy];
        self.style = style;
        
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    
    return self;
}


- (void)commonInit {
    self.menuItems = [NSArray new];
    self.style = FBAwesomeMenuStyleCircle;
}



- (void)updateAppearance {
    
    if (self.menuItems.count == 0) {
        return;
    }
    
    _mOrigMenuItemCenter = CGPointMake(50, CGRectGetHeight(self.bounds)-50);
    for (FBAwesomeMenuItem* item in self.menuItems) {
        item.center = _mOrigMenuItemCenter;
        item.alpha = .0;
        [self addSubview:item];
    }
    
    if (self.style == FBAwesomeMenuStyleCircle) {
        self.innerLayer = [self createRadiansLayerWithRadius:kInnerLayerRadius];
        self.innerLayerStartPath = [self createCirclePathWithCenter:CGPointMake(0, CGRectGetMaxY(self.bounds)+1) radius:0];
        self.innerLayerEndPath = [self createCirclePathWithCenter:CGPointMake(0, CGRectGetMaxY(self.bounds)+1) radius:kInnerLayerRadius];
        self.innerLayer.path = self.innerLayerStartPath.CGPath;
        [self.layer insertSublayer:self.innerLayer atIndex:0];
        
        if (self.menuItems.count >= kInnerMenuItemCount) {
            self.outerLayer = [self createRadiansLayerWithRadius:kOuterLayerRadius];
            self.outerLayerStartPath = [self createCirclePathWithCenter:CGPointMake(0, CGRectGetMaxY(self.bounds)+1) radius:0];
            self.outerLayerEndPath = [self createCirclePathWithCenter:CGPointMake(0, CGRectGetMaxY(self.bounds)+1) radius:kOuterLayerRadius];
            self.outerLayer.path = self.innerLayerStartPath.CGPath;
            [self.layer insertSublayer:self.outerLayer below:self.innerLayer];
        }
    }
}


- (CAShapeLayer*)createRadiansLayerWithRadius:(CGFloat)radius {
    CAShapeLayer* layer = [CAShapeLayer new];
    
    layer.fillColor = [UIColor RandomColor].CGColor;
    layer.lineWidth = 1;
    layer.strokeColor = [UIColor RandomColor].CGColor;
    
    return layer;
}


- (UIBezierPath*)createCirclePathWithCenter:(CGPoint)center radius:(CGFloat)radius {
    UIBezierPath* bpath = [UIBezierPath new];
    //    CGPoint p = CGPointMake(0, CGRectGetMaxY(self.view.bounds)+1);
    [bpath moveToPoint:center];
    [bpath addArcWithCenter:center radius:radius startAngle:0 endAngle:360*M_PI/180 clockwise:YES];
    
    return bpath;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)showMenuWithAnimCompleteBlock:(animCompleteBlock)completeBlk {
    if (completeBlk) {
        self.comBlk = [completeBlk copy];
    }
    
    if (self.style == FBAwesomeMenuStyleCircle) {
        CGPoint p = CGPointMake(0, CGRectGetMaxY(self.bounds));
        [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            for (int i=0; i<self.menuItems.count; i++) {
                FBAwesomeMenuItem* item = [self.menuItems objectAtIndex:i];
                
                CGFloat nx = 0.0;
                CGFloat ny = 0.0;
                if (i < kInnerMenuItemCount) {
                    nx = p.x + kInnerMenuRadius * cos(-(kInnerEdgeAngle+i*kInnerMenuItemAngle)*M_PI/180);
                    ny = p.y + kInnerMenuRadius * sin(-(kInnerEdgeAngle+i*kInnerMenuItemAngle)*M_PI/180);
                }
                else {
                    nx = p.x + kOuterMenuRadius * cos(-(kOuterEdgeAngle+(i-kInnerMenuItemCount)*kOuterMenuItemAngle)*M_PI/180);
                    ny = p.y + kOuterMenuRadius * sin(-(kOuterEdgeAngle+(i-kInnerMenuItemCount)*kOuterMenuItemAngle)*M_PI/180);
                }
                
                item.center = CGPointMake(nx, ny);
                item.alpha = 1.0;
            }
        } completion:^(BOOL finished) {
            if (self.comBlk) {
                self.comBlk();
            }
        }];
        
        //--
        CABasicAnimation* innerLayerAnim = [CABasicAnimation animationWithKeyPath:@"path"];
        //    innerLayerAnim.fromValue = (__bridge id _Nullable)(self.innerLayerStartPath.CGPath);
        innerLayerAnim.toValue = (__bridge id _Nullable)(self.innerLayerEndPath.CGPath);
        innerLayerAnim.duration = 0.2;
        //    innertLayerAnim.autoreverses = YES;
        innerLayerAnim.removedOnCompletion = NO;
        innerLayerAnim.fillMode = kCAFillModeForwards;
        [self.innerLayer addAnimation:innerLayerAnim forKey:@"innerLayerAnimation1"];
        
        CABasicAnimation* outertLayerAnim = [CABasicAnimation animationWithKeyPath:@"path"];
        //    outertLayerAnim.fromValue = (__bridge id _Nullable)(self.outerLayerStartPath.CGPath);
        outertLayerAnim.toValue = (__bridge id _Nullable)(self.outerLayerEndPath.CGPath);
        outertLayerAnim.duration = 0.2;
        //    outertLayerAnim.autoreverses = YES;
        outertLayerAnim.removedOnCompletion = NO;
        outertLayerAnim.fillMode = kCAFillModeForwards;
        [self.outerLayer addAnimation:outertLayerAnim forKey:@"outerLayerAnimation1"];
    }
    else {
        [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            for (int i=0; i<self.menuItems.count; i++) {
                FBAwesomeMenuItem* item = [self.menuItems objectAtIndex:i];
                
                CGFloat nx = _mOrigMenuItemCenter.x;
                CGFloat ny = _mOrigMenuItemCenter.y - (CGRectGetHeight(item.frame)+10)*(i+1);
                
                CGPoint newCenter = CGPointMake(nx, ny);
                item.center = newCenter;
                item.alpha = 1.0;
            }
        } completion:^(BOOL finished) {
            if (self.comBlk) {
                self.comBlk();
            }
        }];
    }
}


- (void)hideMenuWithAnimCompleteBlock:(animCompleteBlock)completeBlk {
    if (completeBlk) {
        self.comBlk = [completeBlk copy];
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        for (int i=0; i<self.menuItems.count; i++) {
            FBAwesomeMenuItem* item = [self.menuItems objectAtIndex:i];
            item.center = _mOrigMenuItemCenter;
            item.alpha = .0;
        }
    } completion:^(BOOL finished) {
        if (self.comBlk) {
            self.comBlk();
        }
    }];
    
    if (self.style == FBAwesomeMenuStyleCircle) {
        //--
        CABasicAnimation* innerLayerAnim = [CABasicAnimation animationWithKeyPath:@"path"];
        innerLayerAnim.toValue = (__bridge id _Nullable)(self.innerLayerStartPath.CGPath);
        innerLayerAnim.duration = 0.2;
        //    innerLayerAnim.autoreverses = YES;
        innerLayerAnim.fillMode = kCAFillModeForwards;
        innerLayerAnim.removedOnCompletion = NO;
        [self.innerLayer addAnimation:innerLayerAnim forKey:@"innerLayerAnimation2"];
        
        CABasicAnimation* outertLayerAnim = [CABasicAnimation animationWithKeyPath:@"path"];
        outertLayerAnim.toValue = (__bridge id _Nullable)(self.outerLayerStartPath.CGPath);
        outertLayerAnim.duration = 0.2;
        //    outertLayerAnim.autoreverses = YES;
        outertLayerAnim.removedOnCompletion = NO;
        outertLayerAnim.fillMode = kCAFillModeForwards;
        [self.outerLayer addAnimation:outertLayerAnim forKey:@"outerLayerAnimation2"];
    }
    else {
        
    }
}



- (void)setMenuItems:(NSMutableArray<FBAwesomeMenuItem *> *)menuItems {
    _menuItems = [NSArray arrayWithArray:menuItems];
    [self updateAppearance];
}



//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    if (self.hideWhenTapOutsideMenu) {
//        
//        __weak typeof(self) weakSelf = self;
//        [self hideMenuWithAnimCompleteBlock:^{
//            [weakSelf setHidden:YES];
//        }];
//    }
//}


@end
