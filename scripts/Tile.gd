extends Area
class_name Tile

export var traversable: bool = true;
export var buildable: bool = true;

onready var x: int = round(self.global_transform.origin.x) as int;
onready var y: int = round(self.global_transform.origin.z) as int;

class ReplacedTile:
	var idx: int;
	var tile: Tile;

var replacing: ReplacedTile = null;

func build(meta):
	pass

func _ready():
	# add self to tile manager
	TileManager.add_tile(self);

func update_agent_end(agent: Agent) -> void:
	pass

func update_agent_start(agent: Agent) -> void:
	pass
