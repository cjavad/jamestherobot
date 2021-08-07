extends Container
class_name TilesUI

var tiles: Array = [];

func _ready() -> void:
	TileManager.tiles_ui = self;
