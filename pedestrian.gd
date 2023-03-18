extends KinematicBody2D


var speed: int
var direction: Vector2
var velocity: Vector2
var can_move: bool = true
var has_crossed: bool = false

onready var people = $people

func _ready():
	randomize()
	
	people.playing = true

	var frame_names = people.frames.get_animation_names()
	people.animation = frame_names[randi() % frame_names.size()]

	speed = rand_range(50.0, 70.0)

func _process(delta):
	
	if (can_move or has_crossed):
		
		match direction:
			
			Vector2(1, 0):
				rotation_degrees = 90
				
			Vector2(-1, 0):
				rotation_degrees = -90
				
			Vector2(0, 1):
				rotation_degrees = 180
				
			_:
				rotation_degrees = 0
				
		velocity = direction * speed
		move_and_collide(velocity * delta)
		



func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()


func _on_detector_body_entered(p_body) -> void:
	
	speed = 0
	$stuck_timer.start()
	people.playing = false
	
func _on_detector_body_exited(p_body) -> void:
	
	$stuck_timer.stop()
	people.playing = true
	randomize()
	speed += randi() % 60 + 60


func _on_stuck_timer_timeout() -> void:
	
	people.playing = true
	
	direction = direction * -1
	
	yield(get_tree().create_timer(1), "timeout")
	
	direction = direction * -1
	
