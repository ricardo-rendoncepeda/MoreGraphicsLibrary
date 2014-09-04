//
//  MGDGradientViewMG.m
//  MoreGraphicsDemo
//
//  Created by Ricardo on 8/25/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGDGradientViewMG.h"
#import "MGLHeaders.h"

@implementation MGDGradientViewMG
{
    BOOL _isAnimating;
    float _phase;
}

- (void)shadeRect:(CGRect)rect
{
    // LINEAR
//    MGLGradientLinear* mglGradientLinear = [[MGLGradientLinear alloc] initWithRect:CGRectMake(0.0, 0.0, rect.size.width, rect.size.height) inFrame:self.frame];
//    
//    mglGradientLinear.startColor = [MGLColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
//    mglGradientLinear.endColor = [MGLColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
//    mglGradientLinear.angle = 45.0;
//    [mglGradientLinear fillGradientLinear];
    
    // RADIAL
    MGLGradientRadial* mglGradientRadial = [[MGLGradientRadial alloc] initWithRect:CGRectMake(0.0, 0.0, rect.size.width, rect.size.height) inFrame:self.frame];
    
    mglGradientRadial.crestColor = [MGLColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    mglGradientRadial.troughColor = [MGLColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    mglGradientRadial.frequency = 4.0;
    mglGradientRadial.phase = _phase;
    [mglGradientRadial fillGradientRadial];
    if(!_isAnimating)
    {
        CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsShade)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        _isAnimating = YES;
    }
}

- (void)setNeedsShade
{
    [super setNeedsShade];
    
    if(_isAnimating)
        _phase += 0.01;
}

@end
