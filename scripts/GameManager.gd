extends Node

export var agents: Array = [];
export var wait_time: float = 3.0;

var selected_map: String = "res://maps/template.json";

var running: bool = true;
var instruction_time: float = 0.0;

func _process(delta: float) -> void:
	# if evaluation isn't running, do nothing
	if not self.running:
		return;
	
	# decrease instruction_time, and only continue if we're at zero
	if self.instruction_time > 0.0:
		self.instruction_time -= delta;
		return;
	
	# check if agents are idle
	var idle: bool = self.agents_idle();
	
	# if they are, go through each
	if idle:
		for agent in self.agents:
			# find their tile, if it doesn't exist, then lose the game
			if !TileManager.has_tile(agent.tile_x, agent.tile_y):
				print("You lost, agent went out of level");
				continue;
			
			var tile: Tile = TileManager.tiles[agent.tile_x][agent.tile_y];
			
			# update tile
			tile.update_agent(agent);
			
			# update agent
			agent.execute_instruction();
		
		# set instrction_time 
		self.instruction_time = self.wait_time;

func agents_idle() -> bool:
	for agent in self.agents:
		if agent.state != Agent.State.IDLE:
			return false;
	return true;
