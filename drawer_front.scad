include <config.scad>;

use <box.scad>;
use <drawer.scad>;
use <handle.scad>;


tol = 0.2;
od = s - thickness * 2 - tooth_height - 2 * tol;
id = od - 2 * drawer_thickness;

%rotate([180,0,0])
	translate(-[tooth_height, tooth_height, 2*d+4]/2)
	box(s, d, thickness, teeth, "green", "blue");


difference() {
	linear_extrude(2)
		rounded_rect(od + 2*thickness, od + 2*thickness, bevel);

	for (x=[1, -1], y=[1, -1])
	translate([x*od/4, y*od/4, 0]) {
		translate([0, od/16, 0])
		linear_extrude(1.6, center=true)
			rounded_rect(15 + 2*tol, 10 + 2*tol, 2);

		translate([0, -od/8, -5])
			handle(15, 2, 8);
	}
}

rotate([180,0,0])
translate([0,0,-4])
difference() {
	linear_extrude(2)
		rounded_rect(od, od, bevel - thickness);

	translate([0, 0, -d+4])
		drawer(od+2, drawer_thickness+1);
}