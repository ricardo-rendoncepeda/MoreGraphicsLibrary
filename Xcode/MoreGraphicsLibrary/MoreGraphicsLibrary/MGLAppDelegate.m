//
//  MGLAppDelegate.m
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/23/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGLAppDelegate.h"
#import "MGLHeaders.h"
#import "MGLTestRect.h"

@implementation MGLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // MGLTestRect
    // -----------
    MGLTestRect* mglTestRect = [[MGLTestRect alloc] initWithFrame:self.window.frame];
    [self.window addSubview:mglTestRect];
    [mglTestRect setNeedsShade];
    // -----------
    // MGLTestRect
    
    return YES;
}

@end
