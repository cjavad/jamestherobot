extends Node

class BuildableTile:
	var count: int = 0;
	var scene: PackedScene;

export var tiles: Dictionary = {};
export var buildable_tiles: Array = [];

var tiles_ui: TilesUI;
var building_tile: int = 0;
var hovered_tile: Tile;
var dragging: bool = false;

onready var tile_ui: PackedScene = preload("res://prefabs/ui/tile_ui.tscn");

func _input(event: InputEvent):
	# if evaluation is running do nothing
	if GameManager.running:
		return;
	
	if event is InputEventMouseButton:
		var building_tile: BuildableTile = self.buildable_tiles[self.building_tile];
		
		# if building is valid, instance tile and replace the old one
		if event.is_released() and self.dragging:
			self.dragging = false;
			
			if building_tile.count > 0:
				building_tile.count -= 1;
				
				var p: Vector3 = self.hovered_tile.global_transform.origin;
				
				var instance: Tile = building_tile.scene.instance();
				instance.global_transform.origin = p;
				
				self.tiles[self.hovered_tile.x][self.hovered_tile.y] = instance;
				
				self.hovered_tile.queue_free();

func add_tile(tile: Tile):
	if not self.tiles.has(tile.x):
		self.tiles[tile.x] = { tile.y: tile };
	else:
		self.tiles[tile.x][tile.y] = tile;

func has_tile(x: int, y: int) -> bool:
	if not self.tiles.has(x):
		return false;
	
	return self.tiles[x].has(y);

func init_tiles_ui() -> void:
	for i in range(self.buildable_tiles.size()):
		var tile: BuildableTile = self.buildable_tiles[i];
		
		var instance: TileUI = self.tile_ui.instance();
		instance.set_tile(tile.scene, i);
		self.tiles_ui.get_node("HBoxContainer").add_child(instance);
