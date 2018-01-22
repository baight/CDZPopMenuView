# CDZPopMenuView

[![CI Status](http://img.shields.io/travis/chenzheng/CDZPopMenuView.svg?style=flat)](https://travis-ci.org/chenzheng/CDZPopMenuView)
[![Version](https://img.shields.io/cocoapods/v/CDZPopMenuView.svg?style=flat)](http://cocoapods.org/pods/CDZPopMenuView)
[![License](https://img.shields.io/cocoapods/l/CDZPopMenuView.svg?style=flat)](http://cocoapods.org/pods/CDZPopMenuView)
[![Platform](https://img.shields.io/cocoapods/p/CDZPopMenuView.svg?style=flat)](http://cocoapods.org/pods/CDZPopMenuView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CDZPopMenuView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

![Image text](https://raw.githubusercontent.com/baight/CDZPopMenuView/master/Example/Example.gif)

```objective-c
NSArray* textArray = @[@"禁言", @"删除"];
NSArray* imageArray = @[[UIImage imageNamed:@"lesson_ic_forbade"],
[UIImage imageNamed:@"lesson_ic_delete"]];
CDZPopMenuView* menu = [[CDZPopMenuView alloc]initWithStyle:CDZPopMenuViewStyleDark textArray:textArray imageArray:imageArray];
[menu setCompletion:^(CDZPopMenuView *popMenuView, NSInteger selectedIndex) {
    NSLog(@"%zd", selectedIndex);
}];
[menu showWithSender:button];
```
or

```objective-c
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
```

## Author

baight, 303730915@qq.com

## License

CDZPopMenuView is available under the MIT license. See the LICENSE file for more info.
