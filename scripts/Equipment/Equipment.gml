/// Equipment

function equipment_heat(ID)
{
	if (ID < 99)
	{
		array = [15, 60, 50, 50, 10, // Standard
		25, 80, 80]; // Heavy
		
		// Times consecutively fired before Overheat (Cooldown: 10):
		// [9, 2, 3, 3, 11,
		// 5, 1, 1]
		
		return array[ID];
	}
}



// Weapons
function weapon_name(ID)
{
	array = ["Light Shot", "Railgun", "Light Missile", "Light Burst", "Spitfire",
	"Heavy Shot", "Heavy Missile", "Heavy Burst"];
	return array[ID];
}

function weapon_cooldown(ID)
{
	array = [30, 180, 180, 180, 6, 40, 180, 180];
	return array[ID];
}

function weapon_range(ID)
{
	array = [600, 800, 600, 500, 500, 600, 500, 500];
	return array[ID];
}

function weapon_damage(ID)
{
	array = [1, 5, 4, 1, 1, 2, 7, 1];
	return array[ID];
}

function weapon_sdamage(ID)
{
	array = [1, 1, 3, 1, 1, 1, 6, 1];
	return array[ID];
}

function weapon_missiles(ID)
{
	array = [0, 0, 1, 0, 0, 0, 1, 0];
	return array[ID];
}

function weapon_dir_max(ID) // AI
{
	array = [6, 4, 6, 4, 6, 5, 6, 4];
	return array[ID];
}

function weapon_fire(ID)
{
	switch (ID)
	{
		case 0: // Light Shot
			var p = instance_create_depth(x + lengthdir_x(Size, image_angle), y + lengthdir_y(Size, image_angle), 0, obj_Proj);
			p.Creator = id;
			p.Group = Group;
			p.Ally = Ally;
			p.Speed = 6;
			p.Range = weapon_range(ID);
			p.Damage = weapon_damage(ID);
			p.SDamage = weapon_sdamage(ID);
			p.image_blend = Colour;
			break;
			
		case 1: // Railgun
			var p = instance_create_depth(x + lengthdir_x(Size, image_angle), y + lengthdir_y(Size, image_angle), 0, obj_Proj);
			p.Creator = id;
			p.Group = Group;
			p.Ally = Ally;
			p.Speed = 18;
			p.Range = weapon_range(ID);
			p.Damage = weapon_damage(ID);
			p.SDamage = weapon_sdamage(ID);
			p.image_blend = Colour;
			p.Trail = 1;
			break;
			
		case 2: // Light Missile
			var p = instance_create_depth(x + lengthdir_x(Size, image_angle), y + lengthdir_y(Size, image_angle), 0, obj_Proj);
			p.Creator = id;
			p.Group = Group;
			p.Ally = Ally;
			p.Speed = 4;
			p.Range = weapon_range(ID);
			p.Damage = weapon_damage(ID);
			p.SDamage = weapon_sdamage(ID);
			p.sprite_index = spr_Missile;
			p.image_index = 0;
			p.image_xscale = 1;
			p.image_yscale = 1;
			p.image_angle = image_angle;
			break;
			
		case 3: // Light Burst
			for (var i = 0; i < 8; i++)
			{
				var p = instance_create_depth(x + lengthdir_x(Size, image_angle), y + lengthdir_y(Size, image_angle), 0, obj_Proj);
				p.Creator = id;
				p.Group = Group;
				p.Ally = Ally;
				p.Speed = random_range(1, 3);
				p.Spread = 6;
				p.Range = weapon_range(ID);
				p.Damage = weapon_damage(ID);
				p.SDamage = weapon_sdamage(ID);
				p.image_blend = Colour;
			}
			break;
			
		case 4: // Spitfire
			var p = instance_create_depth(x + lengthdir_x(Size, image_angle), y + lengthdir_y(Size, image_angle), 0, obj_Proj);
			p.Creator = id;
			p.Group = Group;
			p.Ally = Ally;
			p.Speed = 5;
			p.Spread = 5;
			p.Range = weapon_range(ID);
			p.Damage = weapon_damage(ID);
			p.SDamage = weapon_sdamage(ID);
			p.image_blend = Colour;
			break;
			
		case 5: // Heavy Shot
			var p = instance_create_depth(x + lengthdir_x(Size, image_angle), y + lengthdir_y(Size, image_angle), 0, obj_Proj);
			p.Creator = id;
			p.Group = Group;
			p.Ally = Ally;
			p.Speed = 8;
			p.Range = weapon_range(ID);
			p.Damage = weapon_damage(ID);
			p.SDamage = weapon_sdamage(ID);
			p.image_blend = Colour;
			break;
			
		case 6: // Heavy Missile
			var p = instance_create_depth(x + lengthdir_x(Size, image_angle), y + lengthdir_y(Size, image_angle), 0, obj_Proj);
			p.Creator = id;
			p.Group = Group;
			p.Ally = Ally;
			p.Speed = 4;
			p.Range = weapon_range(ID);
			p.Damage = weapon_damage(ID);
			p.SDamage = weapon_sdamage(ID);
			p.sprite_index = spr_Missile;
			p.image_index = 1;
			p.image_xscale = 2;
			p.image_yscale = 1;
			p.image_angle = image_angle;
			break;
			
		case 7: // Heavy Burst
			for (var i = 0; i < 14; i++)
			{
				var p = instance_create_depth(x + lengthdir_x(Size, image_angle), y + lengthdir_y(Size, image_angle), 0, obj_Proj);
				p.Creator = id;
				p.Group = Group;
				p.Ally = Ally;
				p.Speed = random_range(1, 3);
				p.Spread = 8;
				p.Range = weapon_range(ID);
				p.Damage = weapon_damage(ID);
				p.SDamage = weapon_sdamage(ID);
				p.image_blend = Colour;
			}
			break;
	}
}



// Systems
function system_name(ID)
{
	
}

function system_cooldown(ID)
{
	
}

function system_use(ID)
{
	
}