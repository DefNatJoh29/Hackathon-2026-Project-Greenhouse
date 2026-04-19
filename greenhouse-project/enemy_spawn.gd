extends PathFollow2D

@export var speed: float = 200


func _process(delta: float) -> void:
	var currentp: float=progress
	progress += delta*speed
	if (currentp-progress)>0:
		queue_free()
	
	
