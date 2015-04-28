/* Linear actuator slider.
 *
 * Designed for 2x 5 mm rods and 4 mm MXL timing belt. Hole for M3 bolt to
 * secure belt.
 *
 * Brian Starkey <stark3y@gmail.com>
 * Creative Commons BY-NC-SA
 */

$fn = 50;
height = 10;

module bolt(length = 10, dia = 3) {
	radius = (dia / 2) * 0.9;

	color([0.7, 0.7, 0.7]) {
		translate([0, 0, length]) intersection() {
			sphere(r = radius + 0.9, center = true);
			translate([0, 0, radius / 2])
				cube([5, 5, radius], center = true);
		}
		cylinder(r = radius, h = length);
	}
}

module part() {
	difference() {
		linear_extrude(height = 10)
			import(convexity=10, "dual_rod_slider.dxf");
		translate([-4, 7.5, 5]) rotate([0, 90, 0])
			cylinder(r = 1.4, h = 8);
	}
}

/* Bolt (for decoration)
translate([-5, 7.5, 5]) rotate([0, 90, 0])
	bolt(7);
*/

/* Part (for printing) */
part();
