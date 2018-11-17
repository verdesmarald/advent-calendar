include <config.scad>;

module tooth(height, base, top) {
	polygon([
		[-base/2, 0],
		[base/2, 0],
		[top/2,height],
		[-top/2,height]
	]);
}


module rounded_rect(w, h, bevel, steps)
{
	hull()
	{
		// place 4 circles in the corners, with the given radius
		for (x = [-1, 1], y = [-1, 1])
			translate([x * (w/2 - bevel), y * (h/2 - bevel), 0])
			circle(r=bevel, $fn=steps*4);
	}
}


module body(od, id, bevel, steps) {
	difference() {
		rounded_rect(od, od, bevel, steps);
		rounded_rect(id, id, bevel, steps);
	}
}


module xor() {
	difference() {
		for (i = [0 : $children - 1])
			children(i);
		intersection_for (i = [0: $children - 1])
			children(i);
	}
}

module box(od, depth, thickness, teeth, box_color, drawer_color) {
	bevel = od/6;
	id = od - thickness * 2;

	color(box_color)
	linear_extrude(height = depth, center = false)
	{
		num_teeth = 3;
		gap_teeth = 1;
		step = od/(teeth+1);
		tolerance = 0.08;
		tooth_top = od/8;
		tooth_bottom = od/10;
		
		xor() {
			body(od, id, bevel);
			for (i = [-od/2 + step : step : od/2 - step], j = [0,-90], k = [1, -1])
				rotate([0, 0, j])
				translate([i, k * od/2, 0])
				tooth(thickness/2, tooth_bottom, tooth_top);
		}
	}

	color(drawer_color)
	linear_extrude(height=2, center=false)
	{
		rounded_rect(id, id, bevel);
	}
}

translate([-(rows-1)/2*s,0,0])
	for (row = [0:rows-1]) {
		y = (2 * row + 1) * s/2;

		for (col = [0:rows-1-row]) {
			x = (2 * col + row) * s/2;
			translate([x, y, 0])
			box(s, d, thickness, teeth, "green", "green");
		}
	}

for (i = [0:1]) {
	translate([0,-(i + 1/2) * s, 0])
	color("brown")
	box(s, d, thickness, teeth);
}

! box(s, d, thickness, teeth);