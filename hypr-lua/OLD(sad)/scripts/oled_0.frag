#version 300 es
precision highp float;
in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;

#define OLED_PIXEL_SIZE 1.0
// The script will now inject the DIM_LEVEL here
#define DIM_LEVEL 0.2

void main(){
    vec4 originalColor = texture(tex, v_texcoord);
    vec2 fragCoord = gl_FragCoord.xy;

    float checkerX = floor(fragCoord.x / OLED_PIXEL_SIZE);
    float checkerY = floor(fragCoord.y / OLED_PIXEL_SIZE);
    bool isEvenPixel = mod(checkerX + checkerY, 2.0) == 0.0;

    // Instead of pure black, we multiply by DIM_LEVEL
    vec4 dimmedColor = vec4(originalColor.rgb * DIM_LEVEL, originalColor.a);

    #ifdef PHASE_B
    fragColor = isEvenPixel ? dimmedColor : originalColor;
    #else
    fragColor = isEvenPixel ? originalColor : dimmedColor;
    #endif
}
