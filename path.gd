extends Node2D


onready var car = $cars
onready var path = $Path2D

var speed = 200
#var target
var points: PoolVector2Array
var current: Vector2
var velocity: Vector2
var light_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	points = path.curve.get_baked_points()
	
#	print(points)
##	car.position = points[0]


func _physics_process(_delta):
	
	if !path:
		return
		
	var target = points[light_index]
	
	if car.position.distance_to(target) < 1:
		light_index = wrapi(light_index + 1, 0, points.size())
		target = points[light_index]
		
	velocity = (target - car.position).normalized() * speed
	
	velocity = car.move_and_slide(velocity)
	
#	print(light_index)
	print(car.position)
	print (target)
#func _physics_process(delta):
#	if ((points[light_index] - car.position).normalized() > 1):
#		print(points[light_index])
#		if light_index >= (points.size() -1):
#			light_index = 0
#		car.move_and_slide((points[light_index + 1] - position).normalized() * 40)
##		position = points[light_index + 1]
#		print(position)
#	else:
#		print("yi")
#		light_index += 1
