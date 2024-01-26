/// Step

depth = -y;

if (sprite_index == spr_Circle) // Standard projectile
{
	if (Build < 0.7) // charge animation
	{
		if (instance_exists(Creator))
		{
			x = Creator.x + lengthdir_x(Creator.Size, Creator.image_angle);
			y = Creator.y + lengthdir_y(Creator.Size, Creator.image_angle);
	
			Build += 0.1;
			image_xscale = Build;
			image_yscale = Build;
		
			if (Build >= 0.7) image_angle = Creator.image_angle + random_range(-Spread, Spread);
		}
		else
		{
			part_particles_create(global.PartSys, x, y, global.Part1, 1);
			instance_destroy();
		}
	}
	else // fire
	{
		Speed *= 1.05;
		motion_set(image_angle, Speed);
		image_xscale = Speed / 12;
		if (image_yscale > 0.5) image_yscale *= 0.95;
		if (Trail >= 1) create_bullet_particle();
	}
}
else // Missiles
{
	Speed *= 1.02;
	motion_set(image_angle, Speed);
	Size = sprite_width / 3;
	create_exhaust_particle(5);
}

// Collision (if proj speed > target speed)
var col = collision_line(x, y, x + dcos(image_angle) * Speed, y - dsin(image_angle) * Speed, par_Ship, 0, 1);
if (col)
{
	if (Group != col.Group and Ally != col.Ally)
	{
		with (col) bullet_damage();
		
		part_particles_create(global.PartSys, x, y, global.Part1, 1);
		instance_destroy();
	}
}

if (point_distance(x, y, cX, cY) > Range)
{
	part_particles_create(global.PartSys, x, y, global.Part1, 1);
	instance_destroy();
}