/* Endstop for linear actuator.
 *
 * Designed for 2x 5 mm rods and 4 mm MXL timing belt
 *
 * Brian Starkey <stark3y@gmail.com>
 * Creative Commons BY-NC-SA
 */

include <turret_common.scad>

$fn = 50;
/* Overall depth of the part */
depth = 8;

module dual_rod_endstop_axle() {
	color([0.7, 0.7, 0.7])
	cylinder(h = 9, r = 0.9);

}

/* Part (for printing) */
module dual_rod_endstop_part() {
	render(convexity = 10) difference() {
		linear_extrude(height = depth)
			import("dual_rod_endstop_expanded.dxf");
		/* Bore a hole for the axle. Trapped by the rods */
		translate([0, -5, mxl_17tooth_dia / 2]) rotate([-90, 0, 0])
			cylinder(h = 25, r = 0.9);
	}
}

/* Prettier representation for models */
module dual_rod_endstop_render() {
	/* Axle and pulley (for decoration) */
	translate([0, 5, mxl_17tooth_dia / 2]) rotate([-90, 0, 0])
		mxl_17tooth();
	translate([0, 3, mxl_17tooth_dia / 2]) rotate([-90, 0, 0])
		dual_rod_endstop_axle();

	dual_rod_endstop_part();
}

/* Default of this file is model for printing */
dual_rod_endstop_part();
