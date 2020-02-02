extends Node2D

func _show_message(message):
	$Panel/RichTextLabel.text += message + '\n'
	
func _clear_message():
	$Panel/RichTextLabel.text = ""

