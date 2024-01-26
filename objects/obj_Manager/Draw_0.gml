/// Draw

draw_set_halign(fa_right);
draw_text(global.CamX + global.CamW - 1, global.CamY + 3, "FPS: " + string(fps) + " - Instances: " + string(instance_count));
draw_set_halign(fa_left);

//draw_text(global.CamX + 2, global.CamY + 19, "Hull: " + string(global.Follow.Hull) + " / " + string(global.Follow.MaxHull));
//draw_text(global.CamX + 2, global.CamY + 30, "Shield: " + string(global.Follow.Shield) + " / " + string(global.Follow.MaxShield));

//draw_text(global.CamX + 2, global.CamY + 57, "Dash: " + string(floor((global.Follow.Dash / 120) * 100)) + "%");
//draw_text(global.CamX + 2, global.CamY + 46, "Missiles: " + string(global.Follow.Missiles));



// Damage Numbers
var i = 0;
while (i < ds_list_size(DamageNum))
{
	// Draw
	DamageNum[| i][1] -= 0.15;
	var c = DamageNum[| i][4];
	draw_text_colour(DamageNum[| i][0], DamageNum[| i][1], DamageNum[| i][3], c, c, c, c, 1);
	
	// Life
	if (DamageNum[| i][2] > 0) { DamageNum[| i][2] -= 1; i += 1; }
	else ds_list_delete(DamageNum, i);
}

// Indicator
with (obj_Enemy)
{
	var s = Size * 2.5;
	if (x < global.CamX - s or x > global.CamX + global.CamW + s or y < global.CamY - s or y > global.CamY + global.CamH + s)
	{
		with (global.Follow)
		{
			var dir = point_direction(x, y, other.x, other.y);
			var _x = x;
			var _y = y;
	
			while (_x >= global.CamX + 16 and _x <= global.CamX + global.CamW - 16 and _y >= global.CamY + 24 and _y <= global.CamY + global.CamH - 24)
			{
				_x += dcos(dir);
				_y -= dsin(dir);
			}
	
			var s = 6;
			var d = point_direction(x, y, other.x, other.y);
			var c = other.Colour;
			draw_triangle_colour(_x + lengthdir_x(s, d), _y + lengthdir_y(s, d),
			_x + lengthdir_x(s, d - 90), _y + lengthdir_y(s, d - 90),
			_x + lengthdir_x(s, d + 90), _y + lengthdir_y(s, d + 90), c, c, c, 0);
		}
	}
}



// Bars (Hull / Shield / Missiles)
for (var i = 0; i < global.Follow.MaxHull; i++)
{
	var s = 1;
	if (i < global.Follow.Hull) s = 0;
	draw_sprite(spr_Bars, s, global.CamX + 2 + (i * 4) + (i div 5) * 2, global.CamY + 2);
}

for (var i = 0; i < global.Follow.MaxShield; i++)
{
	var s = 3;
	if (i < global.Follow.Shield) s = 2;
	draw_sprite(spr_Bars, s, global.CamX + 2 + (i * 4) + (i div 5) * 2, global.CamY + 18);
}

draw_rectangle_colour(global.CamX + 3, global.CamY + 31, global.CamX + 53, global.CamY + 32, global.C_DKGRAY, global.C_DKGRAY, global.C_DKGRAY, global.C_DKGRAY, 0);
draw_rectangle_colour(global.CamX + 2, global.CamY + 30, global.CamX + 52, global.CamY + 31, global.C_DKBLUE, global.C_DKBLUE, global.C_DKBLUE, global.C_DKBLUE, 0);
draw_rectangle_colour(global.CamX + 2, global.CamY + 30, global.CamX + 2 + (global.Follow.ShieldRegen / global.Follow.ShieldMaxRegen) * 50, global.CamY + 31, global.C_GRAY, global.C_GRAY, global.C_GRAY, global.C_GRAY, 0);

draw_sprite(spr_Bars, 4, global.CamX + 2, global.CamY + 37);
draw_text_colour(global.CamX + 13, global.CamY + 39 - global.Web, global.Follow.Missiles, global.C_DKGRAY, global.C_DKGRAY, global.C_DKGRAY, global.C_DKGRAY, 1);
draw_text(global.CamX + 12, global.CamY + 38 - global.Web, global.Follow.Missiles);

// Equipment Bars
for (var i = 0; i < ds_list_size(global.Follow.Sys); i++)
{
	var sys = global.Follow.Sys[| i];
	var _x = global.CamX + 2 + (i * 51);
	var _y = global.CamY + global.CamH - 18; // height to put the bars at
	
	// Bar
	var c = c_white;
	if (sys[0] >= 0)
	{
		if (sys[2] > 100 - equipment_heat(sys[0])) c = c_red;
		else if (sys[2] > 50) c = c_orange;
		else if (sys[2] > 25) c = c_yellow;
		if (sys[2] > 0) draw_rectangle_colour(_x + 16, _y + 3, _x + 16 + (sys[2] / 100) * 30, _y + 13, c, c, c, c, 0); // heat
		draw_set_alpha(0.3);
		draw_rectangle(_x + 16, _y + 3, _x + 16 + (1 - (sys[1] / weapon_cooldown(sys[0]))) * 30, _y + 13, 0); // cooldown
		draw_set_alpha(1);
	}
	//draw_rectangle_colour(_x + 16, _y + 3, _x + 46, _y + 13, global.C_GRAY, global.C_GRAY, global.C_GRAY, global.C_GRAY, 1); // border
	Fdraw_rectangle_colour(_x + 15, _y + 2, _x + 46, _y + 13, global.C_GRAY); // border
	
	// Icon
	draw_sprite(spr_WeaponIcons, 0, _x, _y);
	draw_sprite_ext(spr_WeaponIcons, sys[0] + 1, _x, _y, 1, 1, 0, c, 1);
}