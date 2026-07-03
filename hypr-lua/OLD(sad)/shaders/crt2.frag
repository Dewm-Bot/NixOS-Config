#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

// If you don't use hyprshade, time will be 0.0
uniform float time;

#define BORDER_COLOR vec4(0.0, 0.0, 0.0, 1.0)
#define BORDER_SIZE 0.01
#define DISTORTION_AMOUNT 0.02
#define VIGNETTE_RADIUS 0.9
#define SCANLINE_FREQUENCY 1000.0

// Simplified Barrel Distortion
vec2 applyBarrelDistortion(vec2 coord, float amt) {
    vec2 v = coord * 2.0 - 1.0;
    float r = dot(v, v);
    vec2 result = v * (1.0 + r * amt);
    return 0.5 + 0.5 * result;
}

void main() {
    vec2 tc = applyBarrelDistortion(v_texcoord, DISTORTION_AMOUNT);

    // Sample the texture
    vec4 color = texture(tex, tc);

    // Simple Scanlines
    float scanline = sin(tc.y * SCANLINE_FREQUENCY) * 0.04;
    color.rgb -= scanline;

    // Vignette
    float dist = distance(v_texcoord, vec2(0.5));
    color.rgb *= smoothstep(VIGNETTE_RADIUS, VIGNETTE_RADIUS - 0.4, dist);

    // Border Cutoff
    if(tc.x < 0.0 || tc.x > 1.0 || tc.y < 0.0 || tc.y > 1.0) {
        color = BORDER_COLOR;
    }

    fragColor = vec4(color.rgb, 1.0);
}
