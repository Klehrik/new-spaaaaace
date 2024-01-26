/// Collision

if (Team != other.Team)
{
	//var dir = point_direction(x, y, other.x, other.y);
	//HSP -= dcos(dir) * (other.Speed / 20);
	//VSP += dsin(dir) * (other.Speed / 20);
	
	if (Shield > 0) Shield = clamp(Shield - other.SDamage, 0, MaxShield);
	else Hull -= other.Damage;
	ShieldRegen = 0;
	
	instance_destroy(other);
}