#version 300 es
precision mediump float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

const int bloomRadius = 5; // Lowered for performance
const float bloomIntensity = 0.3;
const float bloomThreshold = 0.6;

void main() {
    vec4 baseColor = texture(tex, v_texcoord);
    vec2 texSize = vec2(textureSize(tex, 0));
    vec2 invTexSize = 1.0 / texSize;

    vec4 bloomSum = vec4(0.0);
    float totalWeight = 0.0;

    for (int x = -bloomRadius; x <= bloomRadius; ++x) {
        for (int y = -bloomRadius; y <= bloomRadius; ++y) {
            vec2 offset = vec2(float(x), float(y)) * invTexSize;
            vec4 sampleCol = texture(tex, v_texcoord + offset);

            // Extraction
            vec4 extract = max(sampleCol - bloomThreshold, 0.0);
            float weight = 1.0 - (length(offset) / (float(bloomRadius) * invTexSize.x + 0.0001));

            bloomSum += extract * weight;
            totalWeight += weight;
        }
    }

    bloomSum = (bloomSum / totalWeight) * bloomIntensity;
    fragColor = baseColor + bloomSum;
    fragColor.a = 1.0;
}
