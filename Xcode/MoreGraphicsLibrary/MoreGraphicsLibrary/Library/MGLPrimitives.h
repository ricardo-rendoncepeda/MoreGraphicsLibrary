//
//  MGLPrimitives.h
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/23/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import <GLKit/GLKVector2.h>

@interface MGLPrimitives : NSObject

@end

@interface MGLPoint : MGLPrimitives

@property (assign, nonatomic, readonly) float x;
@property (assign, nonatomic, readonly) float y;
@property (assign, nonatomic, readonly) GLKVector2 vector;

+ (MGLPoint*)pointWithX:(float)x y:(float)y;
+ (MGLPoint*)pointWithVector:(GLKVector2)v;

@end

@interface MGLLine : MGLPrimitives

@property (assign, nonatomic, readonly) MGLPoint* start;
@property (assign, nonatomic, readonly) MGLPoint* end;

+ (MGLLine*)lineWithStart:(MGLPoint*)start end:(MGLPoint*)end;

@end

@interface MGLTriangle : MGLPrimitives

@property (assign, nonatomic, readonly) MGLPoint* a;
@property (assign, nonatomic, readonly) MGLPoint* b;
@property (assign, nonatomic, readonly) MGLPoint* c;

+ (MGLTriangle*)triangleWithA:(MGLPoint*)a b:(MGLPoint*)b c:(MGLPoint*)c;

@end