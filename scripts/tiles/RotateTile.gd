extends Tile

export var left: bool = true;

func _process(delta):
	if self.left:
		$cog.rotate($cog.transform.basis.y, delta);
	else:
		$cog.rotate($cog.transform.basis.y, -delta);

func update_agent_start(agent: Agent) -> void:
	if self.left:
		agent.turn_left()
	else:
		agent.turn_right()
