/// Init

depth = -15000;

randomize();
surface_resize(application_surface, camera_get_view_width(view_camera), camera_get_view_height(view_camera));
draw_set_font(fnt_pixel_mono);

global.DT = 0;

global.CamW = camera_get_view_width(view_camera);
global.CamH = camera_get_view_height(view_camera);
global.CamLen = point_distance(0, 0, global.CamW, global.CamH); // diagonal length

global.Web = 1;
if (os_browser == browser_not_a_browser)
{
	global.Web = 0;
	
	var scale = 3;
	window_set_size(global.CamW * scale, global.CamH * scale);
}



global.PartSys = part_system_create();
part_system_depth(global.PartSys, -14500);

global.PartSys2 = part_system_create();
part_system_depth(global.PartSys2, 14000);

// White circle
global.Part1 = part_type_create();
part_type_shape(global.Part1, pt_shape_disk);
part_type_size(global.Part1, 0, 0, 0.015, 0);
part_type_alpha2(global.Part1, 1, 0);
part_type_life(global.Part1, 25, 25);

// Engine exhaust
global.Part2 = part_type_create();
part_type_shape(global.Part2, pt_shape_disk);
part_type_size(global.Part2, 0.1, 0.2, 0, 0);
part_type_alpha2(global.Part2, 1, 0);
part_type_colour3(global.Part2, c_yellow, c_red, c_dkgray);
part_type_speed(global.Part2, 1, 1, 0, 0);
part_type_life(global.Part2, 10, 10);

// Smaller circle
global.Part3 = part_type_create();
part_type_shape(global.Part3, pt_shape_disk);
part_type_size(global.Part3, 0.15, 0.15, -0.01, 0);
part_type_alpha2(global.Part3, 1, 0);
part_type_life(global.Part3, 15, 15);

global.C_GREEN = $43B500;
global.C_LTGREEN = $00E34C;
global.C_BLUE = $B55A06;
global.C_DKBLUE = $532B1D;
global.C_GRAY = $7988A2;
global.C_DKGRAY = $4F575F;