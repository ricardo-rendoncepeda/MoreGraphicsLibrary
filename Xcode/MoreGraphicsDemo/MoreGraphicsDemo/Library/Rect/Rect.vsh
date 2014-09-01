// VERTEX SHADER

// Attributes
attribute vec2 aPosition;

// Uniforms
uniform vec2 uResolution;
uniform float uSize;

// Varying
//varying vec4 vColor;

// Main
void main(void)
{
    vec2 pos = aPosition/uResolution;
    pos.y = 1.0-pos.y;
    pos = (pos*vec2(2.0))-vec2(1.0);
    
    gl_Position = vec4(pos, 0.0, 1.0);
    gl_PointSize = uSize;
    
//    gl_Position.xy *= 0.5;
    
//    vColor = vec4(pos.x, pos.y, abs(pos.x+pos.y)/2.0, 1.0);
}
