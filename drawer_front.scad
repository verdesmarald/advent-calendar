include <config.scad>;

use <box.scad>;
use <drawer.scad>;
use <handle.scad>;

od = drawer_od;
id = drawer_id;

difference() {
	union () {
		linear_extrude(surface_thickness)
			rounded_rect(od + 2 * box_thickness, od + 2 * box_thickness, box_bevel);

		difference() {
			translate([0, 0, surface_thickness])
			linear_extrude(surface_thickness)
				rounded_rect(od, od, box_inner_bevel);

			translate([0, 0, -30]) {		
				drawer(box_inner, drawer_depth, drawer_height + 2 * tolerance, drawer_thickness + 2 * tolerance, box_inner_bevel);
				linear_extrude(drawer_depth)
					pegs(2 * peg_height + 2 * tolerance, 3 * peg_width + 4 * tolerance, drawer_od);
			}
		}
	}

	translate([0, od/16, 0])
		linear_extrude(1.6, center=true)
		rounded_rect(15 + 2 * tolerance, 10 + 2 * tolerance, 2 + 2 * tolerance);

	translate([0, -od/8, -5])
		handle(15, 2, 8);
}

*translate(-[tooth_height/2, tooth_height/2, box_height])
	box(box_size - tooth_height, box_height, box_thickness, teeth);

%translate([0, 0, -drawer_depth-2])
	drawer(drawer_od, drawer_depth, drawer_height, drawer_thickness, box_inner_bevel - tolerance);