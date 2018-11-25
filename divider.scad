include <config.scad>;
use <box.scad>;


%translate(-[tooth_height, tooth_height, 4]/2)
	box(box_size - tooth_height, box_height, box_thickness, teeth);

divider(
	box_inner, (box_height - 2 * surface_thickness)/1,
	0.9, peg_width, peg_height, tolerance,
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
				pegs(thickness + peg_height + tolerance, 2 * thickness + peg_width + 2 * tolerance, length - 2 * tolerance, quarter=quarter);
			}
			pegs(peg_height + tolerance, peg_width + 2 * tolerance, length - 2 * tolerance);
		}
	}
}
