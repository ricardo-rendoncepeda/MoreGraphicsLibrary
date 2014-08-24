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

@property (strong, nonatomic, readwrite) MGLColor* color;
@property (assign, nonatomic, readwrite) int segments;
@property (assign, nonatomic, readwrite) float width;

- (instancetype)initWithLine:(MGLLine*)line inFrame:(CGRect)frame;
- (void)bezierQuadraticWithControlPointA:(MGLPoint*)a;
- (void)bezierCubicWithControlPointA:(MGLPoint*)a b:(MGLPoint*)b;
- (void)bezierQuarticWithControlPointA:(MGLPoint*)a b:(MGLPoint*)b c:(MGLPoint*)c;
- (void)strokeBezier;

@end
