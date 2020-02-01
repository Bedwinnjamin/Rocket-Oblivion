extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get arrays of crew and station nodes in the Ship
	var crews = get_tree().get_nodes_in_group("crew")
	var stations = get_tree().get_nodes_in_group("station")
	
	# Connect each Crew member to stations
	for c in crews:
		for s in stations:
			c.connect("start_work", s, "_start_work")
			c.connect("stop_work", s, "_stop_work")

#	$Crew_Members/Crew1.connect("start_work", $Stations/Station1, "_start_work")
#	$Crew_Members/Crew1.connect("stop_work", $Stations/Station1, "_stop_work")
#	$Crew_Members/Crew1.connect("start_work", $Stations/Station2, "_start_work")
#	$Crew_Members/Crew1.connect("stop_work", $Stations/Station2, "_stop_work")
#	$Crew_Members/Crew1.connect("start_work", $Stations/Station3, "_start_work")
#	$Crew_Members/Crew1.connect("stop_work", $Stations/Station3, "_stop_work")
#	$Crew_Members/Crew1.connect("start_work", $Stations/Station4, "_start_work")
#	$Crew_Members/Crew1.connect("stop_work", $Stations/Station4, "_stop_work")
#	$Crew_Members/Crew1.connect("start_work", $Stations/Station5, "_start_work")
#	$Crew_Members/Crew1.connect("stop_work", $Stations/Station5, "_stop_work")
#	$Crew_Members/Crew1.connect("start_work", $Stations/Station6, "_start_work")
#	$Crew_Members/Crew1.connect("stop_work", $Stations/Station6, "_stop_work")
#	$Crew_Members/Crew1.connect("start_work", $Stations/Station7, "_start_work")
#	$Crew_Members/Crew1.connect("stop_work", $Stations/Station7, "_stop_work")
	
