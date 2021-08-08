extends Tile

export var travel_length: int;

func update_agent_end(agent: Agent) -> void:
	var target_x: int;
	var target_y: int;
	var dir: int = (agent.direction + agent.instructions[agent.instruction] as int) % 4;
	
	match dir:
		Agent.Direction.NORTH:
			target_x = agent.tile_x;
			target_y = agent.tile_y + self.travel_length;
		Agent.Direction.EAST:
			target_x = agent.tile_x - self.travel_length;
			target_y = agent.tile_y;
		Agent.Direction.SOUTH:
			target_x = agent.tile_x;
			target_y = agent.tile_y - self.travel_length;
		Agent.Direction.WEST:
			target_x = agent.tile_x + self.travel_length;
			target_y = agent.tile_y;
	
	if not TileManager.has_tile(target_x, target_y):
		return;
	
	if not TileManager.tiles[target_x][target_y].traversable:
		return;
	
	agent.tile_x = target_x;
	agent.tile_y = target_y;
	
	agent.global_transform.origin.x = target_x as float;
	agent.global_transform.origin.z = target_y as float;

func build(length: int):
	travel_length = length;
