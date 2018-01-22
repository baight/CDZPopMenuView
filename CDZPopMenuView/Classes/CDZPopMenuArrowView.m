//
//  WKPopMenuArrowView.m
//  WKPopMenuView
//
//  Created by baight chen on 2018/1/19.
//

#import "CDZPopMenuArrowView.h"

@implementation CDZPopMenuArrowView

- (void)setDirection:(CDZPopMenuArrowDirection)direction{
    if (_direction == direction) {
        return;
    }
    _direction = direction;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    CGPoint point0;
    CGPoint point1;
    CGPoint point2;
    if (self.direction == CDZPopMenuArrowDirectionLeft) {
        point0 = CGPointMake(0, rect.size.height/2);
        point1 = CGPointMake(rect.size.width, 0);
        point2 = CGPointMake(rect.size.width, rect.size.height);
    }
    else if (self.direction == CDZPopMenuArrowDirectionRight){
        point0 = CGPointMake(rect.size.width, rect.size.height/2);
        point1 = CGPointMake(0, 0);
        point2 = CGPointMake(0, rect.size.height);
    }
    else if (self.direction == CDZPopMenuArrowDirectionDown){
        point0 = CGPointMake(rect.size.width/2, rect.size.height);
        point1 = CGPointMake(0, 0);
        point2 = CGPointMake(rect.size.width, 0);
    }
    else {
        point0 = CGPointMake(rect.size.width/2, 0);
        point1 = CGPointMake(0, rect.size.height);
        point2 = CGPointMake(rect.size.width, rect.size.height);
    }
    
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, point0.x, point0.y);
    CGContextAddLineToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point2.x, point2.y);
    CGContextAddLineToPoint(context, point0.x, point0.y);
    CGContextSetFillColorWithColor(context, self.arrowColor.CGColor);
    CGContextFillPath(context);
}

@end
