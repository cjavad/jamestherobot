extends VBoxContainer
class_name InstructionsUI

func _ready():	
	GameManager.instructions_ui = self;

func color_x(i: int):
	var label = self.get_child(i);
	label.push_color(Color("green"));
	label.pop();

func uncolor_x(i : int):
	var label = self.get_child(i);
	label.push_color(Color("black"));
	label.pop();

func uncolor_all():
	for label in self.get_children():
		label.push_color(Color("black"));
		label.pop();

func clear_instructions():
	for n in self.get_children():
		self.remove_child(n)
