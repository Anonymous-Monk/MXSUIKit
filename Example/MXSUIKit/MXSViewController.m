//
//  MXSViewController.m
//  MXSUIKit
//
//  Created by Anonymous-Monk on 08/20/2019.
//  Copyright (c) 2019 Anonymous-Monk. All rights reserved.
//

#import "MXSViewController.h"
#import <MXSUIKit/RHUIKit.h>
@interface MXSViewController ()

@end

@implementation MXSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(30, 100, 200, 30)];
    line.backgroundColor = [UIColor whiteColor];
    [line addBottomLine:12 rightSpace:12 color:[UIColor redColor]];
    [line addTopLine:12 rightSpace:12 color:[UIColor orangeColor]];
    [line addLeftLine:2 bottomSpace:2 color:[UIColor blueColor]];
    [line addRightLine:2 bottomSpace:2 color:[UIColor greenColor]];
    [self.view addSubview:line];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
