/// Draw

// Self
var slices = allegiance_sprite_layers(Ally);
for (var i = 0; i < slices; i++)
{
	draw_sprite_ext(sprite_index, i, x, y - i * image_yscale, image_xscale, image_yscale, image_angle, c_white, 1);
}

// Shield
if (Shield > 0)
{
	draw_set_alpha(0.5 * (Shield / MaxShield));
	draw_circle_colour(x - 1, y - slices / 2, Size * 2, c_white, Colour, 0);
	draw_set_alpha(1);
}

// Hull + Shield Bars
var web = global.Web;
var c = c_black;

draw_rectangle_colour(x - Size * 1.5, y + Size * 2 + 2, x - Size * 1.5 + ((Hull / MaxHull) * Size * 3), y + Size * 2 + 4 + web, global.C_GREEN, global.C_GREEN, global.C_GREEN, global.C_GREEN, 0);
draw_rectangle_colour(x - Size * 1.5, y + Size * 2 + 2, x + Size * 1.5, y + Size * 2 + 4 + web, c, c, c, c, 1);

if (Shield > 0)
{
	draw_rectangle_colour(x - Size * 1.5, y + Size * 2 + 2, x - Size * 1.5 + ((Shield / MaxShield) * Size * 3), y + Size * 2 + 4 + web, global.C_BLUE, global.C_BLUE, global.C_BLUE, global.C_BLUE, 0);
	draw_rectangle_colour(x - Size * 1.5, y + Size * 2 + 2, x - Size * 1.5 + ((Shield / MaxShield) * Size * 3), y + Size * 2 + 4 + web, c, c, c, c, 1);
}

c = global.C_GRAY;
if (Shield > 0) draw_rectangle_colour(x - Size * 1.5 - 1, y + Size * 2 + 1, x - Size * 1.5 + ((Shield / MaxShield) * Size * 3) + 1, y + Size * 2 + 5 + web, c, c, c, c, 1);
draw_rectangle_colour(x - Size * 1.5 - 1, y + Size * 2 + 1, x + Size * 1.5 + 1, y + Size * 2 + 5 + web, c, c, c, c, 1);



// View Cone
if (global.Cones >= 1)
{
	// Normal Cone
	var len = (45 / TurnSpeed) * sqr(point_distance(0, 0, HSP, VSP)) * 1.5;
	var movedir = point_direction(x, y, x + HSP, y + VSP);
	for (var n = -15; n <= 15; n += 5)
	{
		draw_line(x, y, x + dcos(movedir + n) * len, y - dsin(movedir + n) * len);
	}

	draw_line_colour(x, y, x + dcos(image_angle) * len * 1.5, y - dsin(image_angle) * len * 1.5, c_yellow, c_yellow);
	
	// Dash Cone
	var acc = MoveSpeed / 40;
	
	var dash_hsp = HSP + lengthdir_x(acc * 90, image_angle);
	var dash_vsp = VSP + lengthdir_y(acc * 90, image_angle);
	
	var dash_dir = point_direction(0, 0, dash_hsp, dash_vsp);
	var dash_len = (45 / TurnSpeed) * sqr(point_distance(0, 0, dash_hsp, dash_vsp));
	
	for (var n = -15; n <= 15; n += 5)
	{
		draw_line_colour(x, y, x + dcos(dash_dir + n) * dash_len, y - dsin(dash_dir + n) * dash_len, global.C_BLUE, global.C_BLUE);
	}
	
	// Line of Sight
	draw_line_colour(x, y, x + dcos(image_angle) * len * 1.5, y - dsin(image_angle) * len * 1.5, c_yellow, c_yellow);
}