/* Linear actuator mount for wing
 *
 * Brian Starkey <stark3y@gmail.com>
 * Creative Commons BY-NC-SA
 */

use <dual_rod_slider.scad>

$fn = 50;

mount_length = 23;
mount_width = 4;
mount_depth = 10;
pad_width = 15;
pad_depth = 2.5;

unit_vectors = [[1, 1, 0], [1, -1, 0], [-1, 1, 0], [-1, -1, 0]];
hole_r = 1.5;
hole_offset = (pad_width / 2) - (hole_r + 1);
bolt_length = 6;

module wing_mount_stick() {
	resize([mount_width, mount_length, mount_depth], auto = true)
	rotate([90, 0, 90]) linear_extrude(height = 1)
		import("wing_mount_stick.dxf");
}

module wing_mount_pad() {
	translate([0, 0, pad_depth / 2]) difference() {
		cube([pad_width, pad_width, pad_depth], center = true);
		union() {
			/* List comprehension to put a hole in the 4 corners
			 * IMO this is just a bit sexy...
			 */
			for (v = unit_vectors) {
				translate(v * hole_offset)
					cylinder(r = hole_r, h = 2 * pad_depth, center = true);
			}
		}
	}
}

module wing_mount_part() {
	translate([0, (pad_width / 2) - (mount_length + 3), pad_depth / 2])
		wing_mount_pad();
	translate([-(mount_width / 2), -(mount_length + 3), 0])
		wing_mount_stick();
	dual_rod_slider_part();
}

module wing_mount_render() {
	translate([0, (pad_width / 2) - (mount_length + 3), 0])
	union() {
		wing_mount_pad();
		/* Add some bolts */
		union() {
			for (v = unit_vectors) {
				translate(v * hole_offset)
				translate([0, 0, -(bolt_length - pad_depth - 0.1)])
					bolt(bolt_length);
			}
		}
	}
	translate([-(mount_width / 2), -(mount_length + 3), 0])
		wing_mount_stick();
	dual_rod_slider_render();
}

wing_mount_part();
