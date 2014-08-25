//
//  MGLGradientRadial.h
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/24/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

@class MGLColor;

@interface MGLGradientRadial : NSObject

@property (strong, nonatomic, readwrite) MGLColor* crestColor;
@property (strong, nonatomic, readwrite) MGLColor* troughColor;
@property (assign, nonatomic, readwrite) float frequency;
@property (assign, nonatomic, readwrite) float phase;

- (instancetype)initWithRect:(CGRect)rect inFrame:(CGRect)frame;
- (void)fillGradientRadial;

@end
