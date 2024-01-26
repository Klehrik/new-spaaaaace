/// Collision

if (Group != other.Group and Ally != other.Ally)
{	
	with (other) bullet_damage();
	
	part_particles_create(global.PartSys, x, y, global.Part1, 1);
	instance_destroy();
}