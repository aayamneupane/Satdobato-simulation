extends Area2D

export var traffic_light_allocation: int
var state:int
var stopped_cars: Array = []
var stopped_pedestrians: Array = []


var allocation = {
	0:"traffic_light_left",
	1:"traffic_light_up",
	2:"traffic_light_right",
	3:"traffic_light_down",
	}
	
func _ready():
	Global.connect("signal_change", self, "change_traffic_light")


func _on_cross_walk_base_body_entered(p_body) -> void:
	
	if "pedestrians" in p_body.get_groups():
		
		if !p_body.has_crossed:
#			state = Global.traffic_lights[traffic_light_allocation].state
			if (state == Global.Traffic_Light.GREEN):
				stopped_pedestrians.append(p_body)
				p_body.can_move = false
				p_body.get_child(0).playing = false
				
func change_traffic_light(p_node: Node, p_state: int) -> void:
	if p_node.allocation == traffic_light_allocation:

		state = p_node.state
		
#		match state:
#			Global.Traffic_Light.GREEN:

		if (state == Global.Traffic_Light.GREEN):
#			if stopped_cars.size() > 0: 
			while stopped_cars.size() > 0:
				stopped_cars[0].can_move = true
				stopped_cars.remove(0)
					
		if (state == Global.Traffic_Light.RED or Global.Traffic_Light.YELLOW):
			while stopped_pedestrians.size() > 0: 
				stopped_pedestrians[0].get_child(0).playing = true
				stopped_pedestrians[0].can_move = true
				stopped_pedestrians.remove(0)


func _on_cross_walk_base_area_entered(area):
	var body = area.get_parent()
	state = Global.traffic_lights[traffic_light_allocation].state
	if "car" in body.get_groups():
		if !body.has_crossed:
			match state:
				Global.Traffic_Light.RED:
					body.can_move = false
					stopped_cars.append(body)
					
				Global.Traffic_Light.YELLOW:
					body.can_move = false
					stopped_cars.append(body)


func _on_cross_walk_base_body_exited(body):
	body.has_crossed = true
