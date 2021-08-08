extends VBoxContainer
class_name InstructionsUI

var black = Color("#000000");
var green = Color("#00FF00");

func _ready():	
	GameManager.instructions_ui = self;

func color_x(i: int):
	var label = self.get_child(i);
	label.set("custom_colors/font_color", green);

func uncolor_x(i : int):
	var label = self.get_child(i);
	label.set("custom_colors/font_color", black);

func uncolor_all():
	for label in self.get_children():
		label.set("custom_colors/font_color", black);

func clear_instructions():
	for n in self.get_children():
		self.remove_child(n)
