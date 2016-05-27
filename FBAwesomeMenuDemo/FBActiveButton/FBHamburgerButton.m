//
//  FBHamburgerButton.m
//  PrettyCamera
//
//  Created by 123 on 16/5/23.
//  Copyright © 2016年 com.pureLake. All rights reserved.
//

#import "FBHamburgerButton.h"
#import "CALayer+Animation.h"

#define kHMargin 2
#define kVMargin 5
#define   kDegreesToRadians(degrees)  ((M_PI * degrees)/ 180)  //角度转为弧度
#define   kRadiansToDegrees(radians)  ((radians * 180)/ M_PI)  //弧度转为角度

@interface FBHamburgerButton() {
    
    CGFloat menuStrokeStart;
    CGFloat menuStrokeEnd;
    CGFloat circleStrokeStart;
    CGFloat circleStrokeEnd;
}

@property (nonatomic, assign) FBHamburgerButtonAnimationStyle style;

@property (nonatomic, strong) UIColor* lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, assign) NSUInteger lineCount; // Default is 3
@property (nonatomic, assign) CGFloat animDuration;

@property (nonatomic, strong) CAShapeLayer* topLineLayer;
@property (nonatomic, strong) CAShapeLayer* middleLineLayer;
@property (nonatomic, strong) CAShapeLayer* bottomLineLayer;

@end

@implementation FBHamburgerButton


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self performInitWithAnimStyle:FBHamburgerButtonAnimationStyleRound];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self performInitWithAnimStyle:FBHamburgerButtonAnimationStyleRound];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame animStyle:(FBHamburgerButtonAnimationStyle)style {
    if (self = [super initWithFrame:frame]) {
        [self performInitWithAnimStyle:style];
    }
    
    return self;
}



- (void)performInitWithAnimStyle:(FBHamburgerButtonAnimationStyle)style {
    self.showMenu = NO;
    self.style = style;
    self.animDuration = 2;
    self.lineCount = 3;
    self.lineColor = [UIColor blackColor];
    self.lineWidth = CGRectGetWidth(self.frame)-kHMargin*2;
    self.lineHeight = 3.0;
    self.lineSpace = (CGRectGetHeight(self.frame)-kVMargin*2-self.lineHeight*3)/(self.lineCount-1);
    
    
    CGFloat x = CGRectGetWidth(self.frame) / 2.;
    CGFloat y = 0.0;
    
    //--top
    y = kVMargin + self.lineHeight / 2.0;
    self.topLineLayer = [self createLineLayer];
    self.topLineLayer.position = CGPointMake(x, y);
    
    
    //--bottom
    y = CGRectGetHeight(self.frame) / 2.0 + self.lineHeight + self.lineSpace;
    self.bottomLineLayer = [self createLineLayer];
    self.bottomLineLayer.position = CGPointMake(x, y);
    
    
    //--middle
    CGPoint centerP = CGPointMake(x, CGRectGetHeight(self.frame) / 2.0);
    CGFloat radius = x+3;
    CGFloat angle = 25;
    CGFloat x1 = centerP.x + radius * cos(-angle*M_PI/180);
    CGFloat y1 = centerP.y + radius * sin(-angle*M_PI/180);
    UIBezierPath* mPath = [UIBezierPath new];
    [mPath moveToPoint:CGPointMake(kHMargin, centerP.y)];
    [mPath addLineToPoint:CGPointMake(kHMargin+self.lineWidth, centerP.y)];
    if (self.style == FBHamburgerButtonAnimationStyleRound) {
        [mPath moveToPoint:CGPointMake(kHMargin+self.lineWidth, centerP.y)];
        [mPath addQuadCurveToPoint:CGPointMake(x1, y1) controlPoint:CGPointMake(x*2+2, CGRectGetHeight(self.frame) / 2.0)];
        [mPath addArcWithCenter:centerP radius:radius startAngle:kDegreesToRadians(0) endAngle:kDegreesToRadians(360) clockwise:YES];
        
        menuStrokeStart = 0.0;
        menuStrokeEnd = 0.17;
        circleStrokeStart = 0.23;
        circleStrokeEnd = 1.0;
    }
    else {
        menuStrokeStart = 0.0;
        menuStrokeEnd = 1.0;
    }
    self.middleLineLayer = [CAShapeLayer new];
    self.middleLineLayer.path = mPath.CGPath;
    self.middleLineLayer.strokeStart = menuStrokeStart;
    self.middleLineLayer.strokeEnd = menuStrokeEnd;
    self.middleLineLayer.fillColor = nil;
    self.middleLineLayer.lineWidth = self.lineHeight;
    self.middleLineLayer.strokeColor = self.lineColor.CGColor;
//    CGPathRef bound = CGPathCreateCopyByStrokingPath(self.middleLineLayer.path, nil, self.middleLineLayer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, self.middleLineLayer.miterLimit);
//    self.middleLineLayer.bounds = CGPathGetBoundingBox(bound);
//    CGPathRelease(bound);
    [self.layer addSublayer:self.middleLineLayer];
}



- (CAShapeLayer*)createLineLayer {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.lineWidth, 0)];
    
    layer.path = path.CGPath;
    layer.lineWidth = self.lineHeight;
    layer.strokeColor = self.lineColor.CGColor;
    layer.fillColor = nil;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    
    [self.layer addSublayer:layer];
    
    return layer;
}




- (void)hamburger2Other {
    switch (self.style) {
        case FBHamburgerButtonAnimationStyleRound:{
            [self hamburger2Round];
        } break;
        case FBHamburgerButtonAnimationStyleCross:{
            [self hamburger2Cross];
        } break;
//        case FBHamburgerButtonAnimationStyleArrow:{
//            [self hamburger2Arrow];
//        } break;
        default:
            break;
    }
}

- (void)other2Hamburger {
    switch (self.style) {
        case FBHamburgerButtonAnimationStyleRound:{
            [self round2Hamburger];
        } break;
        case FBHamburgerButtonAnimationStyleCross:{
            [self cross2Hamburger];
        } break;
//        case FBHamburgerButtonAnimationStyleArrow:{
//            [self arrow2Hamburger];
//        } break;
        default:
            break;
    }
}



- (void)hamburger2Round {
    CABasicAnimation *strokeStartAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *strokeEndAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    [strokeStartAnim setToValue:[NSNumber numberWithFloat:circleStrokeStart]];
    strokeStartAnim.duration = .5;
    //        strokeStartAnim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.4 :0.5 :1];
    
    [strokeEndAnim setToValue:[NSNumber numberWithFloat:circleStrokeEnd]];
    strokeEndAnim.duration = .6;
    //        strokeEndAnim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.4 :0.5 :1];
    
    
    [self.middleLineLayer fb_applyAnimation:strokeStartAnim];
    [self.middleLineLayer fb_applyAnimation:strokeEndAnim];
    
    [self topCrossBottom];
}

- (void)hamburger2Cross {
    CABasicAnimation *strokeStartAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *strokeEndAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    [strokeStartAnim setToValue:[NSNumber numberWithFloat:.5]];
    strokeStartAnim.duration = .5;
    //        strokeStartAnim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.4 :0.5 :1];
    
    [strokeEndAnim setToValue:[NSNumber numberWithFloat:.5]];
    strokeEndAnim.duration = .6;
    //        strokeEndAnim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.4 :0.5 :1];
    
    
    [self.middleLineLayer fb_applyAnimation:strokeStartAnim];
    [self.middleLineLayer fb_applyAnimation:strokeEndAnim];
    
    [self topCrossBottom];
}

- (void)hamburger2Arrow {
    
}


- (void)round2Hamburger {
    CABasicAnimation *strokeStartAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *strokeEndAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    [strokeStartAnim setToValue:[NSNumber numberWithFloat:menuStrokeStart]];
    strokeStartAnim.duration = .5;
    //        strokeStartAnim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :0 :0.5 :1.2];
    strokeStartAnim.beginTime = CACurrentMediaTime() + 0.1;
    strokeStartAnim.fillMode = kCAFillModeBackwards;
    
    [strokeEndAnim setToValue:[NSNumber numberWithFloat:menuStrokeEnd]];
    strokeEndAnim.duration = .6;
    //        strokeEndAnim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :0.3 :0.5 :0.9];
    
    
    [self.middleLineLayer fb_applyAnimation:strokeStartAnim];
    [self.middleLineLayer fb_applyAnimation:strokeEndAnim];
    
    [self topParallelBottom];
}


- (void)cross2Hamburger {
    CABasicAnimation *strokeStartAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *strokeEndAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    [strokeStartAnim setToValue:[NSNumber numberWithFloat:menuStrokeStart]];
    strokeStartAnim.duration = .5;
    //        strokeStartAnim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :0 :0.5 :1.2];
    strokeStartAnim.beginTime = CACurrentMediaTime() + 0.1;
    strokeStartAnim.fillMode = kCAFillModeBackwards;
    
    [strokeEndAnim setToValue:[NSNumber numberWithFloat:menuStrokeEnd]];
    strokeEndAnim.duration = .6;
    //        strokeEndAnim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :0.3 :0.5 :0.9];
    
    
    [self.middleLineLayer fb_applyAnimation:strokeStartAnim];
    [self.middleLineLayer fb_applyAnimation:strokeEndAnim];
    
    [self topParallelBottom];
}

- (void)arrow2Hamburger {
    
}


- (void)topCrossBottom {
    //CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.8 :0.75 :1.85];
    CABasicAnimation *topTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    //topTransform.timingFunction = timingFunction;
    topTransform.fillMode = kCAFillModeBackwards;
    
    CABasicAnimation *bottomTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    //bottomTransform.timingFunction = timingFunction;
    bottomTransform.fillMode = kCAFillModeBackwards;
    
    CATransform3D translation = CATransform3DMakeTranslation(0, self.topLineLayer.position.y+kVMargin-3, 0);
    
    topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, -M_PI_4, 0, 0, 1)];
    topTransform.beginTime = CACurrentMediaTime() + 0.25;
    
    translation = CATransform3DMakeTranslation(0, -self.topLineLayer.position.y-kVMargin+3, 0);
    bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, M_PI_4, 0, 0, 1)];
    bottomTransform.beginTime = CACurrentMediaTime() + 0.25;
    
    
    [self.topLineLayer fb_applyAnimation:topTransform];
    [self.bottomLineLayer fb_applyAnimation:bottomTransform];
}

- (void)topParallelBottom {
    //CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.8 :0.75 :1.85];
    CABasicAnimation *topTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    //topTransform.timingFunction = timingFunction;
    topTransform.fillMode = kCAFillModeBackwards;
    
    CABasicAnimation *bottomTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    //bottomTransform.timingFunction = timingFunction;
    bottomTransform.fillMode = kCAFillModeBackwards;
    

    topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    topTransform.beginTime = CACurrentMediaTime() + 0.05;
        
    bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    bottomTransform.beginTime = CACurrentMediaTime() + 0.05;
    
    
    [self.topLineLayer fb_applyAnimation:topTransform];
    [self.bottomLineLayer fb_applyAnimation:bottomTransform];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)setShowMenu:(BOOL)showMenu {
    _showMenu = showMenu;
    
    if (showMenu) {
        [self hamburger2Other];
    }
    else {
        [self other2Hamburger];
    }
}

@end


