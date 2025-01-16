shader_type canvas_item;

uniform sampler2D texture;             // Base texture
uniform float circle_frequency = 20.0; // Controls the density of circles
uniform float max_circle_size = 0.5;   // Controls the maximum size of the circles in shadow areas

void fragment() {
    vec2 uv = UV;
    vec4 tex_color = texture(texture, uv);

    // Calculate the intensity of the pixel (using its luminance)
    float luminance = dot(tex_color.rgb, vec3(0.299, 0.587, 0.114));

    // Determine circle size based on shadow intensity (darker means larger circles)
    float circle_size = max_circle_size * (1.0 - luminance);

    // Create grid position and center point within each cell
    vec2 grid_pos = fract(uv * circle_frequency);
    float dist_to_center = length(grid_pos - vec2(0.5));

    // Apply circular halftone pattern using smoothstep to create soft edges
    float circle_mask = smoothstep(circle_size, circle_size - 0.05, dist_to_center);

    // Blend the halftone pattern with the texture color based on the mask
    tex_color.rgb = mix(tex_color.rgb, vec3(0.0), 1.0 - circle_mask);

    COLOR = tex_color;
}
