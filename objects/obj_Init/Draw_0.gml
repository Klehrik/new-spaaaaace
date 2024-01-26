/// Draw

if (global.Follow.object_index == obj_Player)
{
	var dir = point_direction(global.Follow.x, global.Follow.y, mouse_x, mouse_y);
	var dist = point_distance(global.Follow.x, global.Follow.y, mouse_x, mouse_y);
	draw_sprite(spr_Cursor, 1, global.Follow.x + dcos(dir) * dist * 0.8, global.Follow.y - dsin(dir) * dist * 0.8);
	draw_sprite(spr_Cursor, 0, mouse_x, mouse_y);
}