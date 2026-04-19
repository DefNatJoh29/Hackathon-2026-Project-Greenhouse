extends Path2D

@export var enemy_spawn: PackedScene
@export var attacker: PackedScene
func _on_timer_timeout() -> void:	
	print("timer over") 
	var new_enemy = enemy_spawn.instantiate()
	add_child(new_enemy)
