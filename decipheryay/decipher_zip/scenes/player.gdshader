shader_type canvas_item;

uniform vec4 brown_color : source_color = vec4(0.7, 0.5, 0.4, 0.1); // Warm brown
uniform float tint_strength : hint_range(0.0, 1.0) = 0.1; // Base strength
uniform float contrast_exponent : hint_range(1.0, 5.0) = 2.5; // Controls light/dark contrast

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);

    // Calculate brightness
    float brightness = dot(original_color.rgb, vec3(0.299, 0.587, 0.114));

    // Apply exponent to enhance contrast: darker = more tint, lighter = less
    float adjusted_strength = tint_strength * pow(1.0 - brightness, contrast_exponent);

    // Mix the brown tint with original color
    vec3 tinted_rgb = mix(original_color.rgb, brown_color.rgb, adjusted_strength);

    COLOR = vec4(tinted_rgb, original_color.a);
}
