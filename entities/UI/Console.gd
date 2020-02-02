extends Node2D

func _show_message(message):
	$Panel/RichTextLabel.text += message + '\n'
	
func _clear_message():
	$Panel/RichTextLabel.text = ""
	
func _update_clock(message):
	$Panel2/Label.text = message
	
func _clear_clock():
	$Panel2/Label.text = ""

