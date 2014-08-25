//
//  MGLCurve.h
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/24/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

@class MGLColor;
@class MGLPoint;
@class MGLLine;

@interface MGLCurve : NSObject

@property (strong, nonatomic, readwrite) MGLColor* strokeColor;
@property (assign, nonatomic, readwrite) int segments;
@property (assign, nonatomic, readwrite) float strokeWidth;

- (instancetype)initWithLine:(MGLLine*)line inFrame:(CGRect)frame;
- (void)bezierQuadraticWithPointA:(MGLPoint*)a;
- (void)bezierCubicWithPointA:(MGLPoint*)a b:(MGLPoint*)b;
- (void)bezierQuarticWithPointA:(MGLPoint*)a b:(MGLPoint*)b c:(MGLPoint*)c;
- (void)strokeBezier;
- (void)showPoints;

@end
