extends Button

func _pressed():
	if GameManager.state == GameManager.State.RUNNING: # stop
		GameManager.state = GameManager.State.BUILD
		GameManager.instruction_time = 0.0;
		
		for agent in GameManager.agents:
			agent.instruction = 0;
			agent.tile_x = agent.start_x;
			agent.tile_y = agent.start_y;
			agent.direction = agent.start_direction;
			
			agent.global_transform.origin.x = agent.tile_x as float;
			agent.global_transform.origin.z = agent.tile_y as float;
			
			agent.state = Agent.State.IDLE;
			agent.get_node("AnimationPlayer").play("Wake");
			GameManager.instructions_ui.uncolor_all();
		
		self.text = "Play";
	elif GameManager.state == GameManager.State.BUILD: # play
		
		GameManager.state = GameManager.State.RUNNING
		self.text = "Stop";
