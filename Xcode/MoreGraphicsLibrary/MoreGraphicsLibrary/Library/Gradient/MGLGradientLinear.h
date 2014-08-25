//
//  MGLGradientLinear.h
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/24/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

@class MGLColor;

@interface MGLGradientLinear : NSObject

@property (strong, nonatomic, readwrite) MGLColor* startColor;
@property (strong, nonatomic, readwrite) MGLColor* endColor;
@property (assign, nonatomic, readwrite) float angle;

- (instancetype)initWithRect:(CGRect)rect inFrame:(CGRect)frame;
- (void)fillGradientLinear;

@end
