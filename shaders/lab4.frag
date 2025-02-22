#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

const int constraints_num = 10;

out vec4 fragColor;

uniform vec4 uTargetColor;
uniform float uConstraintsLength;
uniform vec3 uConstraints[constraints_num];

void main(){
    vec2 uv = FlutterFragCoord().xy;

    for(int i = 0; i < constraints_num; i++) {
        if(i == uConstraintsLength) break;
        if(!(uConstraints[i].x * uv.x + uConstraints[i].y * uv.y <= uConstraints[i].z)) {
            fragColor = vec4(0);
            return;
        }
    }
    fragColor = uTargetColor;
}
