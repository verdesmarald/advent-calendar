include <config.scad>;

use <box.scad>;

//translate(-[(thickness+1.8)/4, (thickness+1.8)/4, 2])
	%box(s, d, thickness, teeth, "green", "red");

tol = 0;
od = s - thickness*3 - tol*2;

drawer_thickness = 1.8;

	difference () {
		union () {
			linear_extrude(d-2, false)
			difference () {
				rounded_rect(od, od, od/6);
				rounded_rect(od-2*drawer_thickness, od-2*drawer_thickness, od/6 - drawer_thickness);
			}

			color("blue")
			linear_extrude(2, false)
				rounded_rect(od-2*drawer_thickness, od-2*drawer_thickness, od/6 - drawer_thickness);
		}

		translate([-s/2, 0, -1])
			cube([s, s/4, d+1]);
	}