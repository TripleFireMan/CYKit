//
//  ViewController.m
//  CYKitDemo
//
//  Created by 成焱 on 2017/2/19.
//  Copyright © 2017年 cheng.yan. All rights reserved.
//

#import "ViewController.h"
#import <CYKit.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"name = %@",[CYModel className]);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
