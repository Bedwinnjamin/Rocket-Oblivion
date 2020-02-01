extends Node2D

export (int) var station_id
var is_working = false

func _ready():
	pass
	#$Crew.connect("start_work", self, "_start_work")
	#$Crew.connect("stop_work", self, "_stop_work")

func _start_work(id):
	if station_id == id:
		is_working = true
		print("I am Working: Station - " + str(station_id))
	
	
func _stop_work(id):
	if station_id == id:
		is_working = false
