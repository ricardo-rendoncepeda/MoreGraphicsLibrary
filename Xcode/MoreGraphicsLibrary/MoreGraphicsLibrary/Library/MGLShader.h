//
//  MGLShader.h
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/23/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

@interface MGLShader : NSObject

// Program Handle
@property (assign, nonatomic, readonly) GLuint program;

// Instance Methods
- (instancetype)initWithVertexShader:(NSString*)vsh fragmentShader:(NSString*)fsh;

@end
