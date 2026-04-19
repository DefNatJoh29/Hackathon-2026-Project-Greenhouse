extends StaticBody2D

@export var bullet_scene: PackedScene
@export var fire_rate: float = 1.0

var enemies_in_range = []
var current_target = null
var can_fire = true

func _ready():
	$Timer.wait_time = fire_rate

func _on_range_area_entered(area):
	if area.is_in_group("enemy"):
		enemies_in_range.append(area)

func _on_range_area_exited(area):
	enemies_in_range.erase(area)

func _process(_delta):
	select_target()
	if current_target and can_fire:
		fire()

func select_target():
	var best_target = null
	var max_progress = -1.0
	
	for enemy in enemies_in_range:
		if is_instance_valid(enemy):
			# We assume the parent of the Area2D is the PathFollow2D
			var path_node = enemy.get_parent() 
			if path_node is PathFollow2D:
				if path_node.progress > max_progress:
					max_progress = path_node.progress
					best_target = enemy
	
	current_target = best_target

func fire():
	can_fire = false
	var bullet = bullet_scene.instantiate()
	bullet.target = current_target
	bullet.global_position = $Marker2D.global_position
	get_tree().root.add_child(bullet)
	
	$Timer.start()

func _on_timer_timeout():
	can_fire = true
