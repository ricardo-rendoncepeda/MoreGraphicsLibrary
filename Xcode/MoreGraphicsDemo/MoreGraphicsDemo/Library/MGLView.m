//
//  MGLView.m
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/23/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGLView.h"
#import "MGLRect.h"
#import "MGLColor.h"

@interface MGLView ()

@property (assign, nonatomic, readonly) CGRect rect;
@property (assign, nonatomic, readonly) GLuint colorBuffer;
@property (assign, nonatomic, readonly) GLuint frameBuffer;

@end

@implementation MGLView

+ (Class)layerClass
{
    // EAGL = Embedded Apple GL
    return [CAEAGLLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _rect = frame;
        
        // Layer
        _MGLlayer = (CAEAGLLayer*)self.layer;
        
        // Context
        _MGLcontext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        [EAGLContext setCurrentContext:_MGLcontext];
        
        // OpenGL ES
        glClearColor(0.0, 0.0, 0.0, 1.0);
        glViewport(0, 0, frame.size.width, frame.size.height);
        
        // Buffers
        glGenRenderbuffers(1, &_colorBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, _colorBuffer);
        [_MGLcontext renderbufferStorage:GL_RENDERBUFFER fromDrawable:_MGLlayer];
    
        glGenFramebuffers(1, &_frameBuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorBuffer);

    }
    return self;
}

- (void)shadeRect:(CGRect)rect
{
}

- (void)setNeedsShade
{
    // Clear display and present updated frame
    glClear(GL_COLOR_BUFFER_BIT);
    [self shadeRect:self.rect];
    [_MGLcontext presentRenderbuffer:GL_RENDERBUFFER];
}

@end
