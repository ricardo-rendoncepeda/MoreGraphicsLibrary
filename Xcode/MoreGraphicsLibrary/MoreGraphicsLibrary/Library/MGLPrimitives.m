//
//  MGLPrimitives.m
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/23/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGLPrimitives.h"

@implementation MGLPrimitives

@end

@implementation MGLPoint

- (instancetype)initWithX:(float)x y:(float)y
{
    if(self = [super init])
    {
        _x = x;
        _y = y;
        _vector = GLKVector2Make(x, y);
    }
    return self;
}

+ (MGLPoint *)pointWithX:(float)x y:(float)y
{return [[MGLPoint alloc] initWithX:x y:y];}

+ (MGLPoint *)pointWithVector:(GLKVector2)v
{return [[MGLPoint alloc] initWithX:v.x y:v.y];}


@end

@implementation MGLLine

- (instancetype)initWithStart:(MGLPoint*)start end:(MGLPoint*)end
{
    if(self = [super init])
    {
        _start = start;
        _end = end;
    }
    return self;
}

+ (MGLLine *)lineWithStart:(MGLPoint *)start end:(MGLPoint *)end;
{return [[MGLLine alloc] initWithStart:start end:end];}

@end

@implementation MGLTriangle

- (instancetype)initWithA:(MGLPoint*)a b:(MGLPoint*)b c:(MGLPoint*)c
{
    if(self = [super init])
    {
        _a = a;
        _b = b;
        _c = c;
    }
    return self;
}

+ (MGLTriangle *)triangleWithA:(MGLPoint *)a b:(MGLPoint *)b c:(MGLPoint *)c
{return [[MGLTriangle alloc] initWithA:a b:b c:c];}

@end