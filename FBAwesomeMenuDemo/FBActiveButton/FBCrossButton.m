//
//  FBCrossButton.m
//  PrettyCamera
//
//  Created by 123 on 16/5/25.
//  Copyright © 2016年 com.pureLake. All rights reserved.
//

#import "FBCrossButton.h"
#import "CALayer+Animation.h"

@interface FBCrossButton()
@property (nonatomic, strong) UIColor* lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat lineLength;
@property (nonatomic, assign) CGFloat animDuration;

@property (nonatomic, strong) CALayer* vLineLayer;
@property (nonatomic, strong) CALayer* hLineLayer;

@end

@implementation FBCrossButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self performInit];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self performInit];
    }
    return self;
}



- (void)performInit {
    _showMenu = NO;
    self.lineColor = [UIColor blackColor];
    self.lineWidth = 2.5;
    self.lineLength = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))-7*2;
//    self.animDuration = 0.5;
    
    self.vLineLayer = [self createLineLayerWithTag:0];
    self.hLineLayer = [self createLineLayerWithTag:1];

    //--mask
    CAShapeLayer* maskLayer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))/2-2 startAngle:0 endAngle:360*M_PI/180 clockwise:YES];
    maskLayer.path = path.CGPath;
//    maskLayer.fillColor = [UIColor redColor].CGColor;
    self.layer.mask = maskLayer;
//    self.layer.backgroundColor = [UIColor redColor].CGColor;
}
/**
 *
 *
 *  @param tag 0: v 1: h
 *
 *  @return 
 */
- (CAShapeLayer*)createLineLayerWithTag:(NSInteger)tag {
    
    CAShapeLayer* lineLayer = [CAShapeLayer new];
    
    UIBezierPath *bpath = [UIBezierPath new];
    CGFloat centerX = CGRectGetMidX(self.bounds);
    CGFloat centerY = CGRectGetMidY(self.bounds);
    [bpath moveToPoint:tag==0?CGPointMake(centerX, 0):CGPointMake(0, centerY)];
    [bpath addLineToPoint:tag==0?CGPointMake(centerX, self.lineLength):CGPointMake(self.lineLength, centerY)];
    lineLayer.path = bpath.CGPath;
    lineLayer.fillColor = nil;
    lineLayer.strokeColor = self.lineColor.CGColor;
    lineLayer.lineWidth = self.lineWidth;
    lineLayer.position = CGPointMake(centerX, centerY);
    CGPathRef bound = CGPathCreateCopyByStrokingPath(lineLayer.path, nil, lineLayer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, lineLayer.miterLimit);
    lineLayer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    
    [self.layer addSublayer:lineLayer];
    
    return lineLayer;
}



- (void)setShowMenu:(BOOL)showMenu {
    _showMenu = showMenu;
    
    if (_showMenu) {
        CABasicAnimation *vTransformAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //vTransformAnim.timingFunction = timingFunction;
        vTransformAnim.fillMode = kCAFillModeBackwards;
        
        CABasicAnimation *hTransformAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //hTransformAnim = timingFunction;
        hTransformAnim.fillMode = kCAFillModeBackwards;
        
//        vTransformAnim.fromValue = [NSNumber numberWithFloat:.0];
        vTransformAnim.toValue = [NSNumber numberWithFloat:M_PI_4];
        vTransformAnim.beginTime = CACurrentMediaTime() + 2.25;
//        vTransformAnim.duration = self.animDuration;
        
//        hTransformAnim.fromValue = [NSNumber numberWithFloat:.0];
        hTransformAnim.toValue = [NSNumber numberWithFloat:M_PI_4];
        hTransformAnim.beginTime = CACurrentMediaTime() + 2.25;
//        hTransformAnim.duration = self.animDuration;
        
        [self.vLineLayer fb_applyAnimation:vTransformAnim];
        [self.hLineLayer fb_applyAnimation:hTransformAnim];
    }
    else {
        //CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.8 :0.75 :1.85];
        CABasicAnimation *vTransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
        //vTransformAnim.timingFunction = timingFunction;
        vTransformAnim.fillMode = kCAFillModeBackwards;
        
        
        CABasicAnimation *hTransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
        //hTransformAnim.timingFunction = timingFunction;
        hTransformAnim.fillMode = kCAFillModeBackwards;
        
        
        vTransformAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        vTransformAnim.beginTime = CACurrentMediaTime() + 2.05;
//        vTransformAnim.duration = self.animDuration;
        
        hTransformAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        hTransformAnim.beginTime = CACurrentMediaTime() + 2.05;
//        hTransformAnim.duration = self.animDuration;
        
        
        [self.vLineLayer fb_applyAnimation:vTransformAnim];
        [self.hLineLayer fb_applyAnimation:hTransformAnim];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
