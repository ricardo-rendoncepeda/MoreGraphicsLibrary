//
//  MGLGradientLinear.m
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/24/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGLGradientLinear.h"
#import "MGLColor.h"
#import "MGLShader.h"

#pragma mark - Shader
@interface MGLGradientLinearShader : MGLShader

// Attribute Handles
@property (assign, nonatomic, readonly) GLuint aPosition;

// Uniform Handles
@property (assign, nonatomic, readonly) GLuint uResolution;
@property (assign, nonatomic, readonly) GLuint uStartColor;
@property (assign, nonatomic, readonly) GLuint uEndColor;
@property (assign, nonatomic, readonly) GLuint uAngle;

@end

@implementation MGLGradientLinearShader

- (instancetype)init
{
    if(self = [super initWithVertexShader:@"Gradient" fragmentShader:@"GradientLinear"])
    {
        // Attributes
        _aPosition = glGetAttribLocation(self.program, "aPosition");
        
        // Uniforms
        _uResolution = glGetUniformLocation(self.program, "uResolution");
        _uStartColor = glGetUniformLocation(self.program, "uStartColor");
        _uEndColor = glGetUniformLocation(self.program, "uEndColor");
        _uAngle = glGetUniformLocation(self.program, "uAngle");
    }
    return self;
}

@end

#pragma mark - Gradient
@interface MGLGradientLinear ()

@property (assign, nonatomic, readonly) CGRect rect;
@property (assign, nonatomic, readonly) CGSize resolution;
@property (strong, nonatomic, readwrite) MGLGradientLinearShader* shader;

@end

@implementation MGLGradientLinear

#pragma mark - Public
- (instancetype)initWithRect:(CGRect)rect inFrame:(CGRect)frame
{
    if(self = [super init])
    {
        _startColor = [MGLColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _endColor = [MGLColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _angle = 0.0;
        
        _rect = rect;
        _resolution = frame.size;
        _shader = [MGLGradientLinearShader new];
        glUseProgram(_shader.program);
    }
    return self;
}

- (void)fillGradientLinear
{
    // Uniforms
    glUniform2f(self.shader.uResolution, self.resolution.width, self.resolution.height);
    glUniform4f(self.shader.uStartColor, self.startColor.r, self.startColor.g, self.startColor.b, self.startColor.a);
    glUniform4f(self.shader.uEndColor, self.endColor.r, self.endColor.g, self.endColor.b, self.endColor.a);
    glUniform1f(self.shader.uAngle, self.angle);
    
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
