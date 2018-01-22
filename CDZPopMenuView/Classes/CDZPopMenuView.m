//
//  WKPopMenuView.m
//  Pods
//
//  Created by baight chen on 2018/1/19.
//

#import "CDZPopMenuView.h"
#import "CDZPopMenuDefaultDataSource.h"

@implementation CDZPopMenuView

- (instancetype)initWithStyle:(CDZPopMenuViewStyle)style textArray:(NSArray*)textArray imageArray:(NSArray*)imageArray{
    CDZPopMenuDefaultDataSource* dataSource = [[CDZPopMenuDefaultDataSource alloc]init];
    dataSource.textArray = textArray;
    dataSource.imageArray = imageArray;
    
    if (self = [self initWithDataSource:dataSource]) {
        if (style == CDZPopMenuViewStyleLight) {
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
            dataSource.tintColor = [UIColor whiteColor];
            dataSource.highlightedTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
            dataSource.textColor = [UIColor grayColor];
        }
    }
    return self;
}

- (instancetype)initWithDataSource:(id<CDZPopMenuDataSource>)dataSource{
    if (self = [super initWithFrame:CGRectZero]) {
        self.backgroundColor = [UIColor clearColor];
        _dataSource = dataSource;
        _animationDuration = 0.1;
        _contentViewMargin = UIEdgeInsetsMake(8, 8, 8, 8);
        _automaticallyHide = YES;
        _arrowSize = 8;
        [self addSubview:self.contentView];
        [self addGestureRecognizer:self.tapGestureRecognizer];
    }
    return self;
}

- (void)showWithSender:(UIView*)sender{
    [self showInView:[UIApplication sharedApplication].keyWindow withSender:sender];
}
- (void)showInView:(UIView*)view withSender:(UIView*)sender{
    self.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
    [view addSubview:self];
    
    _senderFrameInSelf = [sender convertRect:CGRectMake(0, 0, sender.bounds.size.width, sender.bounds.size.height) toView:self];
    [self initArrowView];
    [self initTableViewAndConetentView];
    [self layoutMySubviews];
    
    CGRect frame = self.contentView.frame;
    CGPoint senderCenter = [sender convertPoint:CGPointMake(sender.bounds.size.width/2, sender.bounds.size.height/2) toView:self.contentView];
    self.contentView.layer.anchorPoint = CGPointMake(senderCenter.x/self.contentView.bounds.size.width, senderCenter.y/self.contentView.bounds.size.height);
    self.contentView.frame = frame;
    
    [self prepareForShowing];
    [UIView animateWithDuration:self.animationDuration animations:^{
        [self performShowingAnimation];
    }];
}
- (void)hide{
    [self prepareForHiding];
    [UIView animateWithDuration:self.animationDuration animations:^{
        [self performHidingAnimation];
    } completion:^(BOOL finished) {
        self.completion = nil;
        [self removeFromSuperview];
    }];
}

- (void)prepareForShowing{
    self.alpha = 0;
    self.contentView.transform = CGAffineTransformMakeScale(0.618, 0.618);
}
- (void)performShowingAnimation{
    self.alpha = 1;
    self.contentView.transform = CGAffineTransformIdentity;
}
- (void)prepareForHiding{
    
}
- (void)performHidingAnimation{
    self.alpha = 0;
    self.contentView.transform = CGAffineTransformMakeScale(0.618, 0.618);
}

- (void)tapBackground:(UITapGestureRecognizer*)tapGes{
    if (self.completion) {
        self.completion(self, -1);
    }
    if (self.automaticallyHide) {
        [self hide];
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view != self) {
        return NO;
    }
    else {
        return YES;
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataSource numberOfSectionsInTableView:tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource tableView:tableView numberOfRowsInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.dataSource tableView:tableView heightForRowAtIndexPath:indexPath];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.completion) {
        self.completion(self, indexPath.row);
    }
    if (self.automaticallyHide) {
        [self hide];
    }
}

#pragma mark - Pirvate Method
- (void)initArrowView{
    self.arrowView.arrowColor = self.dataSource.tintColor;
    CDZPopMenuArrowDirection direction = self.arrowDirection;
    if (direction == CDZPopMenuArrowDirectionAutomatical) {
        CGPoint center = CGPointMake(_senderFrameInSelf.origin.x+_senderFrameInSelf.size.width/2, _senderFrameInSelf.origin.y+_senderFrameInSelf.size.height/2);
        direction =  (center.y < self.bounds.size.height/2) ? CDZPopMenuArrowDirectionUp : CDZPopMenuArrowDirectionDown;
    }
    self.arrowView.direction = direction;
    if (self.arrowView.direction == CDZPopMenuArrowDirectionLeft ||
        self.arrowView.direction == CDZPopMenuArrowDirectionRight) {
        self.arrowView.bounds = CGRectMake(0, 0, self.arrowSize, self.arrowSize*2);
    }
    else {
        self.arrowView.bounds = CGRectMake(0, 0, self.arrowSize*2, self.arrowSize);
    }
}
- (void)initTableViewAndConetentView{
    self.tableView.backgroundColor = self.dataSource.tintColor;
    CGSize maximumSize;
    if (self.arrowView.direction == CDZPopMenuArrowDirectionLeft) {
        maximumSize.width = self.bounds.size.width-_senderFrameInSelf.origin.x-_senderFrameInSelf.size.width-self.contentViewMargin.right;
        maximumSize.height = self.bounds.size.height-self.contentViewMargin.top-self.contentViewMargin.bottom;
        maximumSize.width -= self.arrowView.bounds.size.width;
    }
    else if (self.arrowView.direction == CDZPopMenuArrowDirectionRight) {
        maximumSize.width = self.bounds.size.width-_senderFrameInSelf.origin.x-self.contentViewMargin.left;
        maximumSize.height = self.bounds.size.height-self.contentViewMargin.top-self.contentViewMargin.bottom;
        maximumSize.width -= self.arrowView.bounds.size.width;
    }
    else if (self.arrowView.direction == CDZPopMenuArrowDirectionDown) {
        maximumSize.width = self.bounds.size.width-self.contentViewMargin.left-self.contentViewMargin.right;
        maximumSize.height = self.bounds.size.height-_senderFrameInSelf.origin.y+_senderFrameInSelf.size.height-self.contentViewMargin.bottom;
        maximumSize.height -= self.arrowView.bounds.size.height;
    }
    else {
        maximumSize.width = self.bounds.size.width-self.contentViewMargin.left-self.contentViewMargin.right;
        maximumSize.height = self.bounds.size.height-_senderFrameInSelf.origin.y-self.contentViewMargin.top;
        maximumSize.height -= self.arrowView.bounds.size.height;
    }
    
    CGSize bestSize = [self.dataSource sizeFitsThat:maximumSize];
    if (self.arrowView.direction == CDZPopMenuArrowDirectionLeft ||
        self.arrowView.direction == CDZPopMenuArrowDirectionRight) {
        self.contentView.bounds = CGRectMake(0, 0, bestSize.width+self.arrowView.bounds.size.width, bestSize.height);
    }
    else {
        self.contentView.bounds = CGRectMake(0, 0, bestSize.width, bestSize.height+self.arrowView.bounds.size.height);
    }
    self.tableView.bounds = CGRectMake(0, 0, bestSize.width, bestSize.height);
}
- (void)layoutMySubviews{
    if (self.arrowView.direction == CDZPopMenuArrowDirectionLeft) {
        CGRect frame = self.contentView.frame;
        frame.origin.x = _senderFrameInSelf.origin.x + _senderFrameInSelf.size.width;
        frame.origin.y = _senderFrameInSelf.origin.y + (_senderFrameInSelf.size.height - frame.size.height)/2;
        CGFloat offset = [self verticalOffestForContentFrame:frame];
        frame.origin.y += offset;
        self.contentView.frame = frame;
        
        frame = self.arrowView.frame;
        frame.origin.x = 0;
        frame.origin.y = (self.contentView.bounds.size.height - frame.size.height)/2 - offset;
        self.arrowView.frame = frame;
        
        frame = self.tableView.frame;
        frame.origin.x = self.arrowView.frame.origin.x + self.arrowView.frame.size.width;
        frame.origin.y = 0;
        self.tableView.frame = frame;
    }
    else if (self.arrowView.direction == CDZPopMenuArrowDirectionRight) {
        CGRect frame = self.contentView.frame;
        frame.origin.x = _senderFrameInSelf.origin.x - frame.size.width;
        frame.origin.y = _senderFrameInSelf.origin.y + (_senderFrameInSelf.size.height - frame.size.height)/2;
        CGFloat offset = [self verticalOffestForContentFrame:frame];
        frame.origin.y += offset;
        self.contentView.frame = frame;
        
        frame = self.arrowView.frame;
        frame.origin.x = self.contentView.bounds.size.width - frame.size.width;
        frame.origin.y = (self.contentView.bounds.size.height - frame.size.height)/2 - offset;
        self.arrowView.frame = frame;
        
        frame = self.tableView.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        self.tableView.frame = frame;
    }
    else if (self.arrowView.direction == CDZPopMenuArrowDirectionDown) {
        CGRect frame = self.contentView.frame;
        frame.origin.x = _senderFrameInSelf.origin.x + (_senderFrameInSelf.size.width-frame.size.width)/2;
        frame.origin.y = _senderFrameInSelf.origin.y - frame.size.height;
        CGFloat offset = [self horizontalOffsetForContentFrame:frame];
        frame.origin.x += offset;
        self.contentView.frame = frame;
        
        frame = self.arrowView.frame;
        frame.origin.x = (self.contentView.bounds.size.width - frame.size.width)/2 - offset;
        frame.origin.y = self.contentView.bounds.size.height - frame.size.height;
        self.arrowView.frame = frame;
        
        frame = self.tableView.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        self.tableView.frame = frame;
    }
    else {
        CGRect frame = self.contentView.frame;
        frame.origin.x = _senderFrameInSelf.origin.x + (_senderFrameInSelf.size.width-frame.size.width)/2;
        frame.origin.y = _senderFrameInSelf.origin.y + _senderFrameInSelf.size.height;
        CGFloat offset = [self horizontalOffsetForContentFrame:frame];
        frame.origin.x += offset;
        self.contentView.frame = frame;
        
        frame = self.arrowView.frame;
        frame.origin.x = (self.contentView.bounds.size.width - frame.size.width)/2 - offset;
        frame.origin.y = 0;
        self.arrowView.frame = frame;
        
        frame = self.tableView.frame;
        frame.origin.x = 0;
        frame.origin.y = self.arrowView.frame.origin.y + self.arrowView.bounds.size.height;
        self.tableView.frame = frame;
    }
    
    if (self.arrowDirection == CDZPopMenuArrowDirectionLeft ||
        self.arrowDirection == CDZPopMenuArrowDirectionRight) {
        if (self.arrowView.frame.origin.y < self.tableView.layer.cornerRadius) {
            CGRect frame = self.arrowView.frame;
            frame.origin.y = self.tableView.layer.cornerRadius;
            self.arrowView.frame = frame;
        }
        else if (self.arrowView.frame.origin.y + self.arrowView.bounds.size.height > self.tableView.bounds.size.height-self.tableView.layer.cornerRadius){
            CGRect frame = self.arrowView.frame;
            frame.origin.x = self.tableView.bounds.size.height-self.tableView.layer.cornerRadius-frame.size.height;
            self.arrowView.frame = frame;
        }
    }
    else {
        if (self.arrowView.frame.origin.x < self.tableView.layer.cornerRadius) {
            CGRect frame = self.arrowView.frame;
            frame.origin.x = self.tableView.layer.cornerRadius;
            self.arrowView.frame = frame;
        }
        else if (self.arrowView.frame.origin.x + self.arrowView.bounds.size.width > self.tableView.bounds.size.width-self.tableView.layer.cornerRadius){
            CGRect frame = self.arrowView.frame;
            frame.origin.x = self.tableView.bounds.size.width-self.tableView.layer.cornerRadius-frame.size.width;
            self.arrowView.frame = frame;
        }
    }
}

- (CGFloat)verticalOffestForContentFrame:(CGRect)frame{
    CGFloat offset = 0;
    CGFloat minY = self.contentViewMargin.top;
    if (@available(iOS 11.0, *)) {
        minY += self.superview.safeAreaInsets.top;
    }
    if (frame.origin.y < minY) {
        offset = minY - frame.origin.y;
    }
    else {
        CGFloat maxY = self.bounds.size.height - self.contentViewMargin.bottom;
        if (@available(iOS 11.0, *)) {
            maxY -= self.superview.safeAreaInsets.bottom;
        }
        if (frame.origin.y + frame.size.height > maxY) {
            offset = maxY - (frame.origin.y + frame.size.height);
        }
    }
    return offset;
}
- (CGFloat)horizontalOffsetForContentFrame:(CGRect)frame{
    CGFloat offset = 0;
    CGFloat minX = self.contentViewMargin.left;
    if (@available(iOS 11.0, *)) {
        minX += self.superview.safeAreaInsets.left;
    }
    if (frame.origin.x < minX) {
        offset = minX - frame.origin.x;
    }
    else {
        CGFloat maxX = self.bounds.size.width - self.contentViewMargin.right;
        if (@available(iOS 11.0, *)) {
            maxX -= self.superview.safeAreaInsets.right;
        }
        if (frame.origin.x + frame.size.width > maxX) {
            offset = maxX - (frame.origin.x + frame.size.width);
        }
    }
    return offset;
}

#pragma mark - Getter And Setter
- (UIView*)arrowView{
    if (_arrowView == nil) {
        _arrowView = [[CDZPopMenuArrowView alloc]init];
        _arrowView.backgroundColor = [UIColor clearColor];
    }
    return _arrowView;
}
- (UITableView*)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = 5;
        _tableView.layer.masksToBounds = YES;
    }
    return _tableView;
}
- (UIView*)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:self.arrowView];
        [_contentView addSubview:self.tableView];
    }
    return _contentView;
}
- (UITapGestureRecognizer*)tapGestureRecognizer{
    if (_tapGestureRecognizer == nil) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackground:)];
        _tapGestureRecognizer.delegate = self;
    }
    return _tapGestureRecognizer;
}

@end
