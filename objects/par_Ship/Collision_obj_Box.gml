/// Collision

var dir = point_direction(x, y, other.x, other.y);
var spd = clamp(point_distance(0, 0, HSP, VSP) / 2, 0.5, MoveSpeed);
HSP = -dcos(dir) * spd;
VSP = dsin(dir) * spd;
	
while (place_meeting(x, y, other))
{
	x += HSP;
	y += VSP;
}
	
if (spd > 0.5)
{
	if (Shield > 0) { Shield -= 1; add_damage_number(x, y - Size, 1, global.C_BLUE); }
	else { Hull -= 2; add_damage_number(x, y - Size, 2, c_white); }
	ShieldRegen = 0;
}

part_particles_create(global.PartSys, x, y, global.Part1, 1);