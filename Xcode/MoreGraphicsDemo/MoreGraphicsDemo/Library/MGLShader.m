//
//  MGLShader.m
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/23/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

#import "MGLShader.h"

@implementation MGLShader

- (instancetype)initWithVertexShader:(NSString *)vsh fragmentShader:(NSString *)fsh
{
    if(self = [super init])
    {
        if(!vsh || !fsh)
        {
            [NSException raise:@"Shader Error" format:@"Initializer must have valid 'vsh' and 'fsh' files [vsh:%@ fsh:%@]", vsh, fsh];
            return nil;
        }
        
        // Program
        _program = [self programWithVertexShader:vsh fragmentShader:fsh];
    }
    return self;
}

- (GLuint)programWithVertexShader:(NSString*)vsh fragmentShader:(NSString*)fsh
{
    // Build shaders
    GLuint vertexShader = [self shaderWithName:vsh type:GL_VERTEX_SHADER];
    GLuint fragmentShader = [self shaderWithName:fsh type:GL_FRAGMENT_SHADER];
    
    // Create program
    GLuint programHandle = glCreateProgram();
    
    // Attach shaders
    glAttachShader(programHandle, vertexShader);
    glAttachShader(programHandle, fragmentShader);
    
    // Link program
    glLinkProgram(programHandle);
    
    // Check for errors
    GLint linkSuccess;
    glGetProgramiv(programHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE)
    {
        GLchar messages[1024];
        glGetProgramInfoLog(programHandle, sizeof(messages), 0, &messages[0]);
        NSLog(@"%@:- GLSL Program Error: %s", [self class], messages);
    }
    
    // Delete shaders
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
    
    return programHandle;
}

- (GLuint)shaderWithName:(NSString*)name type:(GLenum)type
{
    // Load the shader file
    NSString* file;
    if(type == GL_VERTEX_SHADER)
        file = [[NSBundle mainBundle] pathForResource:name ofType:@"vsh"];
    else if(type == GL_FRAGMENT_SHADER)
        file = [[NSBundle mainBundle] pathForResource:name ofType:@"fsh"];
    
    // Create the shader source
    const GLchar* source = (GLchar*)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    
    // Create the shader object
    GLuint shaderHandle = glCreateShader(type);
    
    // Load the shader source
    glShaderSource(shaderHandle, 1, &source, 0);
    
    // Compile the shader
    glCompileShader(shaderHandle);
    
    // Check for errors
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE)
    {
        GLchar messages[1024];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSLog(@"%@:- GLSL Shader Error: %s", [self class], messages);
    }
    
    return shaderHandle;
}

@end
