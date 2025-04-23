// l39-thread.scad
// Minimal test: generates only the Leica L39 thread for print/fit testing
// Requires: rcolyer/threads-scad (https://github.com/rcolyer/threads-scad)

// Thread parameters (copied from l39-adapter.scad)
l39_outer_diam = 39;          // mm, nominal L39 thread outer diameter
l39_pitch = 0.977;            // mm (26 tpi)
l39_tooth_angle = 30;
l39_thread_outer_diam_print = l39_outer_diam - 0.2; // actual printed outer diameter
l39_thread_length = 4.32;     // mm, total thread length

// Library
use <libs/threads.scad>;

// Minimal thread test
ScrewThread(
    outer_diam=l39_thread_outer_diam_print,
    height=l39_thread_length,
    pitch=l39_pitch,
    tooth_angle=l39_tooth_angle
);
