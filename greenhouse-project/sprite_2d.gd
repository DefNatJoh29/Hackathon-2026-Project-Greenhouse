extends StaticBody2D

@onready var cooldown_timer = $Timer

var enemies_in_range = []
var can_attack = true

func _on_detection_area_body_entered(body):
	if body.is_in_group("enemy"):
		enemies_in_range.append(body)

func _on_detection_area_body_exited(body):
	enemies_in_range.erase(body)

func _process(_delta):
	if enemies_in_range.size() > 0:
		var target = enemies_in_range[0]
		
		# Make the arm point toward the enemy
		
		if can_attack:
			punch_target(target)

func punch_target(target):
	can_attack = false	
	if target.has_method("take_damage"):
		target.take_damage(10)
		
	cooldown_timer.start()

func _on_attack_cooldown_timeout():
	can_attack = true
