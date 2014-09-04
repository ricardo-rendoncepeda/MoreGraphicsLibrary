//
//  MGLRect.m
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/23/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGLRect.h"
#import "MGLColor.h"
#import "MGLShader.h"

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
        _uResolution = glGetUniformLocation(self.program, "uResolution");
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

#pragma mark - Public
- (instancetype)initWithRect:(CGRect)rect inFrame:(CGRect)frame
{
    if(self = [super init])
    {
        _fillColor = [MGLColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _strokeColor = [MGLColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _cornerColor = [MGLColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        _rect = rect;
        _resolution = frame.size;
        _shader = [MGLRectShader new];
        glUseProgram(_shader.program);
    }
    return self;
}

- (void)fillRect
{
    // Uniforms
    glUniform4f(self.shader.uColor, self.fillColor.r, self.fillColor.g, self.fillColor.b, self.strokeColor.a);
    glUniform2f(self.shader.uResolution, self.resolution.width, self.resolution.height);
    
    // Attributes
    float* vertices = (float*)malloc(sizeof(float)*2*4);
    vertices[0] = _rect.origin.x;
    vertices[1] = _rect.origin.y;
    vertices[2] = _rect.origin.x+_rect.size.width;
    vertices[3] = _rect.origin.y;
    vertices[4] = _rect.origin.x;
    vertices[5] = _rect.origin.y+_rect.size.height;
    vertices[6] = _rect.origin.x+_rect.size.width;
    vertices[7] = _rect.origin.y+_rect.size.height;
    glEnableVertexAttribArray(self.shader.aPosition);
    glVertexAttribPointer(self.shader.aPosition, 2, GL_FLOAT, GL_FALSE, 0, vertices);
    
    // Draw
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glDisableVertexAttribArray(self.shader.aPosition);
    free(vertices);
}

- (void)strokeRect
{
    glUniform4f(self.shader.uColor, self.strokeColor.r, self.strokeColor.g, self.strokeColor.b, self.strokeColor.a);
    glLineWidth(self.strokeWidth);
    [self shadeVertices:[self verticesAsLoop] withMode:GL_LINE_LOOP];
}

- (void)cornerRect
{
    glUniform4f(self.shader.uColor, self.cornerColor.r, self.cornerColor.g, self.cornerColor.b, self.cornerColor.a);
    glUniform1f(self.shader.uSize, self.cornerSize);
    [self shadeVertices:[self verticesAsLoop] withMode:GL_POINTS];
}

#pragma mark - Private
- (void)shadeVertices:(float*)vertices withMode:(GLenum)mode
{
    // Uniforms
    glUniform2f(self.shader.uResolution, self.resolution.width, self.resolution.height);
    
    // Attributes
    glEnableVertexAttribArray(self.shader.aPosition);
    glVertexAttribPointer(self.shader.aPosition, 2, GL_FLOAT, GL_FALSE, 0, vertices);
    
    // Draw
    glDrawArrays(mode, 0, 4);
    glDisableVertexAttribArray(self.shader.aPosition);
    free(vertices);
}

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

- (float*)verticesAsLoop
{
    float* vertices = (float*)malloc(sizeof(float)*2*4);
    vertices[0] = _rect.origin.x;
    vertices[1] = _rect.origin.y;
    vertices[2] = _rect.origin.x+_rect.size.width;
    vertices[3] = _rect.origin.y;
    vertices[4] = _rect.origin.x+_rect.size.width;
    vertices[5] = _rect.origin.y+_rect.size.height;
    vertices[6] = _rect.origin.x;
    vertices[7] = _rect.origin.y+_rect.size.height;
    return vertices;
}

@end
