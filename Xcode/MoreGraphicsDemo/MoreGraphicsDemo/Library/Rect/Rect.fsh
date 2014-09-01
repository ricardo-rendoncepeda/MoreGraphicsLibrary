// FRAGMENT SHADER

// Precision
precision highp float;

// Uniforms
uniform vec4 uColor;

// Varying
//varying vec4 vColor;

// Main
void main(void)
{
    gl_FragColor = uColor;
    
//    gl_FragColor.rgb *= 0.5;
    
//    gl_FragColor = vColor;
}
