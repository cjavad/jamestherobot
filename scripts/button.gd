extends Button

var mappath setget set_map
func set_map(value):
	mappath = value

func _on_Button_pressed():
	GameManager.selected_map = mappath;
	get_tree().change_scene("res://scenes/leveln.tscn");
