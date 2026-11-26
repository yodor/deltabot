// Small shared helpers. 2D unless noted.

// place children at polar (r, angle) and rotate them so local +Y points
// radially outward — lets tower features be drawn once in "tower-local" coords
module at_polar(r, a) {
    rotate(a) translate([r, 0]) children();
}
module radial(a) {
    rotate(a - 90) children();          // local +Y -> direction a
}

// regular triangle by its edge distance (inradius); edge normals at `angles`
module tri_by_edges(d, angles) {
    intersection_for(a = angles)
        rotate(a) translate([d - 2000, -1000]) square(2000);
}

// round all convex corners of children with radius r
module round_convex(r) {
    offset(r = r) offset(delta = -r) children();
}

// slot / tongue: width w, from radius r0 (rounded end, centred) to r1 (square)
module tongue(w, r0, r1) {
    hull() {
        translate([0, r0]) circle(d = w);
        translate([-w / 2, r0]) square([w, r1 - r0]);
    }
}
