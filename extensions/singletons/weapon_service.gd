extends "res://singletons//weapon_service.gd"


func explode(effect:Effect, pos:Vector2, damage:int, accuracy:float, crit_chance:float, crit_dmg:float, burning_data:BurningData, is_healing:bool = false, ignored_objects:Array = [], damage_tracking_key:String = "")->Node:
	var main = get_tree().current_scene
	var instance = effect.explosion_scene.instance()
	instance.set_deferred("global_position", pos)
	main.call_deferred("add_child", instance)
	instance.set_deferred("sound_db_mod", effect.sound_db_mod)
	instance.call_deferred("set_damage_tracking_key", damage_tracking_key)
	instance.call_deferred("set_damage", damage, accuracy, crit_chance, crit_dmg, burning_data, is_healing, ignored_objects)
	instance.call_deferred("set_smoke_amount", round(effect.scale * effect.base_smoke_amount))
	# pre calculate area
	var explosion_scale = max(0.1, effect.scale + (effect.scale * (Utils.get_stat("explosion_size") / 100.0)))
	instance.call_deferred("set_area", explosion_scale)
	return instance

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass