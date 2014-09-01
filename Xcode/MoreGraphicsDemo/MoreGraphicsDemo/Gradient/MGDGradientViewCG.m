//
//  MGDGradientViewCG.m
//  MoreGraphicsDemo
//
//  Created by Ricardo on 8/25/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGDGradientViewCG.h"

@implementation MGDGradientViewCG
{
    BOOL _isRunning;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef startColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
    CGColorRef endColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0].CGColor;
    
    NSArray* colors = @[(__bridge id)startColor, (__bridge id)endColor];
    CGFloat locations[] = {0.0, 1.0};
    
    CGGradientRef gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), (__bridge CFArrayRef)colors, locations);
    
    // LINEAR
    CGPoint startPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    // RADIAL
//    CGPoint centerPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
//    CGContextDrawRadialGradient(context, gradient, centerPoint, 0.0, centerPoint, CGRectGetMidX(rect), 0);
}

@end
