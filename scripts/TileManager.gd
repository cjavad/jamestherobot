extends Spatial

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
	if event is InputEventMouseMotion:
		var viewport: Viewport = self.get_viewport();
		
		if viewport == null:
			self.hovered_tile = null;
			return;
		
		var camera: Camera = viewport.get_camera();
		
		if camera == null:
			self.hovered_tile = null;
			return;
		
		var space_state: PhysicsDirectSpaceState = self.get_world().direct_space_state;
		
		var from = camera.project_ray_origin(event.position);
		var to = from + camera.project_ray_normal(event.position) * 1000.0;
		
		var result = space_state.intersect_ray(from, to, [], !0, false, true);
		
		if result.size() > 0:
			self.hovered_tile = result["collider"];
		else:
			self.hovered_tile = null;
	
	if event is InputEventMouseButton:
		if not event.is_pressed() and self.hovered_tile != null and event.button_index == BUTTON_LEFT:
			self.build_tile(self.hovered_tile);
		elif event.is_pressed() and event.button_index == BUTTON_RIGHT:
			self.remove_tile(self.hovered_tile);

func remove_tile(tile: Tile):
	if GameManager.running:
		return;
	
	if tile.replacing != null:
		var idx: int = tile.replacing.idx;
		var buildable_tile: BuildableTile = self.buildable_tiles[idx];
		var old: Tile = tile.replacing.tile;
		
		buildable_tile.count += 1;
		self.tiles_ui.tiles[idx].set_count(buildable_tile.count);
		
		old.visible = true;
		old.collision_layer = 0b1;
		self.tiles[tile.x][tile.y] = old;
		self.hovered_tile = old;
		
		tile.queue_free();

func build_tile(tile: Tile):
	# if evaluation is running do nothing
	if GameManager.running:
		return;
	
	if self.dragging:
		self.dragging = false;
		
		var building_tile: BuildableTile = self.buildable_tiles[self.building_tile];
		
		if building_tile.count > 0:
			building_tile.count -= 1;
			
			self.tiles_ui.tiles[self.building_tile].set_count(building_tile.count);
			
			var p: Vector3 = tile.global_transform.origin;
			
			if tile.replacing != null:
				var idx: int = tile.replacing.idx;
				var replaced_tile: BuildableTile = self.buildable_tiles[idx];
				replaced_tile.count += 1;
				self.tiles_ui.tiles[idx].set_count(replaced_tile.count);
			
			var instance: Tile = building_tile.scene.instance();
			instance.global_transform.origin = p;
			instance.x = tile.x;
			instance.y = tile.y;
			
			instance.replacing = Tile.ReplacedTile.new();
			instance.replacing.idx = self.building_tile;
			self.hovered_tile = instance;
			
			if tile.replacing == null:
				instance.replacing.tile = tile;
			else:
				instance.replacing.tile = tile.replacing.tile;
			
			tile.visible = false;
			tile.collision_layer = 0b0;
			
			self.tiles[tile.x][tile.y] = instance;
			
			self.get_node("/root").get_children().back().add_child(instance);
			

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
		instance.set_count(tile.count);
		self.tiles_ui.get_node("HBoxContainer").add_child(instance);
		self.tiles_ui.tiles.append(instance);
