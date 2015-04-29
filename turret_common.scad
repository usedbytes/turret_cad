/* Common modules for turret CAD
 *
 * Brian Starkey <stark3y@gmail.com>
 * Creative Commons BY-NC-SA
 */

/* Outer diameter of the pulley. */
mxl_17tooth_dia = 10.7;

steel_grey = [0.7, 0.7, 0.7];

module mxl_17tooth() {
	color([0.2, 0.2, 0.2])
	linear_extrude(height = 5) import("mxl_17_tooth_10_7mm.dxf");
}

module mxl_31tooth() {
	color([0.2, 0.2, 0.2])
	linear_extrude(height = 5) import("mxl_31_tooth_19_8mm.dxf");
}

module bolt(length = 10, dia = 3) {
	radius = (dia / 2) * 0.9;

	color(steel_grey) {
		translate([0, 0, length]) intersection() {
			sphere(r = radius + 0.9, center = true);
			translate([0, 0, radius / 2])
				cube([5, 5, radius], center = true);
		}
		cylinder(r = radius, h = length);
	}
}

module axle(length = 10) {
	color(steel_grey) cylinder(r = 1, h = length, center = true);
}
