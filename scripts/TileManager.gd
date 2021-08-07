extends Node

export var tiles: Dictionary = {};

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
