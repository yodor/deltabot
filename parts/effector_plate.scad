// Effector plate — laser cut. Origin = nozzle axis.
// Rebuilt parametrically from the Tinkercad SVG (reference/effector_plate.svg).
//
// The long edges face the towers; each carries one arm pair
// (arm_joint_spacing apart, effector_joint_offset from centre).

include <../config.scad>
use     <../lib/util.scad>

module effector_outline() {
    round_convex(effector_round_r) intersection() {
        tri_by_edges(effector_edge, tower_angles);
        tri_by_edges(effector_tip,  edge_angles);
    }
}

module effector_window() {
    union() {
        difference() {
            intersection() {
                tri_by_edges(effector_win_edge, tower_angles);
                tri_by_edges(effector_win_tip,  edge_angles);
            }
            for (a = tower_angles) radial(a)
                tongue(effector_tongue_w, effector_tongue_r, effector_edge);
        }
        circle(d = effector_hole_d);
    }
}

module effector_holes() {
    for (a = tower_angles) radial(a) {
        // arm-joint pair
        for (s = [-1, 1])
            translate([s * arm_joint_spacing / 2, effector_joint_offset])
                circle(d = effector_joint_hole_d);
        translate([0, effector_tongue_r]) circle(d = effector_tongue_hole_d);
        translate([0, effector_acc_r1])   circle(d = effector_acc_hole_d);
    }
    for (a = edge_angles, s = [-1, 1])
        at_polar(effector_acc_r2, a + s * effector_acc_r2_spread)
            circle(d = effector_acc_hole_d);
}

module effector_plate_2d() {
    difference() {
        effector_outline();
        effector_window();
        effector_holes();
    }
}

module effector_plate() {
    color("silver") linear_extrude(effector_t) effector_plate_2d();
}

effector_plate_2d();
