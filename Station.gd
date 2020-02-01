extends Node2D

export (int) var station_id
var is_working = false

func _ready():
	$Crew.connect("start_work", self, "_start_work")
	$Crew.connect("stop_work", self, "_stop_work")

func _start_work():
	is_working = true
	
func _stop_work():
	is_working = true
