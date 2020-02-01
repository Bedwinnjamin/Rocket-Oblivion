extends Node2D

signal selected

export (int) var station_id
var is_working = false
var is_selected

func _ready():
	pass
	#$Crew.connect("start_work", self, "_start_work")
	#$Crew.connect("stop_work", self, "_stop_work")

func _start_work(id):
	if station_id == id:
		is_working = true
		#print("I am Working: Station - " + str(station_id))

func _stop_work(id):
	if station_id == id:
		is_working = false

func _deselect():
	is_selected = false


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("selected", self)
