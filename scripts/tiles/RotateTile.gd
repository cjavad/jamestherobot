extends Tile

export var left: bool = true;

func _process(delta):
	if self.left:
		$cog.rotate(Vector3.UP, delta * -30.0);
	else:
		$cog.rotate(Vector3.UP, delta * 30.0);

func update_agent(agent: Agent) -> void:
	if self.left:
		agent.turn_left()
	else:
		agent.turn_right()
