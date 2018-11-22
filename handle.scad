include <config.scad>

module handle(r, l, d, bevel=0, center=true) {
	*translate([0, d/2, 0])
		cube([l, d, box_thickness], true);

	bevel = bevel < r ? r : bevel;
	h2=l-2*bevel;

	intersection() {
		translate([0, d/2, 0])
			cube([l, d, box_thickness], true);

		translate([0, d - bevel, 0]) {
			for (x=[-1,1]) {
				translate([-x*(bevel-l/2), 0, 0])
					rotate_extrude(angle=x*90)
					translate([x*(bevel-r), 0, 0])
					circle(r, true);

				h=d-bevel;
				translate([x*(l/2 - r), -h/2, 0])
					rotate([90, 90, 0])
					cylinder(h, r=r, center=true);
			}

			translate([0, bevel - r, 0])
				rotate([0, 90, 0])
				cylinder(h=h2, r=r, center=true);
		}
	}
}


handle(1.5, 15, 10, 5);