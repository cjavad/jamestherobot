extends Container
class_name TileUI

var tile: Tile;
var index: int;
var hovered: bool = false;

func set_tile(tile: PackedScene, index: int) -> void:
	var instance: Tile = tile.instance();
	
	self.tile = instance;
	self.index = index;
	$Viewport.add_child(self.tile);

func set_count(count: int) -> void:
	$Label.text = count as String;

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if self.hovered and event.is_pressed():
			TileManager.building_tile = self.index;
			TileManager.dragging = true;


func _on_mouse_entered() -> void:
	self.hovered = true;


func _on_mouse_exited() -> void:
	self.hovered = false;
