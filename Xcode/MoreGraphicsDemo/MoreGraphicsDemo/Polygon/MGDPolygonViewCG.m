//
//  MGDPolygonViewCG.m
//  MoreGraphicsDemo
//
//  Created by Ricardo on 8/25/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGDPolygonViewCG.h"

@implementation MGDPolygonViewCG

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    float x = CGRectGetMaxX(rect);
    float y = CGRectGetMaxY(rect);
    
    CGMutablePathRef polygon = CGPathCreateMutable();
    CGPathMoveToPoint(polygon, nil, x*0.0, y*0.5);
    CGPathAddLineToPoint(polygon, nil, x*0.5, y*0.0);
    CGPathAddLineToPoint(polygon, nil, x*1.0, y*0.5);
    CGPathAddLineToPoint(polygon, nil, x*0.75, y*1.0);
    CGPathAddLineToPoint(polygon, nil, x*0.5, y*0.75);
    CGPathAddLineToPoint(polygon, nil, x*0.25, y*1.0);
    CGPathCloseSubpath(polygon);
    
    CGContextAddPath(context, polygon);
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextSetLineWidth(context, 4.0);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(polygon);
}

@end
