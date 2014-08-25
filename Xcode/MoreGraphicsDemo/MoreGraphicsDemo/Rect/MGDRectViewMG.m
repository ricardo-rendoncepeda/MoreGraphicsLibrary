//
//  MGDRectViewMG.m
//  MoreGraphicsDemo
//
//  Created by Ricardo on 8/24/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGDRectViewMG.h"
#import "MGLHeaders.h"

@implementation MGDRectViewMG

- (void)shadeRect:(CGRect)rect
{
    MGLRect* mglRect = [[MGLRect alloc] initWithRect:rect inFrame:self.frame];
    
    // Fill
    mglRect.fillColor = [MGLColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    [mglRect fillRect];
    
    // Stroke
    mglRect.strokeColor = [MGLColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
    mglRect.strokeWidth = 32.0;
    [mglRect strokeRect];
    
    // Corners
    mglRect.cornerColor = [MGLColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    mglRect.cornerSize = 32.0;
    [mglRect cornerRect];
}

@end
