extends Node2D

func _ready():
	$RichTextLabel.set_scroll_follow(true)

func _show_message(message):
	$RichTextLabel.text += message + '\n'
	
func _clear_message():
	$RichTextLabel.text = ""

