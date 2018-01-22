//
//  WKPopMenuArrowView.h
//  WKPopMenuView
//
//  Created by baight chen on 2018/1/19.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CDZPopMenuArrowDirection) {
    CDZPopMenuArrowDirectionAutomatical = 0,
    CDZPopMenuArrowDirectionUp,
    CDZPopMenuArrowDirectionLeft,
    CDZPopMenuArrowDirectionDown,
    CDZPopMenuArrowDirectionRight
};

@interface CDZPopMenuArrowView : UIView

@property (nonatomic, assign) CDZPopMenuArrowDirection direction;
@property (nonatomic, strong) UIColor* arrowColor;

@end
