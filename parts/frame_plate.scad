// Frame plate — laser cut, 3 identical pieces (bottom pair + top).
// Rebuilt parametrically from the Tinkercad SVG (reference/frame_plate.svg).
//
//   frame_plate_2d()  -> 2D outline for laser export (SVG/DXF)
//   frame_plate()     -> 3D, for assembly previews

include <../config.scad>
use     <../lib/util.scad>

module frame_plate_outline() {
    hull() for (a = tower_angles)
        at_polar(frame_plate_corner_c, a) circle(r = frame_plate_corner_r);
}

// features around one tower, drawn with the tower straight up (+Y)
module frame_tower_cuts() {
    // keyed square for the vertical 2020
    translate([0, tower_ext_r]) difference() {
        square(frame_ext_hole, center = true);
        for (s = [-1, 1])
            translate([s * (frame_ext_hole / 2 - frame_ext_key_depth / 2), 0])
                square([frame_ext_key_depth + 0.01, frame_ext_key_w], center = true);
    }
    for (s = [-1, 1]) {
        translate([s * frame_ext_screw_x, frame_ext_screw_r]) circle(d = frame_ext_screw_d);
        translate([s * frame_tower_hole_x, frame_tower_hole_r]) circle(d = frame_tower_hole_d);
    }
    polygon(frame_tower_opening);
}

module frame_center_cuts() {
    circle(d = frame_center_hole_d);
    for (k = [0:5]) {
        at_polar(frame_ring1_r, 30 + 60 * k) circle(d = frame_center_hole_d);
        at_polar(frame_pass_r,  30 + 60 * k) circle(d = frame_pass_d);
    }
    for (a = tower_angles) at_polar(frame_ring2_r, a) circle(d = frame_center_hole_d);
}

module frame_plate_2d() {
    difference() {
        frame_plate_outline();
        for (a = tower_angles) radial(a) frame_tower_cuts();
        for (a = edge_angles) radial(a)
            translate([0, frame_panel_slot_r])
                square([frame_panel_slot_l, frame_panel_slot_w], center = true);
        frame_center_cuts();
    }
}

module frame_plate() {
    color("#222") linear_extrude(frame_plate_t) frame_plate_2d();
}

frame_plate_2d();
