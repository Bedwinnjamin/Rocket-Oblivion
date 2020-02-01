extends Node2D

export (int) var station_id
var is_working = false

func _ready():
	pass
	#$Crew.connect("start_work", self, "_start_work")
	#$Crew.connect("stop_work", self, "_stop_work")

func _start_work(worked_id):
	if station_id == worked_id
	is_working = true
	
func _stop_work(station_id):
	is_working = false
