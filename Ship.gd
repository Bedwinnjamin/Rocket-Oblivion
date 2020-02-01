extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Crew.connect("start_work", self, "_start_work")
	$Crew.connect("stop_work", self, "_stop_work")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
