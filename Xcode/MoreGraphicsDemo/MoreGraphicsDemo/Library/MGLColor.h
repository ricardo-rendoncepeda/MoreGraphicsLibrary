//
//  MGLColor.h
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/23/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

@interface MGLColor : NSObject

@property (assign, nonatomic, readonly) float r;
@property (assign, nonatomic, readonly) float g;
@property (assign, nonatomic, readonly) float b;
@property (assign, nonatomic, readonly) float a;

+ (MGLColor*)colorWithRed:(float)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a;

@end
