extends Area
class_name Tile

export var traversable: bool = true;
export var buildable: bool = true;

onready var x: int = round(self.global_transform.origin.x) as int;
onready var y: int = round(self.global_transform.origin.z) as int;

func _ready():
	# add self to tile manager
	TileManager.add_tile(self);
	
	self.connect("mouse_entered", self, "mouse_entered");
	self.connect("mouse_exited", self, "mouse_exited");

func mouse_entered() -> void:
	TileManager.hovered_tile = self;

func mouse_exited() -> void:
	pass

func update_agent(agent: Agent) -> void:
	pass
