extends KinematicBody2D


var path
var points: PoolVector2Array
var speed = 110
var velocity: Vector2
var target
var index = 0
var face_vector
var no_of_paths
var can_move: bool = true
var has_crossed: bool = false

func _ready():
	
	var frame_names = $cars.frames.get_animation_names()
	$cars.animation = frame_names[randi() % frame_names.size()]
	
	
func set_path(p_path):
	path = p_path
#	no_of_paths = p_path.size()
	points = path.curve.get_baked_points()
#	position = points[0]

func _process(delta):
	
	if !path:
			return
			
	target = points[index]
	
	if(can_move or has_crossed):
		
		if position.distance_to(target) < 5:
			index = wrapi(index + 1, 0, points.size())
			target = points[index]
			
		face_vector = (target - position).normalized()
		velocity = face_vector * speed
		velocity = move_and_slide(velocity)
		rotation = face_vector.angle()


#	if !path:
#		return
#
#	if(can_move or has_crossed):
##
##		if (index == points.size() - 1):
##			points = path[(randi() % (no_of_paths - 1)) + 1].curve.get_baked_points()
#		index = 0
##		target = points[index]
#
#		if (position.distance_to(target) < 1):
#			index = wrapi(index + 1, 0, points.size())
#			target = points[index]
#
#		face_vector = (target - position).normalized()
#		velocity = face_vector * speed
#
#
#
#		$Tween.interpolate_property(self, "rotation", rotation, face_vector.angle(), 0.2)
#		$Tween.start()
#
#		velocity = move_and_slide(velocity)



func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()


func _on_detector_body_entered(p_body):
	
#	print(p_body)
	speed = 0
	can_move = false
#	p_body.speed = 0

func _on_detector_body_exited(body):
	can_move = true
	randomize()
	speed += randi() % 34 + 60
	


func _on_detector_area_entered(area):
#	speed = 60
	pass


func _on_detector_area_exited(area):
	var elapsed = 0.0
	while speed < 110:
		speed = lerp(speed, 110, elapsed)
		elapsed += 0.05
