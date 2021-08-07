extends Spatial

enum TileId {
	EMPTY = 0,
	WALL = 2,
	TURN = 6,
	SCRAMBLER = 9,
	PORTAL = 7
};

onready var agent_model = preload("res://prefabs/agent.tscn");
onready var empty_tile = preload("res://prefabs/tiles/empty.tscn"); # 0
onready var scrambler_tile = preload("res://prefabs/tiles/scrambler.tscn"); #9
onready var turn_tile = preload("res://prefabs/tiles/turn.tscn"); #6
onready var wall_tile = preload("res://prefabs/tiles/wall.tscn"); #2
onready var portal_tile = preload("res://prefabs/tiles/portal.tscn"); #7

func _ready():
	var file = File.new();
	file.open("res://maps/level0.json", file.READ);
	var map = JSON.parse(file.get_as_text()).result;
	file.close();

	for x in map["tiles"].size():
		for z in map["tiles"][x].size():
			var id : int = map["tiles"][x][z][0];
			# Offsetting x and z to center placement with tiles
			var pos_x = x - map["width"] / 2;
			var pos_z = z - map["height"] / 2;
			match id:
				TileId.EMPTY:
					place_tile(empty_tile.instance(), pos_x, pos_z);
				TileId.WALL:
					place_tile(wall_tile.instance(), pos_x, pos_z);
				TileId.TURN:
					place_tile(turn_tile.instance(), pos_x, pos_z);
				TileId.SCRAMBLER:
					place_tile(scrambler_tile.instance(), pos_x, pos_z);
				TileId.PORTAL:
					place_tile(portal_tile.instance(), pos_x, pos_z);
				_:
					printerr("Invalid TileId: {id} in map".format({id=id}))
	
	for agent in map["agents"]:
		var x = agent["pos"][0] - map["width"] / 2;
		var z = agent["pos"][1] - map["height"] / 2;
		# Off setting the origin coordinate with half the lenght of the side to center spawn.
		place_agent(x, z, agent["ins"]);
	
	# Loading tiles into building array for tilemanager ui
	for building_tile in map["building_tiles"]:
		var tile: TileManager.BuildableTile = TileManager.BuildableTile.new();
		tile.count = building_tile[1];
		match building_tile[0] as int:
			TileId.EMPTY: tile.scene = empty_tile;
			TileId.WALL: tile.scene = wall_tile;
			TileId.TURN: tile.scene = turn_tile;
			TileId.SCRAMBLER: tile.scene = scrambler_tile;
			TileId.PORTAL: tile.scene = portal_tile;
			_: printerr("Invalid TileId: {id} in building tiles".format({id=building_tile[0]}));
		TileManager.buildable_tiles.append(tile);
	TileManager.init_tiles_ui();

func place_tile(tile: Tile, x: int, z: int):
	tile.global_transform.origin = Vector3(x, 0, z);
	TileManager.add_tile(tile);
	add_child(tile);

func place_agent(x: int, z: int, instructions: Array):
	var agent: Agent = agent_model.instance();
	agent.global_transform.origin = Vector3(x, 0, z);
	add_child(agent);
