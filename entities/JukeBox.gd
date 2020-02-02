extends Node

func insert_coin(station,status,crew):
	if(status):
		get_node("Station"+str(station))._switch_music(crew)
	else:
		get_node("Station"+str(station))._turn_off()
