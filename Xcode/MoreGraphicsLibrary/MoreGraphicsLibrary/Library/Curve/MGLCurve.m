//
//  MGLCurve.m
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/24/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGLCurve.h"
#import "MGLColor.h"
#import "MGLPrimitives.h"
#import "MGLShader.h"

#pragma mark - Shader
@interface MGLCurveShader : MGLShader

// Attribute Handles
@property (assign, nonatomic, readonly) GLuint aPosition;

// Uniform Handles
@property (assign, nonatomic, readonly) GLuint uResolution;
@property (assign, nonatomic, readonly) GLuint uColor;
@property (assign, nonatomic, readonly) GLuint uSize;

@end

@implementation MGLCurveShader

- (instancetype)init
{
    if(self = [super initWithVertexShader:@"Curve" fragmentShader:@"Curve"])
    {
        // Attributes
        _aPosition = glGetAttribLocation(self.program, "aPosition");
        
        // Uniforms
        _uResolution = glGetUniformLocation(self.program, "uResolution");
        _uColor = glGetUniformLocation(self.program, "uColor");
        _uSize = glGetUniformLocation(self.program, "uSize");
    }
    return self;
}

@end

#pragma mark - Curve
@interface MGLCurve ()

@property (strong, nonatomic, readwrite) NSArray* controlPoints;
@property (strong, nonatomic, readonly) MGLLine* line;
@property (assign, nonatomic, readonly) CGSize resolution;
@property (strong, nonatomic, readwrite) MGLCurveShader* shader;

@end

@implementation MGLCurve

- (instancetype)initWithLine:(MGLLine *)line inFrame:(CGRect)frame
{
    if(self = [super init])
    {
        _color = [MGLColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _segments = 1;
        _width = 1.0;
        
        _controlPoints = [NSArray new];
        _line = line;
        _resolution = frame.size;
        _shader = [MGLCurveShader new];
        glUseProgram(_shader.program);
    }
    return self;
}

- (void)bezierQuadraticWithControlPointA:(MGLPoint *)a
{self.controlPoints = @[a];}

- (void)bezierCubicWithControlPointA:(MGLPoint *)a b:(MGLPoint *)b
{self.controlPoints = @[a, b];}

- (void)bezierQuarticWithControlPointA:(MGLPoint *)a b:(MGLPoint *)b c:(MGLPoint *)c
{self.controlPoints = @[a, b, c];}

- (void)strokeBezier
{
    // Uniforms
    glUniform4f(self.shader.uColor, self.color.r, self.color.g, self.color.b, self.color.a);
    glUniform2f(self.shader.uResolution, self.resolution.width, self.resolution.height);
    
    // Attributes
    float* points = [self pointsFromBezier];
    glEnableVertexAttribArray(self.shader.aPosition);
    glVertexAttribPointer(self.shader.aPosition, 2, GL_FLOAT, GL_FALSE, 0, points);
    
    // Draw
    glLineWidth(self.width);
    glDrawArrays(GL_LINE_STRIP, 0, self.segments);
    glDisableVertexAttribArray(self.shader.aPosition);
    free(points);
}

- (void)showPoints
{
    // Uniforms
    glUniform1f(self.shader.uSize, self.width);
    glUniform4f(self.shader.uColor, 1.0-self.color.r, 1.0-self.color.g, 1.0-self.color.b, self.color.a);
    glUniform2f(self.shader.uResolution, self.resolution.width, self.resolution.height);
    
    // Attributes
    float* points = (float *)malloc(sizeof(float)*2*[self.controlPoints count]);
    for(int i=0; i<[self.controlPoints count]; i++)
    {
        MGLPoint* p = self.controlPoints[i];
        points[0+(i*2)] = p.x;
        points[1+(i*2)] = p.y;
    }
    glEnableVertexAttribArray(self.shader.aPosition);
    glVertexAttribPointer(self.shader.aPosition, 2, GL_FLOAT, GL_FALSE, 0, points);
    
    // Draw
    glDrawArrays(GL_POINTS, 0, [self.controlPoints count]);
    glDisableVertexAttribArray(self.shader.aPosition);
    free(points);
}

- (float*)pointsFromBezier
{
    float* points = (float *)malloc(sizeof(float)*2*_segments);
    for(int i=0; i<_segments; i++)
    {
        float t = ((float)(i)/(float)(_segments-1));
        MGLPoint* p;
        switch([_controlPoints count])
        {
            case 1:
                p = [self pointOnQuadraticWithP0:_line.start p1:_controlPoints[0] p2:_line.end atT:t];
                break;
                
            case 2:
                p = [self pointOnCubicWithP0:_line.start p1:_controlPoints[0] p2:_controlPoints[1] p3:_line.end atT:t];
                break;
                
            case 3:
                p = [self pointOnQuarticWithP0:_line.start p1:_controlPoints[0] p2:_controlPoints[1] p3:_controlPoints[2] p4:_line.end atT:t];
                break;
                
            default:
                p = [MGLPoint pointWithX:0.0 y:0.0];
                break;
        }
        points[0+(i*2)] = p.x;
        points[1+(i*2)] = p.y;
    }
    return points;
}

- (MGLPoint*)pointOnQuadraticWithP0:(MGLPoint*)p0 p1:(MGLPoint*)p1 p2:(MGLPoint*)p2 atT:(float)t
{
    GLKVector2 p0p1 = GLKVector2Lerp(p0.vector, p1.vector, t);
    GLKVector2 p1p2 = GLKVector2Lerp(p1.vector, p2.vector, t);
    GLKVector2 point = GLKVector2Lerp(p0p1, p1p2, t);
    return [MGLPoint pointWithVector:point];
}

- (MGLPoint*)pointOnCubicWithP0:(MGLPoint*)p0 p1:(MGLPoint*)p1 p2:(MGLPoint*)p2 p3:(MGLPoint*)p3 atT:(float)t
{
    MGLPoint* quadratic = [self pointOnQuadraticWithP0:p0 p1:p1 p2:p2 atT:t];
    GLKVector2 p0p1_p1p2 = quadratic.vector;
    GLKVector2 p1p2 = GLKVector2Lerp(p1.vector, p2.vector, t);
    GLKVector2 p2p3 = GLKVector2Lerp(p2.vector, p3.vector, t);
    GLKVector2 p1p2_p2p3 = GLKVector2Lerp(p1p2, p2p3, t);
    GLKVector2 point = GLKVector2Lerp(p0p1_p1p2, p1p2_p2p3, t);
    return [MGLPoint pointWithVector:point];
}

- (MGLPoint*)pointOnQuarticWithP0:(MGLPoint*)p0 p1:(MGLPoint*)p1 p2:(MGLPoint*)p2 p3:(MGLPoint*)p3 p4:(MGLPoint*)p4 atT:(float)t
{
    MGLPoint* cubic = [self pointOnCubicWithP0:p0 p1:p1 p2:p2 p3:p3 atT:t];
    GLKVector2 p0p1_p1p2_p1p2_p2p3 = cubic.vector;
    GLKVector2 p2p3 = GLKVector2Lerp(p2.vector, p3.vector, t);
    GLKVector2 p3p4 = GLKVector2Lerp(p3.vector, p4.vector, t);
    GLKVector2 p2p3_p3p4 = GLKVector2Lerp(p2p3, p3p4, t);
    GLKVector2 point = GLKVector2Lerp(p0p1_p1p2_p1p2_p2p3, p2p3_p3p4, t);
    return [MGLPoint pointWithVector:point];
}

@end
