extends Button
var mapdata setget set_mapdata
func set_mapdata(value):
	mapdata = value

func _on_Button_pressed():
	print(mapdata);
	var fileC = File.new();
	var file = File.new();
	file.open("res://maps/" + mapdata, file.READ);
	file.open("user://current_level.json", file.WRITE);
	file.store_string(fileC.get_as_text());
	file.close();
	fileC.close();
	get_tree().change_scene("res://scenes/leveln.tscn");
