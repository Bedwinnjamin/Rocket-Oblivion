extends Node2D

signal selected
signal working_status

export (int) var station_id

# 
func _start_work(id, crew):
	if station_id == id:
		emit_signal("working_status", station_id, true, crew)
		$On.show()
		$Off.hide()

#
func _stop_work(id, crew):
	if station_id == id:
		emit_signal("working_status", station_id, false, crew)
		$On.hide()
		$Off.show()

# 
func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("selected", self)
