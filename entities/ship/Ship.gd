extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Crew_Members/Crew1.connect("start_work", $Stations/Station1, "_start_work")
	$Crew_Members/Crew1.connect("stop_work", $Stations/Station1, "_stop_work")
