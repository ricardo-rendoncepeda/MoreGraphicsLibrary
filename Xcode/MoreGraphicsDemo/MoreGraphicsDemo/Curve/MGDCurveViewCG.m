//
//  MGDCurveViewCG.m
//  MoreGraphicsDemo
//
//  Created by Ricardo on 8/25/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGDCurveViewCG.h"

@implementation MGDCurveViewCG

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint start = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPoint end = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
    
    CGPoint a = CGPointMake(CGRectGetMaxX(rect)*0.25, CGRectGetMaxY(rect)*0.25);
//    CGPoint b = CGPointMake(CGRectGetMaxX(rect)*0.75, CGRectGetMaxY(rect)*0.75);
    
    CGMutablePathRef curve = CGPathCreateMutable();
    CGPathMoveToPoint(curve, nil, start.x, start.y);
    CGPathAddQuadCurveToPoint(curve, nil, a.x, a.y, end.x, end.y);
//    CGPathAddCurveToPoint(curve, nil, a.x, a.y, b.x, b.y, end.x, end.y);
    
    CGContextAddPath(context, curve);
    CGContextSetLineWidth(context, 8.0);
    CGContextSetStrokeColorWithColor(context,[UIColor whiteColor].CGColor);
    CGContextStrokePath(context);
    
    CGPathRelease(curve);
    
    // Points
    float size = 8.0;
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, CGRectMake(a.x, a.y, size, size));
//    CGContextFillRect(context, CGRectMake(b.x, b.y, size, size));
}

@end
