extends Node

export var agents: Array = [];
export var wait_time: float = 3.0;

var selected_map: String = "res://maps/template.json";

enum State {
	BUILD,
	RUNNING,
	WIN,
	LOSE,
}

var state: int = State.BUILD;
var instruction_time: float = 0.0;
var instructions_ui: InstructionsUi;

func _process(delta: float) -> void:
	# if evaluation isn't running, do nothing
	if self.state != State.RUNNING:
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
				GameManager.lose();
				continue;
			
			var tile: Tile = TileManager.tiles[agent.tile_x][agent.tile_y];
			
			# update tile
			tile.update_agent_end(agent);
			
			# find their tile, if it doesn't exist, then lose the game
			if !TileManager.has_tile(agent.tile_x, agent.tile_y):
				GameManager.lose();
				continue;
			
			var new_tile: Tile = TileManager.tiles[agent.tile_x][agent.tile_y];
			
			# update tile
			new_tile.update_agent_start(agent);
			
			
			# update agent
			agent.execute_instruction();
		
		# set instrction_time 
		self.instruction_time = self.wait_time;

func win() -> void:
	self.state = State.WIN;

func lose() -> void:
	self.state = State.LOSE;

func agents_idle() -> bool:
	for agent in self.agents:
		if agent.state != Agent.State.IDLE:
			return false;
	return true;
