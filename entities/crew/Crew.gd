extends Node2D

signal start_work
signal stop_work
signal selected

export (int) var crewmember

var station = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _work_station():
	emit_signal("start_work", station)

func _leaving_station():
	emit_signal("stop_work", station)

func _go_to_station(station_position):
	self.position = station_position
	pass


# Check to see if the crew is LEFT CLICKED
func _on_Area2D_input_event(event,viewport,shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("selected", self)
