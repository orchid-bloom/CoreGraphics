//
//  ViewController.m
//  draw
//
//  Created by tianXin on 16/7/28.
//  Copyright © 2016年 tianXin. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DrawView *drawView = [[DrawView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
