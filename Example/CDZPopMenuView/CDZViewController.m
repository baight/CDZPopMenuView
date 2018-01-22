//
//  CDZViewController.m
//  CDZPopMenuView
//
//  Created by chenzheng on 01/22/2018.
//  Copyright (c) 2018 chenzheng. All rights reserved.
//

#import "CDZViewController.h"
#import <CDZPopMenuView/CDZPopMenuView.h>
#import <CDZPopMenuView/CDZPopMenuDefaultDataSource.h>

@interface CDZViewController ()

@end

@implementation CDZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickButton0:(UIButton*)button {
    NSArray* textArray = @[@"禁言", @"删除"];
    NSArray* imageArray = @[[UIImage imageNamed:@"lesson_ic_forbade"],
                            [UIImage imageNamed:@"lesson_ic_delete"]];
    CDZPopMenuView* menu = [[CDZPopMenuView alloc]initWithStyle:CDZPopMenuViewStyleDark textArray:textArray imageArray:imageArray];
    [menu setCompletion:^(CDZPopMenuView *popMenuView, NSInteger selectedIndex) {
        NSLog(@"%zd", selectedIndex);
    }];
    [menu showWithSender:button];
}

- (IBAction)clickButton1:(UIButton*)button {
    CDZPopMenuDefaultDataSource* dataSource = [[CDZPopMenuDefaultDataSource alloc]init];
    dataSource.textArray = @[@"menu 0", @"menu 1", @"menu 2", @"menu 3", @"menu 4", @"menu 5", @"menu 6", @"menu 7", @"menu 8", @"menu 9"];
    dataSource.maxHeight = 225;
    dataSource.width = 110;
    dataSource.tintColor = [UIColor brownColor];
    CDZPopMenuView* menu = [[CDZPopMenuView alloc]initWithDataSource:dataSource];
    menu.tableView.bounces = YES;
    menu.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    menu.arrowDirection = CDZPopMenuArrowDirectionLeft;
    [menu setCompletion:^(CDZPopMenuView *popMenuView, NSInteger selectedIndex) {
        NSLog(@"%zd", selectedIndex);
    }];
    [menu showWithSender:button];
}

- (IBAction)clickButton2:(UIButton*)button {
    CDZPopMenuView* menu = [[CDZPopMenuView alloc]initWithStyle:CDZPopMenuViewStyleLight textArray:@[@"menu 0", @"menu 1"] imageArray:nil];
    [menu setCompletion:^(CDZPopMenuView *popMenuView, NSInteger selectedIndex) {
        NSLog(@"%zd", selectedIndex);
    }];
    [menu showWithSender:button];
}

@end
