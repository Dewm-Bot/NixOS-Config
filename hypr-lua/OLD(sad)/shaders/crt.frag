#version 300 es
precision mediump float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec2 tc = v_texcoord;

    // Distance from the center
    float dx = abs(0.5 - tc.x);
    float dy = abs(0.5 - tc.y);

    // Square it to smooth the edges (Cylindrical distortion)
    dx *= dx;
    dy *= dy;

    tc.x -= 0.5;
    tc.x *= 1.0 + (dy * 0.03);
    tc.x += 0.5;

    tc.y -= 0.5;
    tc.y *= 1.0 + (dx * 0.03);
    tc.y += 0.5;

    // Get texel
    vec4 cta = texture(tex, tc);

    // Static scanline effect (removed 'time' for compatibility)
    cta.rgb += sin(tc.y * 1250.0) * 0.02;

    // Cutoff (Overscan)
    if(tc.y > 1.0 || tc.x < 0.0 || tc.x > 1.0 || tc.y < 0.0)
        cta = vec4(0.0, 0.0, 0.0, 1.0);

    fragColor = cta;
}
