extends Tile

export var left: bool = true;

func update_agent(agent: Agent) -> void:
	if self.left:
		agent.turn_left()
	else:
		agent.turn_right()
