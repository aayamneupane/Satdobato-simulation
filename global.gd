extends Node

signal spawn_car
signal signal_change(traffic_light_name, light_state)
signal spawn_pedestrian

enum Traffic_Light {
	RED,
	GREEN,
	YELLOW,
}

var traffic_lights:Array = []

#var current_light = Traffic_Light.RED

#
#func change_light(val):
#	current_light = val
#	emit_signal("signal_change",val)
#
#
#func _ready():
#	if (current_light == Traffic_light_state.GREEN):
#		emit_signal("signal_change")
