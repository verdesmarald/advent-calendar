include <config.scad>;
use <box.scad>;

%translate(-[tooth_height, tooth_height, 4]/2)
	box(box_size - tooth_height, box_height, box_thickness, teeth);

divider(
	box_inner, box_height - 2 * surface_thickness,
	wall_thickness, peg_width, peg_height, tolerance,
	quarter=true
);

module divider(length, depth, thickness, peg_width, peg_height, tolerance, quarter=false) {
	linear_extrude(depth) {
		difference() {
			union() {
				square([length - 2 * tolerance, thickness], true);
				if (quarter)
					rotate([0, 0, 90])
						square([length - 2 * tolerance, thickness], true);
				pegs(2 * peg_height, 3 * peg_width, length);
			}
			pegs(peg_height + tolerance, peg_width + 2 * tolerance, length);
		}
	}
}
