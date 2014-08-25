//
//  MGDViewController.m
//  MoreGraphicsDemo
//
//  Created by Ricardo on 8/24/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGDViewController.h"
#import "MGDRectViewCG.h"
#import "MGDRectViewMG.h"
#import "MGDCurveViewCG.h"
#import "MGDCurveViewMG.h"
#import "MGDPolygonViewCG.h"
#import "MGDPolygonViewMG.h"
#import "MGDGradientViewCG.h"
#import "MGDGradientViewMG.h"

@interface MGDViewController ()

@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UIView* cgView;
@property (weak, nonatomic) IBOutlet UIView* mgView;

@end

@implementation MGDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self demoRect];
//    [self demoCurve];
//    [self demoPolygon];
    [self demoGradient];
}

- (void)demoRect
{
    // Title
    self.titleLabel.text = @"Rect Demo";
    
    // Core Graphics
    MGDRectViewCG* rectViewCG = [[MGDRectViewCG alloc] initWithFrame:self.cgView.bounds];
    [self.cgView addSubview:rectViewCG];
    
    // More Graphics
    MGDRectViewMG* rectViewMG = [[MGDRectViewMG alloc] initWithFrame:self.mgView.bounds];
    [self.mgView addSubview:rectViewMG];
    [rectViewMG setNeedsShade];
}

- (void)demoCurve
{
    // Title
    self.titleLabel.text = @"Curve Demo";
    
    // Core Graphics
    MGDCurveViewCG* curveViewCG = [[MGDCurveViewCG alloc] initWithFrame:self.cgView.bounds];
    [self.cgView addSubview:curveViewCG];
    
    // More Graphics
    MGDCurveViewMG* curveViewMG = [[MGDCurveViewMG alloc] initWithFrame:self.mgView.bounds];
    [self.mgView addSubview:curveViewMG];
    [curveViewMG setNeedsShade];
}

- (void)demoPolygon
{
    // Title
    self.titleLabel.text = @"Polygon Demo";
    
    // Core Graphics
    MGDPolygonViewCG* polygonViewCG = [[MGDPolygonViewCG alloc] initWithFrame:self.cgView.bounds];
    [self.cgView addSubview:polygonViewCG];
    
    // More Graphics
    MGDPolygonViewMG* polygonViewMG = [[MGDPolygonViewMG alloc] initWithFrame:self.mgView.bounds];
    [self.mgView addSubview:polygonViewMG];
    [polygonViewMG setNeedsShade];
}

- (void)demoGradient
{
    // Title
    self.titleLabel.text = @"Gradient Demo";
    
    // Core Graphics
    MGDGradientViewCG* gradientViewCG = [[MGDGradientViewCG alloc] initWithFrame:self.cgView.bounds];
    [self.cgView addSubview:gradientViewCG];
    
    // More Graphics
    MGDGradientViewMG* gradientViewMG = [[MGDGradientViewMG alloc] initWithFrame:self.mgView.bounds];
    [self.mgView addSubview:gradientViewMG];
    [gradientViewMG setNeedsShade];
}

@end
