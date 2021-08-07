extends Spatial
class_name Tile

func _ready():
	# add self to tile manager
	self.get_node("/root/TileManager").add_tile(self);

func update_agent(agent: Agent) -> void:
	pass
