#version 300 es
precision highp float;
in vec2 v_texcoord;
out vec4 fragColor;
uniform sampler2D tex;
void main(){
    vec4 orig = texture(tex, v_texcoord);
    float chk = mod(floor(gl_FragCoord.x) + floor(gl_FragCoord.y), 2.0);
    vec4 dimCol = vec4(orig.rgb * 0.0, orig.a);
    if (0 == 0) { fragColor = (chk == 0.0) ? orig : dimCol; }
    else { fragColor = (chk == 0.0) ? dimCol : orig; }
}
