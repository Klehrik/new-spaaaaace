/// Step

if (instance_exists(obj_Player)) global.Follow = obj_Player;
else global.Follow = instance_find(par_Ship, 0);

// Camera
if (global.Follow.object_index == obj_Player)
{
	var dir = point_direction(global.Follow.x, global.Follow.y, mouse_x, mouse_y);
	var dist = point_distance(global.Follow.x, global.Follow.y, mouse_x, mouse_y) / 2.5;
	global.CamX = global.Follow.x - global.CamW / 2 + dcos(dir) * dist;
	global.CamY = global.Follow.y - global.CamH / 2 - dsin(dir) * dist;
	camera_set_view_pos(view_camera, global.CamX, global.CamY);
}
else
{
	if (global.Follow.Target != noone)
	{
		global.CamX = ((global.Follow.x + global.Follow.Target.x) / 2) - (global.CamW / 2);
		global.CamY = ((global.Follow.y + global.Follow.Target.y) / 2) - (global.CamH / 2);
		camera_set_view_pos(view_camera, global.CamX, global.CamY);
	}
	else
	{
		global.CamX = global.Follow.x - (global.CamW / 2);
		global.CamY = global.Follow.y - (global.CamH / 2);
		camera_set_view_pos(view_camera, global.CamX, global.CamY);
	}
}

if (keyboard_check_pressed(ord("C"))) global.Cones *= -1;