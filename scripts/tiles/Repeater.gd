extends Tile

func _ready():
	$AudioStreamPlayer3d.play();


func update_agent_start(agent: Agent) -> void:
	agent.instruction -= 1;
