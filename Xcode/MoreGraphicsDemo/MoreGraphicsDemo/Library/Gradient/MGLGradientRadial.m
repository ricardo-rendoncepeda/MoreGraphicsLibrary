//
//  MGLGradientRadial.m
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/24/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGLGradientRadial.h"
#import "MGLColor.h"
#import "MGLShader.h"

#pragma mark - Shader
@interface MGLGradientRadialShader : MGLShader

// Attribute Handles
@property (assign, nonatomic, readonly) GLuint aPosition;

// Uniform Handles
@property (assign, nonatomic, readonly) GLuint uResolution;
@property (assign, nonatomic, readonly) GLuint uCrestColor;
@property (assign, nonatomic, readonly) GLuint uTroughColor;
@property (assign, nonatomic, readonly) GLuint uFrequency;
@property (assign, nonatomic, readonly) GLuint uPhase;

@end

@implementation MGLGradientRadialShader

- (instancetype)init
{
    if(self = [super initWithVertexShader:@"Gradient" fragmentShader:@"GradientRadial"])
    {
        // Attributes
        _aPosition = glGetAttribLocation(self.program, "aPosition");
        
        // Uniforms
        _uResolution = glGetUniformLocation(self.program, "uResolution");
        _uCrestColor = glGetUniformLocation(self.program, "uCrestColor");
        _uTroughColor = glGetUniformLocation(self.program, "uTroughColor");
        _uFrequency = glGetUniformLocation(self.program, "uFrequency");
        _uPhase = glGetUniformLocation(self.program, "uPhase");
    }
    return self;
}

@end

#pragma mark - Gradient
@interface MGLGradientRadial ()

@property (assign, nonatomic, readonly) CGRect rect;
@property (assign, nonatomic, readonly) CGSize resolution;
@property (strong, nonatomic, readwrite) MGLGradientRadialShader* shader;

@end

@implementation MGLGradientRadial

#pragma mark - Public
- (instancetype)initWithRect:(CGRect)rect inFrame:(CGRect)frame
{
    if(self = [super init])
    {
        _crestColor = [MGLColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _troughColor = [MGLColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _frequency = 1.0;
        _phase = 0.0;
        
        _rect = rect;
        _resolution = frame.size;
        _shader = [MGLGradientRadialShader new];
        glUseProgram(_shader.program);
    }
    return self;
}

- (void)fillGradientRadial
{
    // Uniforms
    glUniform2f(self.shader.uResolution, self.resolution.width, self.resolution.height);
    glUniform4f(self.shader.uCrestColor, self.crestColor.r, self.crestColor.g, self.crestColor.b, self.crestColor.a);
    glUniform4f(self.shader.uTroughColor, self.troughColor.r, self.troughColor.g, self.troughColor.b, self.troughColor.a);
    glUniform1f(self.shader.uFrequency, self.frequency);
    glUniform1f(self.shader.uPhase, self.phase);
    
    // Attributes
    float* vertices = [self verticesAsStrip];
    glEnableVertexAttribArray(self.shader.aPosition);
    glVertexAttribPointer(self.shader.aPosition, 2, GL_FLOAT, GL_FALSE, 0, vertices);
    
    // Draw
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glDisableVertexAttribArray(self.shader.aPosition);
    free(vertices);
}

#pragma mark - Private
- (float*)verticesAsStrip
{
    float* vertices = (float*)malloc(sizeof(float)*2*4);
    vertices[0] = _rect.origin.x;
    vertices[1] = _rect.origin.y;
    vertices[2] = _rect.origin.x+_rect.size.width;
    vertices[3] = _rect.origin.y;
    vertices[4] = _rect.origin.x;
    vertices[5] = _rect.origin.y+_rect.size.height;
    vertices[6] = _rect.origin.x+_rect.size.width;
    vertices[7] = _rect.origin.y+_rect.size.height;
    return vertices;
}

@end
