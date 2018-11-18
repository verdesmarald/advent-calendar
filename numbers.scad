use <box.scad>

border=1;

for (n=[0:23])
{
	translate([n%4 * 29, floor(n/4)*15, 0]) {
		color("black")
		linear_extrude(1.2) {
			difference() {
				rounded_rect(15, 10, 2);
				rounded_rect(15-border, 10-border, 2 - border/2);
			}
			text(str(n+1), size=8, halign="center", valign="center", font="Liberation Sans:style=Bold");
		}

		color("white")
		linear_extrude(0.6)
		rounded_rect(15-border, 10-border, 2 - border/2);
	}
}