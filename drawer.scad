include <config.scad>;
use <box.scad>;
use <divider.scad>;

module drawer(od, depth, height, drawer_thickness, bevel, pegs=true) {
	id = od - 2 * drawer_thickness;
	echo(id);
	difference () {
		union () {				
			difference () {
				linear_extrude(depth)
					rounded_rect(od, od, bevel);

				translate([0, 0, surface_thickness])
				linear_extrude(depth)
					rounded_rect(id, id, bevel - drawer_thickness);
			}

			if (pegs)
				linear_extrude(depth)
				pegs(drawer_thickness + peg_height + tolerance, 2 * drawer_thickness + peg_width + 2 * tolerance, od);
		}

		if (pegs)
			translate([0, 0, -1])
			linear_extrude(depth+2)
			pegs(peg_height + 2 * tolerance, peg_width + 2 * tolerance, od + 2 * tolerance);

		translate([0, height, depth/2])
			cube([od+2, od, depth + 2], true);
	}
}

%translate(-[tooth_height/2, tooth_height/2, surface_thickness])
	box(box_size - tooth_height, box_height, box_thickness, teeth);

%divider(
	box_inner, box_height - 2 * surface_thickness,
	0.9, peg_width, peg_height, tolerance,
	quarter=true
);

// Quarter drawers
*union() {
	d = (box_inner - 0.9)/2 - 2 * tolerance;
	offset = (d + 0.9 + 2 * tolerance)/2;
	for (x = [1,-1], y = [1,-1])
		translate(offset * [x, y ,0])
			drawer(d, drawer_depth, d - drawer_bevel, drawer_thickness, drawer_bevel, pegs=false);
}

// Half drawers
union() {
	offset = (drawer_od + wall_thickness + 2 * tolerance)/2;
	//for (y = [0,1])
		//translate(offset * [0, y ,0])
			drawer(drawer_od, drawer_depth, drawer_od/2 - drawer_bevel, drawer_thickness, drawer_bevel, pegs=true);
}

// Full drawer
*drawer(drawer_od, drawer_depth, drawer_height, drawer_thickness, drawer_bevel);