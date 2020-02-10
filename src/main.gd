"""
file name: main.gd
"""
extends Node

# Replace the following path variables to your own: 
# Path to dialogue text button  
onready var prompt_node = $"gui/screen/screen_content/prompt"
# Path to the parent node of the options container  
onready var dynamic_content_node = $"gui/screen/screen_content/dynamic_content"
# Path to json file  
onready var json_path = "res://test.json"

func _ready():
	prompt_node.connect("pressed", self, "_on_prompt_pressed")
	$parser.connect("dialogues_completed", self, "_on_dialogues_completed")
	$parser.load_graph(json_path)
	var dialogue = $parser.get_next_dialogue()
	display(dialogue)
	
func display(dialogue:Dictionary):
	if dialogue.empty():
		return
	
	# display prompt text
	prompt_node.set_text(dialogue.text)
	
	# display options
	if "options" in dialogue:
		var c = VBoxContainer.new()
		c.set_v_size_flags(3)
		c.set_name("option_labels_container")
		dynamic_content_node.add_child(c)
		prompt_node.set_disabled(true)
		for option in dialogue.options:
			display_option_button(option)	
	else:
		prompt_node.set_disabled(false)
		
	# display spirte
	if "image" in dialogue:
		pass
		
	# forward calls
	if "calls" in dialogue:
		pass
		
func display_option_button(option:Dictionary):
	var l = Button.new()
	l.set_v_size_flags(3)
	l.set_text(option.text)
	var button_pos = dynamic_content_node.get_node("option_labels_container").get_child_count()
	l.set_name("button"+str(button_pos))
	dynamic_content_node.get_node("option_labels_container").add_child(l)
	l.connect("pressed", self, "_on_option_pressed", [button_pos])
	
func clear_all_labels():
	# remove all options from screen
	dynamic_content_node.get_node("option_labels_container").queue_free()
	
func _on_prompt_pressed():
	var dialogue = $parser.get_next_dialogue()
	display(dialogue)
	
func _on_option_pressed(option:int):
	clear_all_labels()
	var dialogue = $parser.get_next_dialogue(option)
	display(dialogue)
	
func _on_dialogues_completed():
	$gui.queue_free()
