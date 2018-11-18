include <config.scad>;

use <box.scad>;

%translate(-[tooth_height, tooth_height, 4]/2)
	box(s, d, thickness, teeth, "green", "blue");

tol = 0.1;
od = s - thickness*2 - tooth_height;

echo(od);

module divider() {
	linear_extrude(d-4) {
		difference() {
			union() {
				square([od - 2*tol, peg_size], true);
				rotate([0, 0, 90])
					square([od - 2*tol, peg_size], true);
				pegs(2 * peg_size, 3 * peg_size, od);
			}
			pegs(peg_size + 2*tol, peg_size + 2*tol, od);
		}
	}
}

divider();