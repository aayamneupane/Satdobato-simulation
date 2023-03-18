extends Node2D

onready var traffic_lights = $lights
var red
var green
var yellow

var state : int = Global.Traffic_Light.RED

export var allocation: int
export var red_time:int
export var yellow_time:int
export var green_time:int


func _ready():
	pass
	
func red_light():
	traffic_lights.animation = "red_light"
	state = Global.Traffic_Light.RED
	Global.emit_signal("signal_change", self, state)
	yield(get_tree().create_timer(green_time), "timeout")



func yellow_light():
	traffic_lights.animation = "yellow_light"
	state = Global.Traffic_Light.YELLOW
	Global.emit_signal("signal_change", self, state)
	var index = Global.traffic_lights.find(self)
	var next = index +1
	if index + 1 > Global.traffic_lights.size() - 1:
		next = 0
	Global.traffic_lights[next].start()
	yield(get_tree().create_timer(yellow_time), "timeout")



func green_light():
	traffic_lights.animation = "green_light"
	state = Global.Traffic_Light.GREEN
	Global.emit_signal("signal_change", self, state)
	yield(get_tree().create_timer(green_time), "timeout")



func start():
	yield(green_light(), "completed")
	yield(yellow_light(), "completed")
	yield(red_light(), "completed")
	
