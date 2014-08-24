//
//  MGLPrimitives.h
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/23/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

@interface MGLPrimitives : NSObject

@end

@interface MGLPoint : MGLPrimitives

@property (assign, nonatomic, readonly) float x;
@property (assign, nonatomic, readonly) float y;

+ (MGLPoint*)pointWithX:(float)x y:(float)y;

@end

@interface MGLLine : MGLPrimitives

@property (assign, nonatomic, readonly) MGLPoint* pa;
@property (assign, nonatomic, readonly) MGLPoint* pb;

+ (MGLLine*)lineWithPointA:(MGLPoint*)pa pointB:(MGLPoint*)pb;

@end

@interface MGLTriangle : MGLPrimitives

@property (assign, nonatomic, readonly) MGLPoint* pa;
@property (assign, nonatomic, readonly) MGLPoint* pb;
@property (assign, nonatomic, readonly) MGLPoint* pc;

+ (MGLTriangle*)triangleWithPointA:(MGLPoint*)pa pointB:(MGLPoint*)pb pointC:(MGLPoint*)pc;

@end