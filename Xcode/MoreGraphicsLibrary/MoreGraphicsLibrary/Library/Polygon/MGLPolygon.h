//
//  MGLPolygon.h
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/24/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

@class MGLColor;
@class MGLPoint;

@interface MGLPolygon : NSObject

@property (strong, nonatomic, readwrite) MGLColor* fillColor;
@property (strong, nonatomic, readwrite) MGLColor* strokeColor;
@property (assign, nonatomic, readwrite) float strokeWidth;

- (instancetype)initWithPoint:(MGLPoint*)point inFrame:(CGRect)frame;
- (void)addPoint:(MGLPoint*)p;
- (void)fillPolygon;
- (void)strokePolygon;

@end
