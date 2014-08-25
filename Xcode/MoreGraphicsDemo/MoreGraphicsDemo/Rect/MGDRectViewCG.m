//
//  MGDRectViewCG.m
//  MoreGraphicsDemo
//
//  Created by Ricardo on 8/24/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGDRectViewCG.h"

@implementation MGDRectViewCG

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Fill
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, rect);
    
    // Stroke
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextStrokeRectWithWidth(context, rect, 32.0);
    
    // Corners
    float size = 32.0/2.0;
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillRect(context, CGRectMake(rect.origin.x, rect.origin.y, size, size));
    CGContextFillRect(context, CGRectMake(rect.origin.x+rect.size.width-size, rect.origin.y, size, size));
    CGContextFillRect(context, CGRectMake(rect.origin.x, rect.origin.y+rect.size.height-size, size, size));
    CGContextFillRect(context, CGRectMake(rect.origin.x+rect.size.width-size, rect.origin.y+rect.size.height-size, size, size));
}

@end
