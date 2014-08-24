//
//  MGLAppDelegate.m
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/23/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGLAppDelegate.h"
#import "MGLHeaders.h"
#import "MGLTestView.h"

@implementation MGLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // MGLTestView
    // -----------
    MGLTestView* mglTestView = [[MGLTestView alloc] initWithFrame:self.window.frame];
    [self.window addSubview:mglTestView];
    [mglTestView setNeedsShade];
    // -----------
    // MGLTestView
    
    return YES;
}

@end
