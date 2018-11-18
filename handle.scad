
module handle(length, thickness, depth, center=true) {
	linear_extrude(thickness)
		square([length, thickness], center);

	translate([center ? -length/2 : 0, 0])
	linear_extrude(depth) {
		square(thickness, center);
		translate([length - (center ? 0 : thickness), 0])
			square(thickness, center);
	}
}

handle(15, 4, 10);