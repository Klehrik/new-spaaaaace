/// Init

Colour = c_blue;
Ally = 0; // Allegiance

Group = 0;
global.Groups[0][0] = id; // Set self as Leader of Group 0
global.Groups[0][1][| 0] = id; // Add self to Group 0

// test
if (room == rm_Main)
{
	for (var i = 1; i <= 3; i++)
	{
		var e = instance_create_depth(x + (i * 50), y, 0, obj_Enemy);
		e.Team = 1;
		e.Ally = 0;
		e.Group = 0;
		ds_list_add(global.Groups[e.Group][1], e.id); // Add self to Group
	}
}

image_xscale = 1;
image_yscale = 1;
Size = 6;

// Movement variables
HSP = 0;
VSP = 0;

MoveSpeed = 2.5; // mps = MoveSpeed * 600 <- 1 px = 10 m
TurnSpeed = 3;

prev_x = x;
prev_y = y;
prev_hsp = 0;
prev_vsp = 0;



// Ship Info
Hull = 12;
MaxHull = 12;

Shield = 6;
MaxShield = 6;
ShieldRegen = 240;
ShieldMaxRegen = 240;

Dash = 120;
MaxDash = 120;

Cooling = 10;

// Systems
Sys = ds_list_create();
Sys[| 0] = [4, 0, 0]; // ID, Cooldown, Heat
Sys[| 1] = [1, 0, 0];
Sys[| 2] = [2, 0, 0];
SysKeys = [0, 1, 2]; // Map number keys to Equipment

Missiles = 5;



// test
//Hull = 30;
//MaxHull = 30;

//Shield = 15;
//MaxShield = 15;
//ShieldRegen = 120;
//ShieldMaxRegen = 120;

//Dash = 60;
//MaxDash = 60;

//Cooling = 20;

//Sys[| 0] = [5, 0, 0]; // ID, Cooldown, Heat
//Sys[| 1] = [6, 0, 0];
//Sys[| 2] = [7, 0, 0];
//SysKeys = [0, 1, 2]; // Map number keys to Equipment

//Missiles = 99;