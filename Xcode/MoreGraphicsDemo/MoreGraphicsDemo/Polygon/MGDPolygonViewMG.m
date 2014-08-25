//
//  MGDPolygonViewMG.m
//  MoreGraphicsDemo
//
//  Created by Ricardo on 8/25/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGDPolygonViewMG.h"
#import "MGLHeaders.h"

@implementation MGDPolygonViewMG

- (void)shadeRect:(CGRect)rect
{    
    float x = CGRectGetMaxX(rect);
    float y = CGRectGetMaxY(rect);
    
    MGLPolygon* polygon = [[MGLPolygon alloc] initWithPoint:[MGLPoint pointWithX:x*0.0 y:y*0.5] inFrame:rect];
    [polygon addPoint:[MGLPoint pointWithX:x*0.5 y:y*0.0]];
    [polygon addPoint:[MGLPoint pointWithX:x*1.0 y:y*0.5]];
    [polygon addPoint:[MGLPoint pointWithX:x*0.75 y:y*1.0]];
    [polygon addPoint:[MGLPoint pointWithX:x*0.5 y:y*0.75]];
    [polygon addPoint:[MGLPoint pointWithX:x*0.25 y:y*1.0]];
    
    polygon.fillColor = [MGLColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
    [polygon fillPolygon];
    
    polygon.strokeColor = [MGLColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    polygon.strokeWidth = 4.0;
    [polygon strokePolygon];
}

@end
