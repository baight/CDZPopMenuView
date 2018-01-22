//
//  WKPopMenuView.h
//  Pods
//
//  Created by baight chen on 2018/1/19.
//

#import <UIKit/UIKit.h>
#import "CDZPopMenuDataSource.h"
#import "CDZPopMenuArrowView.h"

typedef NS_ENUM(NSInteger, CDZPopMenuViewStyle) {
    CDZPopMenuViewStyleLight,
    CDZPopMenuViewStyleDark,
};

@class CDZPopMenuView;
typedef void(^CDZPopMenuViewCompletion)(CDZPopMenuView* popMenuView, NSInteger selectedIndex);

@interface CDZPopMenuView : UIView <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate> {
    CGRect _senderFrameInSelf;
    
    UIView* _arrowView;
    UITableView* _tableView;
    UIView* _contentView;
    UITapGestureRecognizer* _tapGestureRecognizer;
}

@property (nonatomic, strong, readonly) id<CDZPopMenuDataSource> dataSource;

// if user cancels, selectedIndex will be -1
@property (nonatomic, copy) CDZPopMenuViewCompletion completion;

@property (nonatomic, assign) BOOL automaticallyHide;
@property (nonatomic, strong, readonly) UITapGestureRecognizer* tapGestureRecognizer;

@property (nonatomic, strong, readonly) CDZPopMenuArrowView* arrowView;
@property (nonatomic, assign) CGFloat arrowSize; // default 8
@property (nonatomic, assign) CDZPopMenuArrowDirection arrowDirection; // default automatical

// you should never set tableView's dataSource And delegate, otherwise the popMenu will not work
@property (nonatomic, strong, readonly) UITableView* tableView;

// the view that contains arrowView and tableView
@property (nonatomic, strong, readonly) UIView* contentView;

@property (nonatomic, assign) UIEdgeInsets contentViewMargin; // default (8, 8, 8, 8)

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithStyle:(CDZPopMenuViewStyle)style textArray:(NSArray*)textArray imageArray:(NSArray*)imageArray;
- (instancetype)initWithDataSource:(id<CDZPopMenuDataSource>)dataSource NS_DESIGNATED_INITIALIZER;

@property (nonatomic, assign) NSTimeInterval animationDuration; // default 0.1

// calls showInView:withSender: with application's keyWindow
- (void)showWithSender:(UIView*)sender;
- (void)showInView:(UIView*)view withSender:(UIView*)sender;
- (void)hide;

// these methods are designed for custom animation of Showing and hiding for subclass
- (void)prepareForShowing;
- (void)performShowingAnimation;
- (void)prepareForHiding;
- (void)performHidingAnimation;


@end
