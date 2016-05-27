//
//  CALayer+Animation.m
//  PrettyCamera
//
//  Created by 123 on 16/5/25.
//  Copyright © 2016年 com.pureLake. All rights reserved.
//

#import "CALayer+Animation.h"

@implementation CALayer(Animation)

- (void)fb_applyAnimation:(CABasicAnimation *)animation {
    
    CABasicAnimation *copy = [animation copy];
    
    if (copy.fromValue == nil) {
        copy.fromValue = [self.presentationLayer valueForKey:copy.keyPath];
    }
    
    
    [self addAnimation:copy forKey:copy.keyPath];
    [self setValue:copy.toValue forKeyPath:copy.keyPath];
    
}

@end
