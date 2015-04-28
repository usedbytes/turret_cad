/* Linear actuator slider.
 *
 * Designed for 2x 5 mm rods and 4 mm MXL timing belt. Hole for M3 bolt to
 * secure belt.
 *
 * Brian Starkey <stark3y@gmail.com>
 * Creative Commons BY-NC-SA
 */

include <turret_common.scad>

$fn = 50;
height = 10;

/* Part (for printing) */
module dual_rod_slider_part() {
	difference() {
		render(convexity = 10) linear_extrude(height = 10)
			import("dual_rod_slider.dxf");
		translate([-4, 7.5, 5]) rotate([0, 90, 0])
			cylinder(r = 1.4, h = 8);
	}
}

/* Visual representation for modelling */
module dual_rod_slider_render() {
	/* Bolt (for decoration) */
	translate([-5, 7.5, 5]) rotate([0, 90, 0])
		bolt(7);
	dual_rod_slider_part();
}

dual_rod_slider_part();
