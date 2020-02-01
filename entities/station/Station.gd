extends Node2D

signal selected
signal working_status

export (int) var station_id


func _ready():
	pass


func _start_work(id):
	if station_id == id:
		emit_signal("working_status", station_id, true)
		#print("I am Working: Station - " + str(station_id))


func _stop_work(id):
	if station_id == id:
		emit_signal("working_status", station_id, false)


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("selected", self)
