/// Misc

function normalize(a, b)
{
	var len = point_distance(0, 0, a, b);
	if (len > 0) return [a / len, b / len];
	else return [0, 0];
}

function create_exhaust_particle(size)
{
	part_type_direction(global.Part2, image_angle - 210, image_angle - 150, 0, 0);
	part_type_life(global.Part2, size, size);
	part_particles_create(global.PartSys2, x + lengthdir_x(Size * 1.2, image_angle - 180), y + lengthdir_y(Size * 1.2, image_angle - 180), global.Part2, 1);
}

function create_bullet_particle()
{
	part_type_scale(global.Part3, Speed / 8, 1);
	part_type_orientation(global.Part3, image_angle, image_angle, 0, 0, 0);
	part_type_colour1(global.Part3, image_blend);
	part_particles_create(global.PartSys2, x, y, global.Part3, 1);
}

function add_damage_number(_x, _y, n, c)
{
	ds_list_add(obj_Manager.DamageNum, [_x, _y, 80, n, c]);
}

function bullet_damage()
{
	var dir = point_direction(x, y, other.x, other.y);
	HSP -= dcos(dir) * (other.Speed / 20);
	VSP += dsin(dir) * (other.Speed / 20);
		
	if (Shield > 0) { Shield -= other.SDamage; add_damage_number(other.x, other.y - Size, other.SDamage, global.C_BLUE); }
	else { Hull -= other.Damage; add_damage_number(other.x, other.y - Size, other.Damage, c_white); }
	ShieldRegen = 0;
}