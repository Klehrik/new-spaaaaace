/// Begin Step

// Clamp values
Hull = clamp(Hull, 0, MaxHull);
Shield = clamp(Shield, 0, MaxShield);

// Shield Regen
if (Shield < MaxShield)
{
	if (ShieldRegen < ShieldMaxRegen)
	{
		if (Shield <= 0) ShieldRegen += 0.5; // regen at half speed if no shield is active
		else ShieldRegen += 1;
	}
	else
	{
		Shield += 1;
		if (Shield < MaxShield) ShieldRegen = 0;
	}
}

// Equipment Cooldowns / Heat
for (var i = 0; i < ds_list_size(Sys); i++)
{
	if (Sys[| i][1] > 0) Sys[| i][1] -= 1;
	//if (global.DT mod 6 <= 0 and Sys[| i][2] > 0) Sys[| i][2] -= 1;
	if (Sys[| i][2] > 0) Sys[| i][2] -= Cooling / 60;
}