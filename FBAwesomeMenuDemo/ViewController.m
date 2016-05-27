//
//  ViewController.m
//  FBAwesomeMenuDemo
//
//  Created by 123 on 16/5/27.
//  Copyright © 2016年 com.pureLake. All rights reserved.
//

#import "ViewController.h"
#import "FBActiveButton/FBCrossButton.h"
#import "FBAwesomeMenu/FBAwesomeMenu.h"
#import "FBAwesomeMenu/FBAwesomeMenuItem.h"
#import "SettingViewController.h"
#import "DetailViewController.h"

@interface ViewController () {
    CGPoint _mOrigMenuItemCenter;
}
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UISwitch *styleSwitch;
@property (weak, nonatomic) IBOutlet UILabel *lb2;

@property (weak, nonatomic) IBOutlet FBCrossButton *btn;
- (IBAction)styleChange:(id)sender;
- (IBAction)btnTap:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnBottomConstraint;

@property (nonatomic, strong) FBAwesomeMenu* awesomeMenu;

@end

@implementation ViewController


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _mOrigMenuItemCenter = self.btn.center;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createAwesomeMenu];
    
    self.btn.backgroundColor = [UIColor orangeColor];
    [self.lb2 setText:[NSString stringWithFormat:@"Current style: %@", self.awesomeMenu.style==FBAwesomeMenuStyleCircle?@"circle":@"line"]];
    [self.styleSwitch setOn:self.awesomeMenu.style==FBAwesomeMenuStyleCircle];
    
    
}


- (void)createAwesomeMenu {
    CGRect rect = self.btn.bounds;
    NSArray* menus = @[@"菜单\n标题1", @"菜单\n标题2", @"菜单\n标题3", @"菜单\n标题4", @"菜单\n标题5", @"菜单\n标题6", @"设置"];
    NSMutableArray* items = [NSMutableArray new];
    for (int i = 0; i<menus.count; i++) {
        FBAwesomeMenuItem* item = [[FBAwesomeMenuItem alloc] initWithFrame:rect title:menus[i] index:i tapHandler:^(NSInteger index) {
            NSLog(@"---->>>>>> menu select: %@", menus[index]);
            
            UIViewController* vc = nil;
            if (index == menus.count-1) {
                vc = [[SettingViewController alloc] init];
            }
            else {
                vc = [[DetailViewController alloc] init];
            }
            
            if (vc) {
                vc.title = menus[index];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
        [items addObject:item];
    }
    
    self.awesomeMenu = [[FBAwesomeMenu alloc] initWithFrame:self.view.bounds menuItems:items style:FBAwesomeMenuStyleCircle];
    self.awesomeMenu.backgroundColor = [UIColor lightGrayColor];
    self.awesomeMenu.alpha = .8;
    self.awesomeMenu.hidden = YES;
    [self.view insertSubview:self.awesomeMenu belowSubview:self.btn];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)styleChange:(id)sender {
    UISwitch* sw = (UISwitch*)sender;
    [self.lb2 setText:[NSString stringWithFormat:@"Current style: %@", [sw isOn]?@"circle":@"line"]];
    
    self.awesomeMenu.style = [sw isOn]?FBAwesomeMenuStyleCircle:FBAwesomeMenuStyleLine;
}

- (IBAction)btnTap:(id)sender {
    FBCrossButton* cb = (FBCrossButton*)sender;
    [cb setShowMenu:!cb.showMenu];
    
    
    if (cb.showMenu) {
        CGPoint p = CGPointMake(_mOrigMenuItemCenter.x, CGRectGetHeight(self.view.bounds)-50);
        [UIView animateWithDuration:.2 animations:^{
            self.btn.center = p;
            self.awesomeMenu.hidden = NO;
        } completion:^(BOOL finished) {
            self.btnBottomConstraint.constant = CGRectGetHeight(self.view.bounds)-p.y-CGRectGetHeight(self.btn.frame)/2;
            [self.awesomeMenu showMenuWithAnimCompleteBlock:^{
                
            }];
        }];
    }
    else {
        [self.awesomeMenu hideMenuWithAnimCompleteBlock:^{
            [UIView animateWithDuration:.2 animations:^{
                self.btn.center = _mOrigMenuItemCenter;
                self.awesomeMenu.hidden = YES;
            } completion:^(BOOL finished) {
                self.btnBottomConstraint.constant = 84;
            }];
        }];
    }
}
@end
