extends Button

func _pressed():
	if GameManager.running: # stop
		GameManager.running = false;
		GameManager.instruction_time = 0.0;
		
		for agent in GameManager.agents:
			agent.instruction = 0;
			agent.tile_x = agent.start_x;
			agent.tile_y = agent.start_y;
			
			agent.global_transform.origin.x = agent.tile_x as float;
			agent.global_transform.origin.z = agent.tile_y as float;
			
			agent.state = Agent.State.IDLE;
			agent.get_node("AnimationPlayer").play("Wake");
		
		self.text = "Play";
	else: # play
		
		GameManager.running = true;
		self.text = "Stop";
