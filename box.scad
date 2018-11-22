include <config.scad>;

module tooth(h, b, a, t) {
	// h = height
	// b = longer edge
	// a = shorter edge
	// t = tolerance (added equally all around)

	x1 = 1/2 * a + t;
	y1 = h;
	x2 = 1/2 * b + t;
	y2 = 0;

	m = (y2 - y1)/(x2 - x1);
	b = y1 - m * x1;

	function x(y) = (y-b)/m;

	polygon([
		[-x(-t), -t],
		[x(-t), -t],
		[x(h+t), h+t],
		[-x(h+t), h+t]
	]);
}


module pegs(peg_height, peg_width, id, quarter=true) {
	for (x = [-1, 1], r = [0, 90])
		if (r == 0 || quarter)
			rotate([0, 0, r])
			translate([x * (id - peg_height)/2 , 0])
			square([peg_height, peg_width], true);
}

module rounded_rect(w, h, bevel)
{
	hull()
	{
		// place 4 circles in the corners, with the given radius
		for (x = [-1, 1], y = [-1, 1])
			translate([x * (w/2 - bevel), y * (h/2 - bevel)])
			circle(r=bevel);
	}
}


module box(od, depth, thickness, teeth, box_color, drawer_color) {
	step = od/(teeth+1);
	bevel = box_bevel;	
	id = od - thickness * 2 - tooth_height;

	linear_extrude(depth, false)
	{
		difference() {
			union() {
				// Body
				difference() {
					union() {
						translate([tooth_height, tooth_height]/2)
							rounded_rect(od - tooth_height, od - tooth_height, bevel);
						rounded_rect(od, od, bevel);
					}
					translate([tooth_height, tooth_height]/2)
						rounded_rect(id, id, bevel - thickness);
				}

				// Teeth
				for (i = [-od/2 + step : step : od/2 - step], j = [0,-90])
					rotate([0, 0, j])
					translate([i, od/2, 0])
					tooth(tooth_height, tooth_bottom, tooth_top, 0);
			}

			// Sockets
			for (i = [-od/2 + step : step : od/2 - step], j = [0,-90])
				rotate([0, 0, j])
				translate([i, -od/2, 0])
				tooth(tooth_height, tooth_bottom, tooth_top, tolerance);
		}
	}
				
	// Pegs in the center of each side to support drawers
	linear_extrude(depth - peg_offset, false)
		translate([tooth_height, tooth_height]/2)
		pegs(peg_height, peg_width, id);


	linear_extrude(surface_thickness)
	{
		translate([tooth_height, tooth_height]/2)
		rounded_rect(id, id, bevel - thickness);
	}
}

%translate([-box_size/2, 0])
	box(box_size - tooth_height, box_height, box_thickness, teeth);

%translate([0, box_size])
	box(box_size - tooth_height, box_height, box_thickness, teeth);

translate([box_size/2, 0])
	!box(box_size - tooth_height, box_height, box_thickness, teeth);