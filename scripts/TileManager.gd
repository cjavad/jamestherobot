extends Node

class BuildableTile:
	var count: int = 0;
	var scene: PackedScene;

export var tiles: Dictionary = {};
export var buildable_tiles: Array = [];

var tiles_ui: TilesUI;
var building_tile: int = 0;
var dragging: bool = false;

onready var tile_ui: PackedScene = preload("res://prefabs/ui/tile_ui.tscn");

func add_tile(tile: Tile):
	var x: int = round(tile.global_transform.origin.x) as int;
	var y: int = round(tile.global_transform.origin.z) as int;
	
	if not self.tiles.has(x):
		self.tiles[x] = { y: tile };
	else:
		self.tiles[x][y] = tile;

func has_tile(x: int, y: int) -> bool:
	if not self.tiles.has(x):
		return false;
	
	return self.tiles[x].has(y);

func init_tiles_ui() -> void:
	for i in range(self.buildable_tiles.size()):
		var tile: BuildableTile = self.buildable_tiles[i];
		
		var instance: TileUI = self.tile_ui.instance();
		instance.set_tile(tile.scene, i);
