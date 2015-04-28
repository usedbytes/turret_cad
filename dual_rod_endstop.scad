/* Endstop for linear actuator.
 *
 * Designed for 2x 5 mm rods and 4 mm MXL timing belt
 *
 * Brian Starkey <stark3y@gmail.com>
 * Creative Commons BY-NC-SA
 */

$fn = 50;
/* Overall depth of the part */
depth = 8;
/* Outer diameter of the pulley */
pitch_dia = 10.7;

module mxl_17tooth() {
	color([0.2, 0.2, 0.2])
	linear_extrude(height = 5) import("mxl_17_tooth_10_7mm.dxf");
}

module axle() {
	color([0.7, 0.7, 0.7])
	cylinder(h = 9, r = 0.9);

}

module part() {
	render(convexity = 10) difference() {
		linear_extrude(height = depth)
			import("dual_rod_endstop_expanded.dxf");
		/* Bore a hole for the axle. Trapped by the rods */
		translate([0, -5, pitch_dia / 2]) rotate([-90, 0, 0])
			cylinder(h = 25, r = 0.9);
	}
}

/* Axle and pulley (for decoration)
translate([0, 5, pitch_dia / 2]) rotate([-90, 0, 0])
	mxl_17tooth();
translate([0, 3, pitch_dia / 2]) rotate([-90, 0, 0])
	axle();
*/

/* Part (for printing) */
part();
