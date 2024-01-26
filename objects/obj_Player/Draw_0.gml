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

// Dash Bar
draw_line_colour(x - Size * 1.5 - 1, y + Size * 2 + 8, x + Size * 1.5 + 1, y + Size * 2 + 8, global.C_DKBLUE, global.C_DKGRAY);
draw_line(x - Size * 1.5 - 1, y + Size * 2 + 8, x - Size * 1.5 + ((Dash / MaxDash) * Size * 3) + 1, y + Size * 2 + 8);

// Power test
//draw_text(global.CamX + 1, global.CamY + 3, string(Power) + " / " + string(MaxPower) + " - " + string(PowerRegen));