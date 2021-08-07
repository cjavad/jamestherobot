extends Tile

export var target_x: int;
export var target_y: int;

func update_agent(agent: Agent) -> void:
	agent.tile_x = self.target_x;
	agent.tile_y = self.target_y;
	
	agent.global_transform.origin.x = self.target_x as float;
	agent.global_transform.origin.y = self.target_y as float;
