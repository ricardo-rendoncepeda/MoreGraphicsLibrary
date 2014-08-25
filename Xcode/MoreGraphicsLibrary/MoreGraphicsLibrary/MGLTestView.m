//
//  MGLTestView.m
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/24/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGLTestView.h"
#import "MGLHeaders.h"

@implementation MGLTestView

- (void)shadeRect:(CGRect)rect
{
//    [self testRectWithRect:rect];
//    [self testCurveWithRect:rect];
    [self testPolygonWithRect:rect];
}

- (void)testRectWithRect:(CGRect)rect
{
    MGLRect* mglRect = [[MGLRect alloc] initWithRect:rect inFrame:self.frame];
    
    mglRect.fillColor = [MGLColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    [mglRect fillRect];
    
    mglRect.strokeColor = [MGLColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
    mglRect.strokeWidth = 16.0;
    [mglRect strokeRect];
    
    mglRect.cornerColor = [MGLColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    mglRect.cornerSize = 32.0;
    [mglRect cornerRect];
}

- (void)testCurveWithRect:(CGRect)rect
{
    MGLPoint* start = [MGLPoint pointWithX:0.0 y:0.0];
    MGLPoint* a = [MGLPoint pointWithX:100.0 y:200.0];
    MGLPoint* b = [MGLPoint pointWithX:500.0 y:800.0];
    MGLPoint* c = [MGLPoint pointWithX:600.0 y:400.0];
    MGLPoint* end = [MGLPoint pointWithX:400.0 y:200.0];
    
    MGLCurve* mglCurve = [[MGLCurve alloc] initWithLine:[MGLLine lineWithStart:start end:end] inFrame:self.frame];
    
    mglCurve.segments = 50;
    mglCurve.strokeWidth = 8.0;
    mglCurve.strokeColor = [MGLColor colorWithRed:0.75 green:0.50 blue:0.25 alpha:1.0];
    
    [mglCurve bezierQuarticWithPointA:a b:b c:c];
    [mglCurve strokeBezier];
    [mglCurve showPoints];
}

- (void)testPolygonWithRect:(CGRect)rect
{
    MGLPolygon* mglPolygon = [[MGLPolygon alloc] initWithPoint:[MGLPoint pointWithX:0.0 y:100.0] inFrame:self.frame];
    
    [mglPolygon addPoint:[MGLPoint pointWithX:60.0 y:0.0]];
    [mglPolygon addPoint:[MGLPoint pointWithX:100.0 y:80.0]];
    [mglPolygon addPoint:[MGLPoint pointWithX:140.0 y:40.0]];
    [mglPolygon addPoint:[MGLPoint pointWithX:200.0 y:140.0]];
    [mglPolygon addPoint:[MGLPoint pointWithX:140.0 y:120.0]];
    [mglPolygon addPoint:[MGLPoint pointWithX:120.0 y:200.0]];
    [mglPolygon addPoint:[MGLPoint pointWithX:80.0 y:60.0]];
    [mglPolygon addPoint:[MGLPoint pointWithX:20.0 y:120.0]];
    [mglPolygon addPoint:[MGLPoint pointWithX:40.0 y:180.0]];
    
    mglPolygon.fillColor = [MGLColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0];
    [mglPolygon fillPolygon];
    
    mglPolygon.strokeColor = [MGLColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    mglPolygon.strokeWidth = 4.0;
    [mglPolygon strokePolygon];
}

@end
