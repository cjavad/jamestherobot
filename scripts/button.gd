extends Button
var mapdata setget set_mapdata
func set_mapdata(value):
	mapdata = value

func _on_button_up():
	var file = File.new();
	file.open("user://current_level.json", file.WRITE);
	file.store_string(mapdata);
	get_tree().change_scene("res://scenes/leveln.tscn");
