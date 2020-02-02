extends Node2D

#signal deselect

var crew_stations = [-1,-1,-1]
var selected_crew
var error

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Flameo")
	$AnimationPlayer2.play("Flameo2")
	# Get arrays of crew and station nodes in the Ship
	var crews = get_tree().get_nodes_in_group("crew")
	var stations = get_tree().get_nodes_in_group("station")
	
	# Connect each Crew member to stations
	for c in crews:
		#error = self.connect("deselect", c, "_deselect")
		c.connect("selected", self, "_selected")
		for s in stations:
			c.connect("start_work", s, "_start_work")
			c.connect("stop_work", s, "_stop_work")
	for s in stations:
		#error = self.connect("deselect", s, "_deselect")
		s.connect("selected", self, "_selected")

func _selected(current_node):
	print(current_node)
	if current_node.is_in_group("crew"):
		selected_crew = current_node
		print("Selected Crew: " + str(current_node.crew_id))
	elif current_node.is_in_group("station"):
		if selected_crew == null:
			pass
		elif selected_crew.station != current_node.station_id:
			if (!_station_used(current_node.station_id)):
				selected_crew._go_to_station(current_node.position, current_node.station_id)
				crew_stations[selected_crew.crew_id] = current_node.station_id
				selected_crew = null

func _station_used(station_id):
	for x in crew_stations:
		if x == station_id:
			return true
	return false

# Move an Area 2D to where the mouse is and determine if you're not clicking an object
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		#emit_signal("deselect")
		selected_crew = null
		

#	$Crew_Members/Crew1.connect("start_work", $Stations/Station1, "_start_work")
#	$Crew_Members/Crew1.connect("stop_work", $Stations/Station1, "_stop_work")


func _on_Deselect_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		print("deselect")
