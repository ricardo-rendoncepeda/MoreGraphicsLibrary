// FRAGMENT SHADER

// Precision
precision highp float;

// Uniforms
uniform vec4 uColor;

// Main
void main(void)
{
    gl_FragColor = uColor;
}
