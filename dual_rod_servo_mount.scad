/* Servo and rod mount for linear actuator
 *
 * Designed for 2x 5 mm rods and standard RC servo
 *
 * Brian Starkey <stark3y@gmail.com>
 * Creative Commons BY-NC-SA
 */

include <turret_common.scad>

$fn = 50;

base_depth = 4;
side_width = 3.5;
side_y = 20.32;
side1_x = 0;
side2_x = 24.32;
roller1_y = 8.33;
roller2_y = 26.69;
roller_z = 12.5;
centre_y = 37.83;
centre_x = 13.91;

roller_coords = [[side_width / 2, side_y + roller1_y, roller_z],
                 [side_width / 2, side_y + roller2_y, roller_z],
                 [(side_width / 2) + side2_x, side_y + roller1_y, roller_z],
                 [(side_width / 2) + side2_x, side_y + roller2_y, roller_z]];

module servo_mount_base() {
	render(convexity = 5) linear_extrude(height = base_depth)
		import("servo_mount_base.dxf");
}

module dual_rod_servo_mount_side() {
	render(convexity = 5) difference() {
		rotate([90, 0, 90]) linear_extrude(height = side_width)
			import("dual_rod_servo_mount_side.dxf");
		union() {
			translate([side_width / 2, roller1_y, 8])
				cylinder(h = 17, r = 1);
			translate([side_width / 2, roller2_y, 8])
				cylinder(h = 17, r = 1);
		}
	}
}

module roller() {
	difference() {
		cylinder(r = 3, h = 5, center = true);
		cylinder(r = 1, h = 6, center = true);
	}
}

module rollers() {
	for (v = roller_coords) {
		color("red") translate(v) roller();
		translate(v) axle(9);
	}
}

module dual_rod_servo_mount_part() {
	difference() {
		union() {
			servo_mount_base();
			translate([side1_x, side_y, 0]) dual_rod_servo_mount_side();
			translate([side2_x, side_y, 0]) dual_rod_servo_mount_side();
		}
		union() {
			translate([centre_x, centre_y, 5]) rotate([0, 90, 0])
				cylinder(r = 2.5, h = 40, center = true);
			translate([centre_x, centre_y, 20]) rotate([0, 90, 0])
				cylinder(r = 2.5, h = 40, center = true);
		}
	}

}

module dual_rod_servo_mount_render() {
	translate([-centre_x, -centre_y, 0]) union() {
		rollers();
		translate([centre_x, centre_y, roller_z - 2.5]) mxl_31tooth();
		dual_rod_servo_mount_part();
	}
}

dual_rod_servo_mount_part();
