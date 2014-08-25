//
//  MGLPolygon.m
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/24/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGLPolygon.h"
#import "MGLColor.h"
#import "MGLPrimitives.h"
#import "MGLShader.h"
#import <GLKit/GLKVector3.h>

#pragma mark - Shader
@interface MGLPolygonShader : MGLShader

// Attribute Handles
@property (assign, nonatomic, readonly) GLuint aPosition;

// Uniform Handles
@property (assign, nonatomic, readonly) GLuint uResolution;
@property (assign, nonatomic, readonly) GLuint uColor;

@end

@implementation MGLPolygonShader

- (instancetype)init
{
    if(self = [super initWithVertexShader:@"Polygon" fragmentShader:@"Polygon"])
    {
        // Attributes
        _aPosition = glGetAttribLocation(self.program, "aPosition");
        
        // Uniforms
        _uResolution = glGetUniformLocation(self.program, "uResolution");
        _uColor = glGetUniformLocation(self.program, "uColor");
    }
    return self;
}

@end

#pragma mark - Polygon
@interface MGLPolygon ()

@property (strong, nonatomic, readonly) NSMutableArray* points;
@property (strong, nonatomic, readonly) NSMutableArray* triangles;
@property (assign, nonatomic, readonly) CGSize resolution;
@property (strong, nonatomic, readwrite) MGLPolygonShader* shader;

@end

@implementation MGLPolygon

#pragma mark - Public
- (instancetype)initWithPoint:(MGLPoint *)point inFrame:(CGRect)frame
{
    if(self = [super init])
    {
        _fillColor = [MGLColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _strokeColor = [MGLColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _strokeWidth = 1.0;
        
        _points = [NSMutableArray new];
        _triangles = [NSMutableArray new];
        _resolution = frame.size;
        _shader = [MGLPolygonShader new];
        glUseProgram(_shader.program);
        
        [_points addObject:point];
    }
    return self;
}

- (void)addPoint:(MGLPoint *)p
{
    [self.points addObject:p];
}

- (void)fillPolygon
{
    glUniform4f(self.shader.uColor, self.fillColor.r, self.fillColor.g, self.fillColor.b, self.fillColor.a);
    [self shadeVertices:[self verticesAsTriangles] withMode:GL_TRIANGLES count:[self.triangles count]*3];
}

- (void)strokePolygon
{
    glLineWidth(self.strokeWidth);
    glUniform4f(self.shader.uColor, self.strokeColor.r, self.strokeColor.g, self.strokeColor.b, self.strokeColor.a);
    [self shadeVertices:[self verticesAsPoints] withMode:GL_LINE_LOOP count:[self.points count]];
}

#pragma mark - Private
- (void)shadeVertices:(float*)vertices withMode:(GLenum)mode count:(int)count
{
    // Uniforms
    glUniform2f(self.shader.uResolution, self.resolution.width, self.resolution.height);
    
    // Attributes
    glEnableVertexAttribArray(self.shader.aPosition);
    glVertexAttribPointer(self.shader.aPosition, 2, GL_FLOAT, GL_FALSE, 0, vertices);
    
    // Draw
    glDrawArrays(mode, 0, count);
    glDisableVertexAttribArray(self.shader.aPosition);
    free(vertices);
}

- (float*)verticesAsPoints
{
    float* vertices = (float *)malloc(sizeof(float)*2*[self.points count]);
    for(int i=0; i<[self.points count]; i++)
    {
        MGLPoint* p = self.points[i];
        vertices[0+(i*2)] = p.x;
        vertices[1+(i*2)] = p.y;
    }
    return vertices;
}

- (float*)verticesAsTriangles
{
    [self triangulateByEarClipping];
    
    float* vertices = (float *)malloc(sizeof(float)*2*3*[self.triangles count]);
    for(int i=0; i<[self.triangles count]; i++)
    {
        MGLTriangle* t = self.triangles[i];
        vertices[0+(i*2*3)] = t.a.x;
        vertices[1+(i*2*3)] = t.a.y;
        vertices[2+(i*2*3)] = t.b.x;
        vertices[3+(i*2*3)] = t.b.y;
        vertices[4+(i*2*3)] = t.c.x;
        vertices[5+(i*2*3)] = t.c.y;
    }
    return vertices;
}

- (void)triangulateByEarClipping
{
    NSMutableArray* pointsCopy = [NSMutableArray arrayWithArray:self.points];
    
    MGLPoint* current = pointsCopy[0];
    while([pointsCopy count] > 3)
    {
        MGLTriangle* triangle = [self triangleForPoint:current inPoints:pointsCopy];
        BOOL ear = YES;
        for(MGLPoint* point in pointsCopy)
        {
            if([self triangle:triangle containsPoint:point])
            {
                ear = NO;
                break;
            }
        }
        if(ear)
        {
            if([self convexTriangle:triangle])
            {
                [self.triangles addObject:triangle];
                [pointsCopy removeObject:triangle.b];
            }
        }
        current = triangle.c;
    }
    
    if([pointsCopy count] == 3)
        [self.triangles addObject:[MGLTriangle triangleWithA:pointsCopy[0] b:pointsCopy[1] c:pointsCopy[2]]];
}

- (MGLTriangle*)triangleForPoint:(MGLPoint*)point inPoints:(NSMutableArray*)points
{
    int index = [points indexOfObject:point];
    MGLPoint* previous = ((index-1)>=0) ? points[index-1] : [points lastObject];
    MGLPoint* next = ((index+1)<[points count]) ? points[index+1] : [points firstObject];
    return [MGLTriangle triangleWithA:previous b:point c:next];
}

- (BOOL)triangle:(MGLTriangle*)t containsPoint:(MGLPoint*)p
{
    if((p == t.a) || (p == t.b) || (p == t.c))
        return NO;
    
    GLKVector2 v0 = GLKVector2Subtract(t.c.vector, t.a.vector);
    GLKVector2 v1 = GLKVector2Subtract(t.b.vector, t.a.vector);
    GLKVector2 v2 = GLKVector2Subtract(p.vector, t.a.vector);
    
    float dot00 = GLKVector2DotProduct(v0, v0);
    float dot01 = GLKVector2DotProduct(v0, v1);
    float dot02 = GLKVector2DotProduct(v0, v2);
    float dot11 = GLKVector2DotProduct(v1, v1);
    float dot12 = GLKVector2DotProduct(v1, v2);
    
    float invDenom = 1.0 / (dot00*dot11 - dot01*dot01);
    float u = (dot11*dot02 - dot01*dot12) * invDenom;
    float v = (dot00*dot12 - dot01*dot02) * invDenom;
    
    return ((u>=0.0) && (v>=0.0) && (u+v<1.0));
}

- (BOOL)convexTriangle:(MGLTriangle*)t
{
    GLKVector2 va = GLKVector2Subtract(t.a.vector, t.b.vector);
    GLKVector2 vc = GLKVector2Subtract(t.c.vector, t.b.vector);
    GLKVector3 cross = GLKVector3CrossProduct(GLKVector3Make(va.x, va.y, 0.0), GLKVector3Make(vc.x, vc.y, 0.0));
    return (cross.z<0.0);
}

@end
