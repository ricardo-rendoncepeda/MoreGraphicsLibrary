// FRAGMENT SHADER

// Precision
precision highp float;

// Uniforms
uniform vec2 uResolution;
uniform vec4 uStartColor;
uniform vec4 uEndColor;
uniform float uAngle;

// Main
void main(void)
{
    vec2 center = vec2(uResolution.x/2., uResolution.y/2.);
    float radius = uResolution.x/2.;
    vec2 position = gl_FragCoord.xy - center;
    position.y = 1.0-position.y;
    position /= radius;
    
    float slope = 45.0/90.0;
    float weight = abs(position.x)*slope + abs(position.y)*(1.0-slope);
    vec4 gradient = mix(uStartColor, uEndColor, weight);
    
    gl_FragColor = gradient;
}
