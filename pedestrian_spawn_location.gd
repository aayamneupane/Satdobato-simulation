extends Position2D

export var location: String
onready var timer = $Timer
export var pedestrian_move_direction: Vector2
export var disabled:bool = false

var rng = RandomNumberGenerator.new()

func _ready():
	if !disabled:
		rng.randomize()
		timer.wait_time = rng.randf_range(2.0, 5.0)
		timer.start()


func _on_Timer_timeout():
	rng.randomize()
	Global.emit_signal("spawn_pedestrian", location, position, pedestrian_move_direction)
	timer.wait_time = rng.randf_range(5.0, 25.0)

