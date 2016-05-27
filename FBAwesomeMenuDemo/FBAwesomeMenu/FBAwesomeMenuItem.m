//
//  FBAwesomeMenuItem.m
//  PrettyCamera
//
//  Created by 123 on 16/5/25.
//  Copyright © 2016年 com.pureLake. All rights reserved.
//

#import "FBAwesomeMenuItem.h"
#import "UIColor+Random.h"

@implementation FBAwesomeMenuItem

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                        index:(NSInteger)idx
                   tapHandler:(tapBlock)tapBlk {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        
        
        if (tapBlk) {
            self.tapBlk = [tapBlk copy];
        }
        self.menuTitle = title;
        self.itemIndex = idx;
        
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
    
    UIButton* btn = [[UIButton alloc] initWithFrame:self.bounds];
    if (_menuTitle) {
        btn.titleLabel.text = _menuTitle;
        [btn setTitle:_menuTitle forState:UIControlStateNormal];
    }
    btn.backgroundColor = [UIColor RandomColor];
    btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    btn.titleLabel.textColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    //--mask
    CAShapeLayer* maskLayer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))/2-2 startAngle:0 endAngle:360*M_PI/180 clockwise:YES];
    maskLayer.path = path.CGPath;
    //    maskLayer.fillColor = [UIColor redColor].CGColor;
    btn.layer.mask = maskLayer;
}


- (void)btnTap:(UIButton*)button {
    if ([self.itemDelegate respondsToSelector:@selector(menuItemTapped)]) {
        [self.itemDelegate menuItemTapped];
    }
    
    if (self.tapBlk) {
        self.tapBlk(self.itemIndex);
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
