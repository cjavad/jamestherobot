extends Spatial
class_name Tile

export var traversable: bool = true;
export var buildable: bool = true;

func _ready():
	# add self to tile manager
	TileManager.add_tile(self);

func update_agent(agent: Agent) -> void:
	pass
