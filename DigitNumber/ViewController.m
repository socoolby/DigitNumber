//
//  ViewController.m
//  DigitNumber
//
//  Created by socoolby on 19/07/2017.
//  Copyright © 2017 YZXZYH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.num setFontSize:30];
    [self.num setFontPadding:12];
    [self.num setFontColor:[UIColor blackColor]];
    [self.num setTextAlias:DN_ALIGH_CENTER];
    [self.num setContent:@"0123456789:-X"];
    
    [self.timeView setFontSize:40];
    [self.timeView setFontPadding:8];
    [self.timeView setFontColor:[UIColor blackColor]];
    [self.timeView setTextAlias:DN_ALIGH_CENTER];
    [self.timeView setContent:@"23:28:08"];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
