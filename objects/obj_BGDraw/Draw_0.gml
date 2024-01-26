/// Draw

// Stars
for (var n = 0; n < ds_list_size(Stars); n++)
{
	while (Stars[| n][0] < global.CamX) Stars[| n][0] += global.CamW;
	while (Stars[| n][0] > global.CamX + global.CamW) Stars[| n][0] -= global.CamW;
	while (Stars[| n][1] < global.CamY) Stars[| n][1] += global.CamH;
	while (Stars[| n][1] > global.CamY + global.CamH) Stars[| n][1] -= global.CamH;
	
	draw_set_alpha(0.7);
	
	var dir = point_direction(0, 0, global.Follow.HSP, global.Follow.VSP) - 180;
	var spd = point_distance(0, 0, global.Follow.HSP, global.Follow.VSP);
	if (spd > global.Follow.MoveSpeed)
	{
		draw_set_alpha(0.5);
		draw_line(Stars[| n][0], Stars[| n][1], Stars[| n][0] + dcos(dir) * spd, Stars[| n][1] - dsin(dir) * spd);
	}
	else draw_point(Stars[| n][0], Stars[| n][1]);
	
	draw_set_alpha(1);
}

// Bloom ring
with (par_Ship)
{
	var slices = allegiance_sprite_layers(Ally);
	//draw_circle_colour(x - 1, y - slices / 2, Size * 5, Colour, $26170F, 0);
	
	var scale = Size / 24;
	draw_sprite_ext(spr_Glow, 0, x - 1, y - slices / 2, scale, scale, 0, Colour, 0.4);
}