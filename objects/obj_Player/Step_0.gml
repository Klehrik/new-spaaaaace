/// Step

depth = -y;

// Check Hull
if (Hull <= 0)
{
	//game_restart();
	instance_destroy();
}



// Rotate
var vec = normalize(HSP, VSP); // normalize movement vector

// observed that mouse xy jumps to negative infinity
//show_debug_message("xy: " + string(x) + ", " + string(y) + " / mouse xy: " + string(mouse_x) + ", " + string(mouse_y));

var dir = point_direction(x, y, mouse_x, mouse_y);
var diff = angle_difference(image_angle, dir);
if (abs(HSP) + abs(VSP) > 0)
{
	//if (abs(diff) > TurnSpeed) image_angle -= sign(diff) * TurnSpeed * ((abs(HSP) + abs(VSP)) / (abs(MoveSpeed * vec[0]) + abs(MoveSpeed * vec[1])));
	if (abs(diff) > TurnSpeed) image_angle -= sign(diff) * TurnSpeed * (point_distance(0, 0, HSP, VSP) / MoveSpeed);
	else image_angle = dir;
}

// uncomment to see why turn speed is multiplied by that shit:
// show_debug_message(string((abs(HSP) + abs(VSP))) + ", " + string(abs(MoveSpeed * vec[0]) + abs(MoveSpeed * vec[1])));

// Accelerate
var acc = MoveSpeed / 40; // acceleration

if (mouse_check_button(mb_left))
{
	//if (sign(HSP) == sign(lengthdir_x(acc, image_angle))) HSP += lengthdir_x(acc, image_angle) / 3;
	//else HSP += lengthdir_x(acc, image_angle);
	//if (sign(VSP) == sign(lengthdir_y(acc, image_angle))) VSP += lengthdir_y(acc, image_angle) / 3;
	//else VSP += lengthdir_y(acc, image_angle);
	
	HSP += lengthdir_x(acc, image_angle);
	VSP += lengthdir_y(acc, image_angle);
	create_exhaust_particle(10);
}
else
{
	if (HSP != 0) HSP -= vec[0] * 0.02;
	if (VSP != 0) VSP -= vec[1] * 0.02;
	if (abs(HSP) <= 0.02) HSP = 0;
	if (abs(VSP) <= 0.02) VSP = 0;
}

// Dash
if (Dash < MaxDash) Dash += 1;
if (keyboard_check(vk_space) and Dash >= MaxDash)
{
	Dash = 0;
	
	HSP += lengthdir_x(acc * 90, image_angle);
	VSP += lengthdir_y(acc * 90, image_angle);
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

// debug string
//show_debug_message("xy: " + string(x) + ", " + string(y) + " / HVSP: " + string(HSP) + ", " + string(VSP) + " / SPD: " + string(point_distance(0, 0, HSP, VSP)) + " / image_angle: " + string(image_angle) + " / vec: " + string(vec));

// NaN fix: if a value is NaN, restore its previous value
// i seriously cannot figure out what's causing this so this is a temp fix
if (is_nan(x)) x = prev_x;
if (is_nan(y)) y = prev_y;
prev_x = x;
prev_y = y;

if (is_nan(HSP)) HSP = prev_hsp;
if (is_nan(VSP)) VSP = prev_vsp;
prev_hsp = HSP;
prev_vsp = VSP;



// Equipment
for (var i = 1; i <= array_length(SysKeys); i++)
{
	if (keyboard_check(ord(string(i))))
	{
		var key = SysKeys[i - 1];
		
		if (key >= 0)
		{
			var sys = Sys[| key];
			
			if (sys[1] <= 0 and sys[2] < 100 - equipment_heat(sys[0])) // check cooldown and heat
			{
				if (sys[0] < 99) // Weapon
				{
					if (Missiles >= weapon_missiles(sys[0]))
					{
						weapon_fire(sys[0]);
						Sys[| key][1] = weapon_cooldown(sys[0]);
						Sys[| key][2] += equipment_heat(sys[0]);
						Missiles -= weapon_missiles(sys[0]);
					}
				}
				else
				{
					system_use(sys[0]);
					Sys[| key][1] = system_cooldown(sys[0]);
					Sys[| key][2] += equipment_heat(sys[0]);
				}
			}
		}
	}
}