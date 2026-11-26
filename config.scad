// =============================================================================
// deltabot — global configuration
// Every part includes this file. Change a value here and all parts follow.
//
// Coordinate convention
//   Origin  = machine centre (nozzle axis at X0 Y0 when homed to centre)
//   Units   = mm
//   Towers  = Klipper naming: A front-left (210°), B front-right (330°),
//             C rear (90°). Angles measured CCW from +X.
// =============================================================================

$fa = 2;      // circle resolution for preview / export
$fs = 0.2;

// ---------------------------------------------------------------- towers ----
tower_angles = [210, 330, 90];          // A, B, C
function tower_dir(i) = tower_angles[i];
// directions halfway between towers (the plate edges / effector tips)
edge_angles  = [for (a = tower_angles) a + 180];

// ------------------------------------------------------- frame extrusion ----
extrusion        = 20;                   // 2020 vertical
tower_ext_r      = 193.5;                // plate centre -> vertical extrusion centre

// ---------------------------------------------------- frame plate (laser) ---
// One design, cut 3x: bottom pair + top.
frame_plate_t            = 5;
frame_plate_corner_r     = 30;           // outer corner radius
frame_plate_corner_c     = 183.24;       // centre -> corner-arc centre
//   -> straight edge distance from centre = corner_c/2 + corner_r = 121.62

// keyed square hole the vertical extrusion passes through
frame_ext_hole           = 20.1;
frame_ext_key_w          = 6;            // keys engage the 2020 T-slots
frame_ext_key_depth      = 2.5;
frame_ext_screw_d        = 4;            // M4 clearance, pair beside extrusion
frame_ext_screw_x        = 18;           //   +/- offset across the tower
frame_ext_screw_r        = 194;          //   radial position

// opening inboard of each tower (carriage / belt / motor clearance)
// polygon in tower-local coords: X across tower, Y radial (outward)
frame_tower_opening = [
    [-21.0, 156.76], [ 21.0, 156.76], [ 21.0, 163.0],
    [ 17.844, 176.532], [ 9.233, 179.498],
    [ -9.233, 179.498], [-17.844, 176.532], [-21.0, 163.0]
];
frame_tower_hole_d       = 8.08;         // pair of 8 mm holes beside opening
frame_tower_hole_x       = 30;
frame_tower_hole_r       = 169.35;

// side panel slots (one per edge, between towers)
frame_panel_slot_w       = 4;            // panel material thickness + gap
frame_panel_slot_l       = 241;
frame_panel_slot_r       = 111.61;       // centre -> slot centreline

// centre field
frame_center_hole_d      = 3;
frame_ring1_r            = 66;           // 6x M3 @ 30°+60°k
frame_ring2_r            = 105;          // 3x M3 on tower directions
frame_pass_d             = 20;           // 6x 20 mm pass-throughs
frame_pass_r             = 35;           //   @ 30°+60°k

// ------------------------------------------------- effector plate (laser) ---
effector_t               = 4;
effector_edge            = 34.806;       // centre -> long edge (faces tower)
effector_tip             = 50.5;         // centre -> truncated tip flat
effector_round_r         = 4;            // outer corner rounding

// arm joints — pair per tower, on the edge facing it
arm_joint_spacing        = 70;           // must match carriage spacing
effector_joint_offset    = 27.703;       // centre -> joint line (Klipper: part of delta_radius calc)
effector_joint_hole_d    = 2.91;         // ball-stud screw (tapped M3?)

// hotend opening
effector_hole_d          = 26;           // central clearance
effector_win_edge        = 22.806;       // inner cut-out: edge distance
effector_win_tip         = 38.5;         //                tip flat distance
effector_tongue_w        = 12;           // tongues reaching into the cut-out
effector_tongue_r        = 17;           //   centre of rounded end = screw
effector_tongue_hole_d   = 2.905;        //   hotend mount screw (tapped M3?)

// accessory mounting holes
effector_acc_r1          = 28.807;       // 3x on tower directions
effector_acc_r2          = 33.71;        // 6x, 3 mirrored pairs
effector_acc_r2_spread   = 28.725;       //   +/- deg from tip direction
effector_acc_hole_d      = 3;
