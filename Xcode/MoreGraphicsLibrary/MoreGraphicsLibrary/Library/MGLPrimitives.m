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
    }
    return self;
}

+ (MGLPoint *)pointWithX:(float)x y:(float)y
{return [[MGLPoint alloc] initWithX:x y:y];}

@end

@implementation MGLLine

- (instancetype)initWithPointA:(MGLPoint*)pa pointB:(MGLPoint*)pb
{
    if(self = [super init])
    {
        _pa = pa;
        _pb = pb;
    }
    return self;
}

+ (MGLLine *)lineWithPointA:(MGLPoint *)pa pointB:(MGLPoint *)pb
{return [[MGLLine alloc] initWithPointA:pa pointB:pb];}

@end

@implementation MGLTriangle

- (instancetype)initWithPointA:(MGLPoint*)pa pointB:(MGLPoint*)pb pointC:(MGLPoint*)pc
{
    if(self = [super init])
    {
        _pa = pa;
        _pb = pb;
        _pc = pc;
    }
    return self;
}

+ (MGLTriangle *)triangleWithPointA:(MGLPoint *)pa pointB:(MGLPoint *)pb pointC:(MGLPoint *)pc
{return [[MGLTriangle alloc] initWithPointA:pa pointB:pb pointC:pc];}

@end