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
    
    // Rect
    [self demoRect];
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

@end
