shader_type spatial;
render_mode unshaded;

// Settings that appear in the Inspector under "Shader Parameters"

uniform vec4 color : source_color = vec4(1.0, 1.0, 0.4, 0.8);
uniform float pixels = 20.0;    // size of the fake pixel grid across the cursor
uniform float thickness = 2.0;  // bracket thickness, in those pixels
uniform float arm_length = 6.0; // how far each bracket arm reaches, in pixels
uniform float pulse_amount = 0.06;    // how much the cursor "breathes"
uniform float pulse_speed = 6.0;

void vertex() {
	// Grow and shrink the whole plane over time
  float pulse = 1.0 + pulse_amount * sin(TIME * pulse_speed);
  VERTEX.xz *= pulse;
}

void fragment() {
	// Which fake pixel am I in? (0 to pixels-1 on each axis)
  vec2 px = floor (UV * pixels);

  // How many pixels am I from the nearest edge, on each axis?
  vec2 edge = min(px, pixels - 1.0 - px);

  // Vertical arms: hugging the left/right edge, near the top/bottom
  bool arm_v = edge.x < thickness && edge.y < arm_length;
  // Horizontal arms: hugging the top/bottom edge, near the left/right
  bool arm_h = edge.y < thickness && edge.x < arm_length;

  if (!(arm_v || arm_h)) {
      discard; // not part of a bracket: this pixel vanishes
    }

    ALBEDO = color.rgb;
    ALPHA = color.a;
}
