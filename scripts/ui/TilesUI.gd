extends Container
class_name TilesUI

var tiles: Array = [];

func _ready() -> void:
	TileManager.tiles_ui = self;


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/ui.tscn");
	pass # Replace with function body.
