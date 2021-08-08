extends Tile

export var target_x: int;
export var target_y: int;
export var travel_length: int;

func update_agent(agent: Agent) -> void:
	agent.tile_x = self.target_x;
	agent.tile_y = self.target_y;

	match agent.direction:
		Agent.Direction.NORTH:
			self.target_x = agent.tile_x;
			self.target_y = agent.tile_y + self.travel_length;
		Agent.Direction.EAST:
			self.target_x = agent.tile_x - self.travel_length;
			self.target_y = agent.tile_y;
		Agent.Direction.SOUTH:
			self.target_x = agent.tile_x;
			self.target_y = agent.tile_y - self.travel_length;
		Agent.Direction.WEST:
			self.target_x = agent.tile_x + self.travel_length;
			self.target_y = agent.tile_y;
		
	agent.global_transform.origin.x = self.target_x as float;
	agent.global_transform.origin.y = self.target_y as float;

func build(length: int):
	travel_length = length;
