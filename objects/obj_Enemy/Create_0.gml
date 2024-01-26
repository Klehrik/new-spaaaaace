/// Init

Colour = c_white;
Ally = 1; // Allegiance

Group = 1;

State = 0;
Idle = 0;

Target = noone;

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
Hull = 6;
MaxHull = 6;

Shield = 4;
MaxShield = 4;
ShieldRegen = 240;
ShieldMaxRegen = 240;

Dash = 120;
MaxDash = 120;

Cooling = 10;

// Systems
Sys = ds_list_create();
Sys[| 0] = [0, 0, 0]; // ID, Cooldown, Heat
Sys[| 1] = [1, 0, 0];
Sys[| 2] = [2, 0, 0];

Missiles = 5;