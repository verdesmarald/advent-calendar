include <config.scad>;

use <box.scad>;

module drawer(od, depth, height, drawer_thickness, bevel) {
	id = od - 2 * drawer_thickness;

	difference () {
		union () {			
				difference () {
					linear_extrude(depth)
						rounded_rect(od, od, bevel);

					translate([0, 0, surface_thickness])
					linear_extrude(depth)
						rounded_rect(id, id, bevel - drawer_thickness);
				}

			linear_extrude(depth)
				pegs(2 * peg_height + tolerance, 3 * peg_width + 2 * tolerance, od);
		}

		translate([0, 0, -1])
		linear_extrude(depth+2)
			pegs(peg_height + 2 * tolerance, peg_width + 2 * tolerance, od + 2 * tolerance);

		echo(od);
		echo(height);
		translate([0, height, depth/2])
		cube([od+2, od, depth + 2], true);
	}
}


%translate(-[tooth_height/2, tooth_height/2, surface_thickness])
	box(box_size - tooth_height, box_height, box_thickness, teeth);

drawer(drawer_od, drawer_depth, drawer_height, drawer_thickness, box_inner_bevel - tolerance);