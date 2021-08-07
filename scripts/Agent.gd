tool
extends Spatial
class_name Agent

enum Direction {
	NORTH,
	EAST,
	SOUTH,
	WEST,
};

export(Direction) var direction: int = Direction.NORTH;
export(Array, Direction) var instructions: Array;

onready var tile_x: int = round(self.global_transform.origin.x) as int;
onready var tile_y: int = round(self.global_transform.origin.z) as int;

var instruction: int = 0;

enum State {
	IDLE,
	WALKING,
};

var state: int = State.IDLE;
var target: Vector3;

func _ready() -> void:
	# play wake animation
	$AnimationPlayer.play("Wake");
	
	# register in GameManager
	self.get_node("/root/GameManager").agents.append(self);

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return;
	
	if self.state == State.WALKING:
		$AnimationPlayer.play("Walk");
		
		# calculate direction to target
		var diff: Vector3 = self.target - self.global_transform.origin;
		var dir: Vector3 = diff.normalized();
		
		# if we have arrived, return to idle else move towards target
		if diff.length() <= delta * 2.0:
			self.state = State.IDLE;
			
			self.tile_x = round(self.target.x) as int;
			self.tile_y = round(self.target.z) as int;
		else:
			self.global_transform.origin += dir * delta * 0.5;

func walk_to(x: int, y: int) -> void:
	if TileManager.has_tile(x, y) and not TileManager.tiles[x][y].traversable:
		print("could not traverse tile");
		return;
	
	self.target = Vector3(x as float, 0.0, y as float);
	self.look_at(self.target, Vector3.UP);
	self.state = State.WALKING;

# walk depending on direction
func walk_direction(direction: int) -> void:
	var d: int = (direction + self.direction) % 4;
	
	match d:
		Direction.NORTH:
			self.walk_to(self.tile_x, self.tile_y + 1);
		Direction.EAST:
			self.walk_to(self.tile_x - 1, self.tile_y);
		Direction.SOUTH:
			self.walk_to(self.tile_x, self.tile_y - 1);
		Direction.WEST:
			self.walk_to(self.tile_x + 1, self.tile_y);

func execute_instruction() -> void:
	if self.instruction >= self.instructions.size():
		return;
	
	self.walk_direction(self.instructions[self.instruction]);
	
	self.instruction += 1;

func turn_left() -> void:
	self.direction = (self.direction + 3) % 4;

func turn_right() -> void:
	self.direction = (self.direction + 1) % 4;
