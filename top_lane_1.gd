extends Position2D

export var lane_name: String
export var initial_rotation: int =0

export var path_index: int
onready var timer = $Timer


var rng = RandomNumberGenerator.new()

func _ready():
	
	rng.randomize()
	timer.wait_time = rng.randf_range(3.0, 20.0)
	timer.start()


func _on_Timer_timeout():
	
	rng.randomize()
	Global.emit_signal("spawn_car", lane_name, position, path_index, initial_rotation)
	timer.wait_time = rng.randf_range(30.0, 60.0)
	timer.start()
