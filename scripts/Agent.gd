extends Spatial
class_name Agent

enum Direction {
	NORTH,
	EAST,
	SOUTH,
	WEST,
};

export(Direction) var direction: int = Direction.NORTH;

onready var tile_x: int = round(self.global_transform.origin.x) as int;
onready var tile_y: int = round(self.global_transform.origin.z) as int;

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
	self.target = Vector3(x as float, 0.0, y as float);
	self.look_at(self.target, Vector3.UP);
	self.state = State.WALKING;

# walk depending on direction
func walk_forward() -> void:
	match self.direction:
		Direction.NORTH:
			self.walk_to(self.tile_x, self.tile_y + 1);
		Direction.EAST:
			self.walk_to(self.tile_x - 1, self.tile_y);
		Direction.SOUTH:
			self.walk_to(self.tile_x, self.tile_y - 1);
		Direction.WEST:
			self.walk_to(self.tile_x + 1, self.tile_y);

func turn_left() -> void:
	self.direction = (self.direction + 3) % 4;

func turn_right() -> void:
	self.direction = (self.direction + 1) % 4;
