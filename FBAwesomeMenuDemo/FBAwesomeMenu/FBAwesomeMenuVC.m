////
////  FBAwesomeMenuVC.m
////  PrettyCamera
////
////  Created by 123 on 16/5/25.
////  Copyright © 2016年 com.pureLake. All rights reserved.
////
//
//#define kInnerEdgeAngle 15
//#define kInnerLayerRadius 165.0
//#define kInnerMenuRadius 130
//#define kInnerMenuItemCount 3
//#define kInnerMenuItemAngle (90-kInnerEdgeAngle*2)/(kInnerMenuItemCount-1)
//
//#define kOuterEdgeAngle 13
//#define kOuterLayerRadius 235.0
//#define kOuterMenuRadius 200
//#define kOuterMenuItemCount 5
//#define kOuterMenuItemAngle (90-kOuterEdgeAngle*2)/(kOuterMenuItemCount-1)
//
//#import "FBAwesomeMenuVC.h"
//#import "UIColor+Random.h"
//
//@interface FBAwesomeMenuVC () {
//    CGPoint _mOrigMenuItemCenter;
//}
//
//@property (nonatomic, strong) NSMutableArray* innerItems;
//@property (nonatomic, strong) NSMutableArray* outerItems;
//
//@property (nonatomic, strong) FBAwesomeMenuItem* settingItem;
//
//@property (nonatomic, strong) CAShapeLayer* innerLayer;
//@property (nonatomic, strong) CAShapeLayer* outerLayer;
//@property (nonatomic, strong) UIBezierPath* innerLayerStartPath;
//@property (nonatomic, strong) UIBezierPath* innerLayerEndPath;
//@property (nonatomic, strong) UIBezierPath* outerLayerStartPath;
//@property (nonatomic, strong) UIBezierPath* outerLayerEndPath;
//@end
//
//@implementation FBAwesomeMenuVC
//@synthesize menuItems = _menuItems;
//
//- (instancetype)initWithMenus:(NSArray<FBAwesomeMenuItem *> *)menus {
//    if (self = [super init]) {
//        if (menus) {
//            self.menuItems = [NSMutableArray arrayWithArray:menus];
//        }
//    }
//    
//    return self;
//}
//
////- (instancetype)init {
////    if (self = [super init]) {
////        
////    }
////    return self;
////}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//    
//    
//    _mOrigMenuItemCenter = CGPointMake(50, CGRectGetHeight(self.view.bounds)-50);
//    [self.menuItems removeAllObjects];
//    CGFloat itemW = 45.0;
//    CGFloat itemH = 45.0;
//    for (int i = 0; i<3; i++) {
//        FBAwesomeMenuItem* item = [[FBAwesomeMenuItem alloc] initWithFrame:CGRectMake(0, 0, itemW, itemH) title:@"菜单\n标题" tapHandler:^{
//            NSLog(@"----->>>>>>>>> FBAwesomeMenuItem tapped.");
//        }];
//        [self.menuItems addObject:item];
//        item.alpha = .0;
//        item.center = _mOrigMenuItemCenter;
//        [self.view addSubview:item];
//    }
//    self.settingItem = [[FBAwesomeMenuItem alloc] initWithFrame:CGRectMake(0, 0, itemW, itemH) title:@"设置" tapHandler:^{
//        NSLog(@"----->>>>>>>>> setting item tapped.");
//    }];
//    self.settingItem.alpha = .0;
//    self.settingItem.center = _mOrigMenuItemCenter;
//    [self.view addSubview:self.settingItem];
//    
//    
//    self.innerLayer = [self createRadiansLayerWithRadius:kInnerLayerRadius];
//    self.innerLayerStartPath = [self createCirclePathWithCenter:CGPointMake(0, CGRectGetMaxY(self.view.bounds)+1) radius:0];
//    self.innerLayerEndPath = [self createCirclePathWithCenter:CGPointMake(0, CGRectGetMaxY(self.view.bounds)+1) radius:kInnerLayerRadius];
//    self.innerLayer.path = self.innerLayerStartPath.CGPath;
//    [self.view.layer insertSublayer:self.innerLayer atIndex:0];
//    
//    if (self.menuItems.count >= kInnerMenuItemCount) {
//        self.outerLayer = [self createRadiansLayerWithRadius:kOuterLayerRadius];
//        self.outerLayerStartPath = [self createCirclePathWithCenter:CGPointMake(0, CGRectGetMaxY(self.view.bounds)+1) radius:0];
//        self.outerLayerEndPath = [self createCirclePathWithCenter:CGPointMake(0, CGRectGetMaxY(self.view.bounds)+1) radius:kOuterLayerRadius];
//        self.outerLayer.path = self.innerLayerStartPath.CGPath;
//        [self.view.layer insertSublayer:self.outerLayer below:self.innerLayer];
//    }
//    
//    
//    [self updateAppearance];
//}
//
//
//- (NSMutableArray<FBAwesomeMenuItem *> * )menuItems {
//    if (_menuItems == nil) {
//        _menuItems = [NSMutableArray new];
//    }
//    return _menuItems;
//}
//
//
//- (NSMutableArray*)innerItems {
//    if (_innerItems == nil) {
//        _innerItems = [NSMutableArray new];
//    }
//    return _innerItems;
//}
//
//- (NSMutableArray*)outerItems {
//    if (_outerItems == nil) {
//        _outerItems = [NSMutableArray new];
//    }
//    return _outerItems;
//}
//
//- (void)updateAppearance {
//
//    if (self.menuItems.count < kInnerMenuItemCount) {
//        [self.innerItems addObjectsFromArray:self.menuItems];
//        [self.innerItems addObject:self.settingItem];
//    }
//    else {
//        for (int i =0; i<self.menuItems.count; i++) {
//            FBAwesomeMenuItem* item = [self.menuItems objectAtIndex:i];
//            if (i<kInnerMenuItemCount) {
//                [self.innerItems addObject:item];
//            }
//            else {
//                [self.outerItems addObject:item];
//            }
//        }
//        [self.outerItems addObject:self.settingItem];
//    }
//}
//
//
//- (CAShapeLayer*)createRadiansLayerWithRadius:(CGFloat)radius {
//    CAShapeLayer* layer = [CAShapeLayer new];
//    
////    UIBezierPath* bpath = [UIBezierPath new];
////    CGPoint p = CGPointMake(0, CGRectGetMaxY(self.view.bounds)+1);
////    [bpath moveToPoint:p];
////    [bpath addArcWithCenter:p radius:radius startAngle:0 endAngle:360*M_PI/180 clockwise:YES];
////    //    [bpath closePath];
////    layer.path = bpath.CGPath;
//    layer.fillColor = [UIColor RandomColor].CGColor;
//    layer.lineWidth = 1;
//    layer.strokeColor = [UIColor RandomColor].CGColor;
//    
//    return layer;
//}
//
//
//- (UIBezierPath*)createCirclePathWithCenter:(CGPoint)center radius:(CGFloat)radius {
//    UIBezierPath* bpath = [UIBezierPath new];
////    CGPoint p = CGPointMake(0, CGRectGetMaxY(self.view.bounds)+1);
//    [bpath moveToPoint:center];
//    [bpath addArcWithCenter:center radius:radius startAngle:0 endAngle:360*M_PI/180 clockwise:YES];
//    
//    
//    return bpath;
//}
//
//
//
//- (void)showMenuWithAnimCompleteBlock:(animCompleteBlock)completeBlk {
//    if (completeBlk) {
//        self.comBlk = [completeBlk copy];
//    }
//    
//    CGPoint p = CGPointMake(0, CGRectGetMaxY(self.view.bounds));
//    
//    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
//        for (int i=0; i<self.innerItems.count; i++) {
//            FBAwesomeMenuItem* item = [self.innerItems objectAtIndex:i];
//            CGFloat nx = p.x + kInnerMenuRadius * cos(-(kInnerEdgeAngle+i*kInnerMenuItemAngle)*M_PI/180);
//            CGFloat ny = p.y + kInnerMenuRadius * sin(-(kInnerEdgeAngle+i*kInnerMenuItemAngle)*M_PI/180);
//            CGPoint newCenter = CGPointMake(nx, ny);
//            item.center = newCenter;
//            item.alpha = 1.0;
//        }
//        for (int i=0; i<self.outerItems.count; i++) {
//            FBAwesomeMenuItem* item = [self.outerItems objectAtIndex:i];
//            CGFloat nx = p.x + kOuterMenuRadius * cos(-(kOuterEdgeAngle+i*kOuterMenuItemAngle)*M_PI/180);
//            CGFloat ny = p.y + kOuterMenuRadius * sin(-(kOuterEdgeAngle+i*kOuterMenuItemAngle)*M_PI/180);
//            CGPoint newCenter = CGPointMake(nx, ny);
//            item.center = newCenter;
//            item.alpha = 1.0;
//        }
//    } completion:^(BOOL finished) {
//        if (self.comBlk) {
//            self.comBlk();
//        }
//    }];
//    
//    //--
//    CABasicAnimation* innerLayerAnim = [CABasicAnimation animationWithKeyPath:@"path"];
////    innerLayerAnim.fromValue = (__bridge id _Nullable)(self.innerLayerStartPath.CGPath);
//    innerLayerAnim.toValue = (__bridge id _Nullable)(self.innerLayerEndPath.CGPath);
//    innerLayerAnim.duration = 0.2;
////    innertLayerAnim.autoreverses = YES;
//    innerLayerAnim.removedOnCompletion = NO;
//    innerLayerAnim.fillMode = kCAFillModeForwards;
//    [self.innerLayer addAnimation:innerLayerAnim forKey:@"innerLayerAnimation1"];
//    
//    CABasicAnimation* outertLayerAnim = [CABasicAnimation animationWithKeyPath:@"path"];
////    outertLayerAnim.fromValue = (__bridge id _Nullable)(self.outerLayerStartPath.CGPath);
//    outertLayerAnim.toValue = (__bridge id _Nullable)(self.outerLayerEndPath.CGPath);
//    outertLayerAnim.duration = 0.2;
////    outertLayerAnim.autoreverses = YES;
//    outertLayerAnim.removedOnCompletion = NO;
//    outertLayerAnim.fillMode = kCAFillModeForwards;
//    [self.outerLayer addAnimation:outertLayerAnim forKey:@"outerLayerAnimation1"];
//}
//
//
//- (void)hideMenuWithAnimCompleteBlock:(animCompleteBlock)completeBlk {
//    if (completeBlk) {
//        self.comBlk = [completeBlk copy];
//    }
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        for (int i=0; i<self.menuItems.count; i++) {
//            FBAwesomeMenuItem* item = [self.menuItems objectAtIndex:i];
//            item.center = _mOrigMenuItemCenter;
//            item.alpha = .0;
//        }
//        self.settingItem.center = _mOrigMenuItemCenter;
//    } completion:^(BOOL finished) {
//        if (self.comBlk) {
//            self.comBlk();
//        }
//    }];
//    
//    //--
//    CABasicAnimation* innerLayerAnim = [CABasicAnimation animationWithKeyPath:@"path"];
//    innerLayerAnim.toValue = (__bridge id _Nullable)(self.innerLayerStartPath.CGPath);
//    innerLayerAnim.duration = 0.2;
////    innerLayerAnim.autoreverses = YES;
//    innerLayerAnim.fillMode = kCAFillModeForwards;
//    innerLayerAnim.removedOnCompletion = NO;
//    [self.innerLayer addAnimation:innerLayerAnim forKey:@"innerLayerAnimation2"];
//    
//    CABasicAnimation* outertLayerAnim = [CABasicAnimation animationWithKeyPath:@"path"];
//    outertLayerAnim.toValue = (__bridge id _Nullable)(self.outerLayerStartPath.CGPath);
//    outertLayerAnim.duration = 0.2;
////    outertLayerAnim.autoreverses = YES;
//    outertLayerAnim.removedOnCompletion = NO;
//    outertLayerAnim.fillMode = kCAFillModeForwards;
//    [self.outerLayer addAnimation:outertLayerAnim forKey:@"outerLayerAnimation2"];
//}
//
//
//
//- (void)setMenuItems:(NSMutableArray<FBAwesomeMenuItem *> *)menuItems {
//    [self updateAppearance];
//}
//
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
