//
//  MGLRect.m
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/23/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGLRect.h"
#import "MGLPrimitives.h"
#import "MGLColor.h"
#import "MGLShader.h"
#import "MGLView.h"

#pragma mark - Shader
@interface MGLRectShader : MGLShader

// Attribute Handles
@property (assign, nonatomic, readonly) GLuint aPosition;

// Uniform Handles
@property (assign, nonatomic, readonly) GLuint uResolution;
@property (assign, nonatomic, readonly) GLuint uSize;
@property (assign, nonatomic, readonly) GLuint uColor;

@end

@implementation MGLRectShader

- (instancetype)init
{
    if(self = [super initWithVertexShader:@"Rect" fragmentShader:@"Rect"])
    {
        // Attributes
        _aPosition = glGetAttribLocation(self.program, "aPosition");
        
        // Uniforms
        _uSize = glGetUniformLocation(self.program, "uSize");
        _uColor = glGetUniformLocation(self.program, "uColor");
    }
    return self;
}

@end

#pragma mark - Rect
@interface MGLRect ()

@property (assign, nonatomic, readonly) CGRect rect;
@property (assign, nonatomic, readonly) CGSize resolution;
@property (strong, nonatomic, readwrite) MGLRectShader* shader;

@end

@implementation MGLRect

- (instancetype)initWithRect:(CGRect)rect inFrame:(CGRect)frame
{
    if(self = [super init])
    {
        _rect = rect;
        _resolution = frame.size;
        _fillColor = [MGLColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _strokeColor = [MGLColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _cornerColor = [MGLColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _resolution = frame.size;
        
        _shader = [MGLRectShader new];
        glUseProgram(_shader.program);
    }
    return self;
}

- (void)fillRect
{
    // Points
    float* points = [self rectFill];
    
    // Uniforms
    glUniform2f(self.shader.uResolution, self.resolution.width, self.resolution.height);
    glUniform4f(self.shader.uColor, self.fillColor.r, self.fillColor.g, self.fillColor.b, self.strokeColor.a);
    
    // Attributes
    glEnableVertexAttribArray(self.shader.aPosition);
    glVertexAttribPointer(self.shader.aPosition, 2, GL_FLOAT, GL_FALSE, 0, points);
    
    // Draw
    glLineWidth(16.0);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glDisableVertexAttribArray(self.shader.aPosition);
    free(points);
}

- (void)strokeRect
{
    // Points
    float* points = [self rectCorner];
    
    // Uniforms
    glUniform2f(self.shader.uResolution, self.resolution.width, self.resolution.height);
    glUniform4f(self.shader.uColor, self.strokeColor.r, self.strokeColor.g, self.strokeColor.b, self.strokeColor.a);
    
    // Attributes
    glEnableVertexAttribArray(self.shader.aPosition);
    glVertexAttribPointer(self.shader.aPosition, 2, GL_FLOAT, GL_FALSE, 0, points);
    
    // Draw
    glLineWidth(self.strokeWidth);
    glDrawArrays(GL_LINE_LOOP, 0, 4);
    glDisableVertexAttribArray(self.shader.aPosition);
    free(points);
}

- (void)cornerRect
{
    // Points
    float* points = [self rectStroke];
    
    // Uniforms
    glUniform1f(self.shader.uSize, self.cornerSize);
    glUniform2f(self.shader.uResolution, self.resolution.width, self.resolution.height);
    glUniform4f(self.shader.uColor, self.cornerColor.r, self.cornerColor.g, self.cornerColor.b, self.cornerColor.a);
    
    // Attributes
    glEnableVertexAttribArray(self.shader.aPosition);
    glVertexAttribPointer(self.shader.aPosition, 2, GL_FLOAT, GL_FALSE, 0, points);
    
    // Draw
    glDrawArrays(GL_POINTS, 0, 4);
    glDisableVertexAttribArray(self.shader.aPosition);
    free(points);
}

- (float*)rectCorner
{
    float* points = (float*)malloc(sizeof(float)*2*4);
    points[0] = _rect.origin.x;
    points[1] = _rect.origin.y;
    points[2] = _rect.size.width;
    points[3] = _rect.origin.y;
    points[4] = _rect.size.width;
    points[5] = _rect.size.height;
    points[6] = _rect.origin.x;
    points[7] = _rect.size.height;
    return points;
}

- (float*)rectStroke
{
    float* points = (float*)malloc(sizeof(float)*2*4);
    points[0] = _rect.origin.x;
    points[1] = _rect.origin.y;
    points[2] = _rect.size.width;
    points[3] = _rect.origin.y;
    points[4] = _rect.size.width;
    points[5] = _rect.size.height;
    points[6] = _rect.origin.x;
    points[7] = _rect.size.height;
    return points;
}

- (float*)rectFill
{
    float* points = (float*)malloc(sizeof(float)*2*4);
    points[0] = _rect.origin.x;
    points[1] = _rect.origin.y;
    points[2] = _rect.size.width;
    points[3] = _rect.origin.y;
    points[4] = _rect.origin.x;
    points[5] = _rect.size.height;
    points[6] = _rect.size.width;
    points[7] = _rect.size.height;
    return points;
}

@end
