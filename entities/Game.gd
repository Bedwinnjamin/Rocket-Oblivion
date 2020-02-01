extends Node

var working_stations = [false,false,false,false,false,false,false]
var resources = [0,0,0,0,0,0,0]

var fuel
var oxygen
var shields
var hull
var rads
var plants
var galaxy


func _ready():
	var stations = get_tree().get_nodes_in_group("station")
	for s in stations:
		s.connect("working_status", self, "_station_working")
	var bars = get_tree().get_nodes_in_group("bar")
	for b in bars:
		self.connect("resource_update", b, "_update_resource")


func _station_working(station_id,status):
	working_stations[station_id-1] = status


func _on_Generate_timeout():
	for i in range(0, working_stations.size()):
		if working_stations[i] == true:
			resources[i]+=5
			emit_signal("resource_update", i, resources[i])
		
		pass
