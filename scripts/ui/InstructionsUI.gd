extends RichTextLabel
class_name Instructions_Ui

func _ready():
	GameManager.instructions_ui = self;
