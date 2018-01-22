//
//  WKDarkStyleDataSource.h
//  WKPopMenuView
//
//  Created by baight chen on 2018/1/19.
//

#import "CDZPopMenuDataSource.h"

@interface CDZPopMenuDefaultDataSource : NSObject <CDZPopMenuDataSource>

@property (nonatomic, strong) NSArray* textArray;
@property (nonatomic, strong) NSArray* imageArray;

@property (nonatomic, strong) UIColor* tintColor;   // default RGB(80, 80, 80)
@property (nonatomic, strong) UIColor* highlightedTintColor;    //default RGBA(255, 255, 255, 0.2)
@property (nonatomic, strong) UIColor* textColor;   // defaut white

@property (nonatomic, assign) CGFloat rowHeight;    // default 50;
@property (nonatomic, assign) CGFloat width;        // default 135;
@property (nonatomic, assign) CGFloat maxHeight;    // default 0, no limit. (but would not out of UIScreen)

@property (nonatomic, assign) UIEdgeInsets separatorInset;  // default (0, 8, 0, 8)

@end
