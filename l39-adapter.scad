// l39-adapter.scad
// Parametric Leica L39 (LTM) to variable hole knurled tapered adapter
// Uses: rcolyer/threads-scad for threads, knurled-openscad for knurling
// User can set: hole_diameter, wall_thickness, adapter_length, knurl_height, knurl_pitch

// =====================
// Lens Parameters
// =====================
include <lenses/nikon-fun_touch_4-29mm-f4.5.scad>;

// =====================
// User Parameters
// =====================
knurl_diam = 47.37;           // mm, diameter of knurled ring
l39_thread_length = 4.32; // mm, total thread length
knurl_width = 2;              // mm, width of each knurl (smaller = finer)
knurl_height_param = 2;     // mm, height of each knurl (smaller = finer)
knurl_depth = 1.5;             // mm, depth of each knurl
knurl_bevel = 1.3;              // mm, flat face (no bevel)
cone_outer_diam = 38.5;       // mm, diameter at front face of cone

// Thread best-practice parameters
l39_outer_diam = 39;          // mm, nominal L39 thread outer diameter
l39_pitch = 0.977;            // mm (26 tpi)
l39_tooth_angle = 30;
l39_thread_outer_diam_print = l39_outer_diam - 0.19; // actual printed outer diameter
lens_cut_diam = l39_outer_diam - 10; // mm, user-specified inner diameter for thread cutout (for lens seating)
lens_extrude_diam = lens_hole_diam + 5; // mm, user-specified inner diameter for thread cutout (for lens seating)

// =====================
// Derived Parameters
// =====================
thread_top_z = knurl_height + l39_thread_length;
lens_mount_z = lens_offset; // Mounting face (top of lens mounting hole)
lens_hole_top_z = lens_mount_z + lens_cyl_depth;

// =====================
// Libraries
// =====================
// Uncomment and set path to libraries as needed
use <libs/threads.scad>;
use <libs/knurled.scad>;

// =====================
// Main Adapter Module
// =====================

module l39_adapter() {
    difference() {
        union() {
            // 1. Knurled ring (front, large diameter)
            // Knurled ring (optimize knurl_width/height/segments for speed if possible)
            knurled_cylinder(
                diameter=knurl_diam,
                height=knurl_height,
                knurl_width=knurl_width, // Consider increasing for fewer knurls
                knurl_height=knurl_height_param,
                knurl_depth=knurl_depth,
                bevel=knurl_bevel
            );
            // 2. Threaded section (solid core and shell)
            // Threaded section (optimize thread quality for speed if possible)
            translate([0,0,knurl_height])
                ScrewThread(
                    outer_diam=l39_thread_outer_diam_print,
                    height=l39_thread_length,
                    pitch=l39_pitch,
                    tooth_angle=l39_tooth_angle
                );
            // 3. Support cylinder if mounting face is above thread section
            if (lens_offset + lens_cyl_depth > thread_top_z) {
                translate([0,0,thread_top_z])
                    // Lower $fn for faster rendering
                    cylinder(h=(lens_offset + lens_cyl_depth) - thread_top_z, d=lens_extrude_diam, $fn=48);
            }
        }

// Subtraction logic
if (lens_offset == 0) {
    // Hole from front face to lens_cyl_depth
    translate([0,0,0])
        cylinder(h=lens_cyl_depth, d=lens_hole_diam, $fn=120);
    // If lens_cyl_depth < thread_top_z, subtract cylinder up to thread_top_z
    if (lens_cyl_depth < thread_top_z) {
        translate([0,0,lens_cyl_depth])
            // Lower $fn for faster rendering
            cylinder(h=thread_top_z - lens_cyl_depth, d=lens_cut_diam, $fn=48);
    }
} else {
    // Front geometry logic (always from bottom/front face z=0)
    if (lens_offset > 0) {
        // Cone from z=0 (large) to z=-lens_offset (small)
        translate([0,0,-lens_offset])
            // Lower $fn for faster rendering
            cylinder(h=lens_offset, d1=cone_outer_diam, d2=lens_hole_diam, $fn=48);
        // Lens hole from z=-lens_offset up by lens_cyl_depth
        translate([0,0,-lens_offset])
            cylinder(h=lens_cyl_depth, d=lens_hole_diam, $fn=120);
    } else if (lens_offset < 0) {
        // Negative cone from front face to mounting face (z=0 to z=-lens_offset)
        translate([0,0,0])
            // Lower $fn for faster rendering
            cylinder(h=-lens_offset, d1=cone_outer_diam, d2=lens_hole_diam, $fn=48);
        // Lens hole from z=lens_offset up by lens_cyl_depth
        translate([0,0,-lens_offset])
            cylinder(h=lens_cyl_depth, d=lens_hole_diam, $fn=120);
    }
    // If top of lens hole < thread_top_z, subtract cylinder up to thread_top_z
    lens_hole_top = -lens_offset + lens_cyl_depth;
    if (lens_hole_top < thread_top_z) {
        translate([0,0,lens_hole_top])
            // Lower $fn for faster rendering
            cylinder(h=thread_top_z - lens_hole_top, d=lens_cut_diam, $fn=48);
    }
}
    }
}

// =====================
// Preview
// =====================
l39_adapter();

// =====================
// Notes
// =====================
// - For threads, download and use rcolyer/threads-scad: https://github.com/rcolyer/threads-scad
// - For knurling, download and use knurled-openscad: https://github.com/smkent/knurled-openscad
// - Uncomment use<> lines and knurl/thread code as needed
// - All key dimensions are parametric
