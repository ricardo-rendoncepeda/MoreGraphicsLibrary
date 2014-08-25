// FRAGMENT SHADER

// Precision
precision highp float;

// Uniforms
uniform vec2 uResolution;
uniform vec4 uCrestColor;
uniform vec4 uTroughColor;
uniform float uFrequency;
uniform float uPhase;

// Constants
const float cPi = 3.14159265359;

// Main
void main(void)
{
    vec2 center = vec2(uResolution.x/2., uResolution.y/2.);
    float radius = uResolution.x/2.;
    vec2 position = gl_FragCoord.xy - center;
    
    if (length(position) > radius)
        discard;
    
    float wave = sin((2.*cPi*(length(position)/radius)+uPhase)*uFrequency);
    wave = (wave+1.)/2.;
    vec4 gradient = mix(uCrestColor, uTroughColor, wave);
    
    gl_FragColor = gradient;
}
