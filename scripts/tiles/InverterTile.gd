extends Tile
func update_agent(agent: Agent) -> void:
	agent.instructions.invert();
