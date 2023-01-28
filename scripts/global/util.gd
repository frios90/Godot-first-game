extends Node

func round_dicimal (number, dec) :
	number = float(number)
	dec = int(dec)
	var sgn = 1
	if number < 0:
		sgn = -1
		number = abs(number)

	var num_fraction = number - int(number) 
	var num_dec = round(num_fraction * pow(10.0, dec)) / pow(10.0, dec)
	var round_num = sgn*(int(number) + num_dec)
	return round_num


func apply_damage_body (attack, defense):
	var damage =  attack - (defense * 0.5)
	damage = damage if damage > 0 else 10
	return damage
	
func get_an_script (script):
	return get_tree().get_root().find_node(script, true,false)

