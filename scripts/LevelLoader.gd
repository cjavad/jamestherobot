extends Spatial

enum TileId {
	VFORSEJR = 20,
	EMPTY = 0,
	NONE = 19,
	WALL = 2,
	TURN = 6,
	SCRAMBLER = 9,
	PORTAL = 7
};

onready var agent_model = preload("res://prefabs/agent.tscn");
onready var win_tile = preload("res://prefabs/tiles/win.tscn"); # 20
onready var empty_tile = preload("res://prefabs/tiles/empty.tscn"); # 0
onready var scrambler_tile = preload("res://prefabs/tiles/scrambler.tscn"); #9
onready var turn_tile = preload("res://prefabs/tiles/turn.tscn"); #6
onready var wall_tile = preload("res://prefabs/tiles/wall.tscn"); #2
onready var portal_tile = preload("res://prefabs/tiles/portal.tscn"); #7

func _ready():
	var file = File.new();
	file.open(GameManager.selected_map, file.READ);
	var map = JSON.parse(file.get_as_text()).result;
	file.close();

	for x in range(map["tiles"].size()):
		for z in range(map["tiles"][x].size()):
			var id : int = map["tiles"][x][z][0];
			
			# Offsetting x and z to center placement with tiles
			var pos_x = ceil(x - map["width"] as float / 2.0);
			var pos_z = ceil(z - map["height"] as float / 2.0);
			if id == TileId.NONE: continue
			var tile: Tile = get_tile(id).instance();
			if map["tiles"][x][z].size() > 1:
				tile.build(map["tiles"][x][z][1]);
			place_tile(tile, pos_x, pos_z);
	
	for agent in map["agents"]:
		var x = agent["pos"][0] - map["width"] / 2;
		var z = agent["pos"][1] - map["height"] / 2;
		# Off setting the origin coordinate with half the lenght of the side to center spawn.
		place_agent(x, z, agent["ins"]);
	
	# Loading tiles into building array for tilemanager ui
	for building_tile in map["building_tiles"]:
		var tile: TileManager.BuildableTile = TileManager.BuildableTile.new();
		tile.count = building_tile[1];
		if building_tile.size() > 2:
			tile.meta = building_tile[2];
		tile.scene = get_tile(building_tile[0]);
		TileManager.buildable_tiles.append(tile);
	TileManager.init_tiles_ui();

func get_tile(tile_id: int):
	match tile_id as int:
		TileId.EMPTY: return empty_tile;
		TileId.WALL: return wall_tile;
		TileId.TURN: return turn_tile;
		TileId.SCRAMBLER: return scrambler_tile;
		TileId.PORTAL: return portal_tile;
		TileId.VFORSEJR: return win_tile;
		_: printerr("Invalid TileId: {id} in building tiles".format({id=tile_id}));

func place_tile(tile: Tile, x: int, z: int):
	tile.global_transform.origin = Vector3(x, 0, z);
	TileManager.add_tile(tile);
	add_child(tile);

func place_agent(x: int, z: int, instructions: Array):
	var agent: Agent = agent_model.instance();
	agent.instructions = instructions;
	agent.global_transform.origin = Vector3(x, 0, z);
	add_child(agent);
