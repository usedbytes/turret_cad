/* Representative render of wing mechanism
 *
 * Brian Starkey <stark3y@gmail.com>
 * Creative Commons BY-NC-SA
 */
include <turret_common.scad>

use <dual_rod_endstop.scad>
endstop_depth = 8;

use <wing_mount.scad>
slider_depth = 10;

use <dual_rod_servo_mount.scad>
inside_w = 20.82;
outside_w = 27.82;

$fn = 50;

rod_length = 150;
rod_spacing = 15;
/* Include $t for animation */
slide_pos = 40 * $t;
pipe_od = 28;
pipe_id = 25;

module rod(length = 100) {
	rotate([-90, 0, 0])
	color(steel_grey)
		cylinder(r = 2.5, h = length, center = true);
}

module pod() {
	w = 70;
	h = 100;
	d = 40;

	translate([0, d / 2, 0]) rotate([90, 0, 180]) difference() {
		cube([w, h, d], center = true);
		union() {
			cylinder(r = pipe_od / 2, h = d * 1.1, center = true);
			translate([0, 0, 2]) cube([w - 4, h - 4, d], center = true);
		}
	}
}

module pipe(length = 100) {
	rotate([-90, 0, 0]) difference() {
		cylinder(r = pipe_od / 2, h = length, center = true);
		union() {
			cylinder(r = pipe_id / 2, h = length * 1.1, center = true);
			/* Slit down the length of the pipe */
			translate([0, (pipe_od / 4) + 1, 0])
				cube([5, pipe_od / 2, length * 1.1], center = true);
		}
	}
}


/* A wing mount, "slide_pos" from the end of travel */
translate([0, (rod_length / 2) - endstop_depth - slide_pos, 0])
rotate([90, 0, 0])
	wing_mount_render();

/* Endstop */
translate([0, (rod_length / 2) - endstop_depth, rod_spacing])
rotate([-90, 0, 0])
	dual_rod_endstop_render();

/* Representative gun pod */
translate([0, (rod_length / 2) - endstop_depth - slide_pos, rod_spacing / 2])
	pod();

/* Servo */
translate([0, 0, -5]) rotate([0, 0, 90])
	dual_rod_servo_mount_render();

/* Steel rods */
translate([0, (rod_length / 4) + (inside_w / 4), 0])
	rod((rod_length / 2) - (inside_w / 2));
translate([0, -((rod_length / 4) + (inside_w / 4)), 0])
	rod((rod_length / 2) - (inside_w / 2));
translate([0, 0, rod_spacing])
	rod(rod_length);

/* Slotted pipe housing */
%translate([0, (rod_length / 4) + (outside_w / 4), rod_spacing / 2])
	pipe((rod_length / 2) - (outside_w / 2));
%translate([0, -((rod_length / 4) + (outside_w / 4)), rod_spacing / 2])
	pipe((rod_length / 2) - (outside_w / 2));
