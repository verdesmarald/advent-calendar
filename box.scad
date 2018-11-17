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
	
	tooth_top = 7.5;//od/8;
	tooth_bottom = 5;//od/12;
	
	tolerance = 0.2;

	bevel = 10;
	id = od - thickness * 2 - tooth_height;

	linear_extrude(height = depth, center = false)
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

				
				// Pegs in the center of each side to support drawers
				peg_size = 2;
				translate([tooth_height, tooth_height]/2)
				for (p = [[1, 0], [0, 1], [-1, 0], [0, -1]])
					translate([p[0] * (id - peg_size)/2 , p[1] * (id - peg_size)/2])					
					square(peg_size, true);

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

	color(drawer_color)
	linear_extrude(height=2, center=false)
	{
		translate([tooth_height, tooth_height]/2)
		rounded_rect(id, id, bevel - thickness);
	}
}

rows = 4;
*translate([-(rows-1)/2*s,0,0])
	for (row = [0:rows-1]) {
		y = (2 * row + 1) * s/2;

		for (col = [0:rows-1-row]) {
			x = (2 * col + row) * s/2;
			translate([x, y, 0])
			box(s, d, thickness, teeth, "green", "green");
		}
	}

*for (i = [0:1]) {
	translate([0,-(i + 1/2) * s, 0])
	color("brown")
	box(s, d, thickness, teeth);
}

%translate([-s/2, 0])
box(s, d, thickness, teeth, "green", "red");
%translate([0, s])
box(s, d, thickness, teeth, "green", "red");
translate([s/2, 0])
box(s, d, thickness, teeth, "blue", "red");