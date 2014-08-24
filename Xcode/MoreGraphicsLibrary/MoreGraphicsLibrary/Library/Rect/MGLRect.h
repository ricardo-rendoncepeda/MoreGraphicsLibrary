//
//  MGLRect.h
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/23/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

@class MGLPrimitives;
@class MGLColor;
#import "MGLView.h"
#import "MGLShader.h"

@interface MGLRect : NSObject

@property (strong, nonatomic, readwrite) MGLColor* fillColor;
@property (strong, nonatomic, readwrite) MGLColor* strokeColor;
@property (strong, nonatomic, readwrite) MGLColor* cornerColor;
@property (assign, nonatomic, readwrite) float strokeWidth;
@property (assign, nonatomic, readwrite) float cornerSize;

- (instancetype)initWithRect:(CGRect)rect inFrame:(CGRect)frame;
- (void)fillRect;
- (void)strokeRect;
- (void)cornerRect;

@end
