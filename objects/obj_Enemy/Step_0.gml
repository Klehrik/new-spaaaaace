/// Step

//if (room == rm_Main) { with (obj_Enemy) { if (Group == 1) instance_destroy(); } }

if (keyboard_check_pressed(ord("H"))) Hull = MaxHull;



depth = -y;
if (instance_exists(global.Follow))
{
	if (ds_list_find_index(global.Groups[global.Follow.Group][1], id) >= 0) Colour = c_blue;
	else if (ds_list_find_index(global.Groups[global.Follow.Group][2], Group) >= 0) Colour = c_red;
	else Colour = c_white;
}
sprite_index = allegiance_sprite(Ally);

// Check Hull
if (Hull <= 0)
{
	instance_destroy();
}

// Assign new Leader of group if old one is gone
if (!instance_exists(global.Groups[Group][0])) global.Groups[Group][0] = id;

// Get target
Target = noone;

for (var n = 2; n <= instance_number(par_Ship); n++) // start at 2 to avoid self
{
	var ship = instance_nth_nearest(x, y, par_Ship, n);
		
	if (point_distance(x, y, ship.x, ship.y) <= 99999)
	{
		if (ds_list_find_index(global.Groups[Group][2], ship.Group) >= 0)
		{
			Target = ship;
			break;
		}
	}
	else break;
}



// Rotate
var vec = normalize(HSP, VSP); // normalize movement vector

if (Target != noone)
{
	var Tdir = point_direction(Target.x, Target.y, Target.x + HSP, Target.y + VSP); // target's movement angle
	var dist = point_distance(x, y, Target.x, Target.y);
	var spd = point_distance(0, 0, HSP, VSP) + random_range(3, 9);
	
	if (spd > 1)
	{
		var _x = Target.x - dcos(Tdir) * dist / sqrt(spd);
		var _y = Target.y + dsin(Tdir) * dist / sqrt(spd);
	}
	else
	{
		var _x = Target.x - dcos(Tdir) * dist * sqrt(spd);
		var _y = Target.y + dsin(Tdir) * dist * sqrt(spd);
	}
	var dir = point_direction(x, y, _x, _y);
	// v If player speed is less than half of maximum (too slow)
	if (point_distance(0, 0, Target.HSP, Target.VSP) < Target.MoveSpeed / 2) dir = point_direction(x, y, Target.x, Target.y) + random_range(-3, 3);
}
else
{
	var leader = global.Groups[Group][0];
	if (leader == id)
	{
		var dir = point_direction(x, y, global.Groups[Group][3], global.Groups[Group][4]); // Leader
		if (point_distance(x, y, global.Groups[Group][3], global.Groups[Group][4]) < 100)
		{
			global.Groups[Group][3] = irandom_range(-50, 350);
			global.Groups[Group][4] = irandom_range(-50, 350);
		}
	}
	else var dir = point_direction(x, y, global.Groups[Group][0].x, global.Groups[Group][0].y); // Member
}

// View Cone
var cone = 0;
var len = (45 / TurnSpeed) * sqr(point_distance(0, 0, HSP, VSP)) * 1.5;
// ^ Calculating the required distance to make a 45 degree turn with extra leeway.

var movedir = point_direction(x, y, x + HSP, y + VSP);
for (var n = -15; n <= 15; n += 5)
{
	if (collision_line(x, y, x + dcos(movedir + n) * len, y - dsin(movedir + n) * len, par_Ship, 0, 1))
	{
		cone = 1;
		var col_obj = collision_line(x, y, x + dcos(movedir + n) * len, y - dsin(movedir + n) * len, par_Ship, 0, 1);
	}
	if (collision_line(x, y, x + dcos(movedir + n) * len, y - dsin(movedir + n) * len, obj_Box, 0, 1))
	{
		cone = 1;
		var col_obj = collision_line(x, y, x + dcos(movedir + n) * len, y - dsin(movedir + n) * len, obj_Box, 0, 1);
	}
}



// AI
var spd = point_distance(0, 0, HSP, VSP) / MoveSpeed; // movement speed as a fraction (0 - 1)

// Idle move once in a while
if (global.DT mod 360 <= 0) Idle = irandom_range(60, 90);
if (Idle > 0) Idle -= 1;

if (cone) State = 3; // Avoid ships
else
{
	if (Target != noone) // Valid target ship
	{
		if (abs(angle_difference(image_angle, dir)) > 90) State = 2; // Turn around (target behind)
		else if (point_distance(x, y, Target.x, Target.y) < len / 2 and spd > 0.5) State = 1; // Idle slow
		else
		{
			if (Idle <= 0) State = 2; // Chase target
			else State = 0; // Idle move
		}
	}
	else // Move to target coords or follow Leader
	{
		if (global.Groups[Group][0] == id) State = 2; // Move to coords if Leader
		else
		{
			if (point_distance(x, y, global.Groups[Group][0].x, global.Groups[Group][0].y) > max(len, Size * 16)) State = 2; // Follow Leader
			else State = 1; // Idle slow
		}
	}
}

// Behaviors
var accel = 0;
switch (State)
{
	case 0: // Idle move
		accel = 1;
		break;
	
	case 1: // Idle slow
		if (HSP != 0) HSP -= vec[0] * 0.02;
		if (VSP != 0) VSP -= vec[1] * 0.02;
		if (abs(HSP) <= 0.02) HSP = 0;
		if (abs(VSP) <= 0.02) VSP = 0;
		break;
		
	case 2: // Chase target
		var diff = angle_difference(image_angle, dir);
		if (abs(HSP) + abs(VSP) > 0)
		{
			if (abs(diff) > TurnSpeed) image_angle -= sign(diff) * TurnSpeed * spd;
			else image_angle = dir;
		}
		accel = 1;
		create_exhaust_particle(10);
		break;
		
	case 3: // Avoid collision
		image_angle += TurnSpeed * spd * sign(angle_difference(image_angle, point_direction(x, y, col_obj.x, col_obj.y)));
		accel = 1;
		
		//if (abs(angle_difference(image_angle, movedir)) < 45 and spd > 0.5) // Slow down to half speed
		//{
		//	if (HSP != 0) HSP -= vec[0] * 0.02;
		//	if (VSP != 0) VSP -= vec[1] * 0.02;
		//	if (abs(HSP) <= 0.02) HSP = 0;
		//	if (abs(VSP) <= 0.02) VSP = 0;
		//}
		//else accel = 1;
		break;
}

show_debug_message("");



// Accelerate
var acc = MoveSpeed / 40; // acceleration
if (accel >= 1)
{
	HSP += lengthdir_x(acc, image_angle);
	VSP += lengthdir_y(acc, image_angle);
}

// Dash
if (Dash < MaxDash) Dash += 1;

// Dash if:
// - Cooldown is finished
// - Distance to target is more than (view cone length / 2)
// - There is no object in the way of the Dash length
// - image_angle is within 90 deg of target direction
var dash_hsp = HSP + lengthdir_x(acc * 90, image_angle);
var dash_vsp = VSP + lengthdir_y(acc * 90, image_angle);

var obstruct = 0;
var dash_dir = point_direction(0, 0, dash_hsp, dash_vsp);
var dash_len = (45 / TurnSpeed) * sqr(point_distance(0, 0, dash_hsp, dash_vsp));

// collision cone for dash
for (var n = -15; n <= 15; n += 5)
{
	if (collision_line(x, y, x + dcos(dash_dir + n) * dash_len, y - dsin(dash_dir + n) * dash_len, par_Ship, 0, 1)
	or collision_line(x, y, x + dcos(dash_dir + n) * dash_len, y - dsin(dash_dir + n) * dash_len, obj_Box, 0, 1)) obstruct = 1;
}

var far_enough = 0;
if (Target != noone) { if (point_distance(x, y, Target.x, Target.y) > len) far_enough = 1; }
else
{
	if (point_distance(x, y, global.Groups[Group][0].x, global.Groups[Group][0].y) > max(len, Size * 16)) far_enough = 1;
}

if (Dash >= MaxDash and far_enough == 1 and abs(angle_difference(image_angle, dir)) < 90 and obstruct <= 0)
{
	Dash = 0;
	
	HSP = dash_hsp;
	VSP = dash_vsp;
}



// Update Position
var vec = normalize(HSP, VSP); // update normalized vector

for (var i = 0; i < 3; i++)
{
	if (HSP < -abs(MoveSpeed * vec[0]) or HSP > abs(MoveSpeed * vec[0])) HSP -= acc * vec[0];
	if (VSP < -abs(MoveSpeed * vec[1]) or VSP > abs(MoveSpeed * vec[1])) VSP -= acc * vec[1];
}

x += HSP;
y += VSP;

// NaN fix: if a value is NaN, restore its previous value
if (is_nan(x)) x = prev_x;
if (is_nan(y)) y = prev_y;
prev_x = x;
prev_y = y;

if (is_nan(HSP)) HSP = prev_hsp;
if (is_nan(VSP)) VSP = prev_vsp;
prev_hsp = HSP;
prev_vsp = VSP;



// Equipment
if (Target != noone)
{
	for (var i = 0; i < ds_list_size(Sys); i++)
	{
		var sys = Sys[| i];
	
		var in_range = 0;
		if (sys[0] < 99)
		{
			if (abs(angle_difference(image_angle, dir)) <= weapon_dir_max(sys[0])				// check if current angle is near target angle
			and point_distance(x, y, Target.x, Target.y) <= weapon_range(sys[0])		// check if target is in range
			and !collision_line(x, y, Target.x, Target.y, obj_Box, 0, 1)) in_range = 1;	// check if there is a solid between self and target
		}
		else in_range = 1;
	
		if (sys[1] <= 0 and sys[2] < 100 - equipment_heat(sys[0]) and in_range >= 1) // check cooldown and heat
		{
			if (sys[0] < 99) // Weapon
			{
				if (Missiles >= weapon_missiles(sys[0]))
				{
					weapon_fire(sys[0]);
					Sys[| i][1] = weapon_cooldown(sys[0]);
					Sys[| i][2] += equipment_heat(sys[0]);
					Missiles -= weapon_missiles(sys[0]);
				}
			}
			else
			{
				system_use(sys[0]);
				Sys[| i][1] = system_cooldown(sys[0]);
				Sys[| i][2] += equipment_heat(sys[0]);
			}
		}
	}
}