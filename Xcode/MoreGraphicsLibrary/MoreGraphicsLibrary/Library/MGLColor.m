//
//  MGLColor.m
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/23/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGLColor.h"

@implementation MGLColor

- (instancetype)initWithRed:(float)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a
{
    if(self = [super init])
    {
        _r = r;
        _g = g;
        _b = b;
        _a = a;
    }
    return self;
}

+ (MGLColor *)colorWithRed:(float)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a
{return [[MGLColor alloc] initWithRed:r green:g blue:b alpha:a];}

@end
