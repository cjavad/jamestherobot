extends Tile

func update_agent_start(agent: Agent) -> void:
	agent.instructions.invert();
	
