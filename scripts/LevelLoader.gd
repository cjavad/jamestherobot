extends Spatial

onready var agent_model = preload("res://prefabs/agent.tscn");
onready var empty_tile = preload("res://prefabs/tiles/empty.tscn");

func _ready():
	var file = File.new();
	file.open("res://maps/level0.json", file.READ);
	var map = JSON.parse(file.get_as_text()).result;
	file.close();

	for x in map["tiles"].size():
		for z in map["tiles"][x].size():
			if map["tiles"][x][z] == 0:
				place_tile(empty_tile.instance(), x - map["width"] / 2, z - map["height"] / 2);
	
	for i in map["agents"].size():
		var x = map["agents"][i]["pos"][0] - map["width"] / 2;
		var z = map["agents"][i]["pos"][1] - map["height"] / 2;
		# Off setting the origin coordinate with half the lenght of the side to center spawn.
		place_agent(x, z, map["agents"][i]["ins"]);
	
func place_tile(tile: Tile, x: int, z: int):
	tile.global_transform.origin = Vector3(x, 0, z);
	TileManager.add_tile(tile);
	add_child(tile);

func place_agent(x: int, z: int, instructions: Array):
	var agent: Agent = agent_model.instance();
	agent.global_transform.origin = Vector3(x, 0, z);
	add_child(agent);
