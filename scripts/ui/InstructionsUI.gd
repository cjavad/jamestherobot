extends RichTextLabel
class_name InstructionsUi

func _ready():
	GameManager.instructions_ui = self;
