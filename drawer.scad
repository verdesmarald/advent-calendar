include <config.scad>;

use <box.scad>;

%translate(-[tooth_height, tooth_height, 4]/2)
	box(s, d, thickness, teeth, "green", "blue");

tol = 0.2;
od = s - thickness*2 - tooth_height - 2*tol;

echo(od);


module drawer(od, drawer_thickness) {
	difference () {
		union () {
			linear_extrude(d-2, false)
			difference () {
				rounded_rect(od, od, bevel - thickness);
				rounded_rect(od-2*drawer_thickness, od-2*drawer_thickness, bevel - thickness - drawer_thickness);
			}
			linear_extrude(d-4, false)
				pegs(2 * peg_size, 3 * peg_size, od);
			linear_extrude(2, false)
				rounded_rect(od-2*drawer_thickness, od-2*drawer_thickness, bevel - thickness - drawer_thickness);
		}

		translate([0, 0, -1])
		linear_extrude(d)
			pegs(drawer_thickness + 0.001, peg_size + 2*tol, od);

		translate([-s/2, s/4, -d])
			cube([s, s/4, d*2]);
	}
}

drawer(od, drawer_thickness);