extends Node2D


export (PackedScene) var car_scene
export (PackedScene) var pedestrian_scene

var speed = 100

var points: PoolVector2Array

var rng = RandomNumberGenerator.new()

var velocity = Vector2.ZERO

var target

var path: Path2D


onready var path_arr = [$path_0, $path_1, $path_2, $path_3, $path_4, $path_5, $path_6, $path_7, $path_8, $path_9, $path_10, $path_11]
onready var lights_arr = [$traffic_light_left, $traffic_light_up, $traffic_light_right, $traffic_light_down]
var light_index = 0

func _ready():
	
	rng.randomize()
	Global.connect("spawn_car", self, "_on_spawn_car")
	Global.connect("spawn_pedestrian", self, "_on_spawn_pedestrian")
	Global.traffic_lights = lights_arr
	for index in lights_arr.size():
		if index == 0:
			lights_arr[0].start()
		
	
func _on_spawn_car(p_lane_name, p_position, path_index, p_initial_rotation):

#	if(p_lane_name == "left_lane_1"):
		var car:KinematicBody2D = car_scene.instance()
		car.position = p_position
		car.rotation_degrees = p_initial_rotation
#		var path = []
#		for i in path_arr_light_index:
#			path.append(path[i])
		car.set_path(path_arr[path_index])
		add_child(car)

func _on_spawn_pedestrian(p_location, p_position, p_direction):

	var pedestrian = pedestrian_scene.instance()
	pedestrian.position = p_position
	pedestrian.direction = p_direction
	add_child(pedestrian)
