"""
file name: parser.gd
brief: parses json dialogues
API: 
	# loads and parses a json file into a Dictionary 
	# (must be valid dialogue format)
	load_graph(file_path:String) -> bool 
	
	# first string in the returned array is the prompt text
	# rest of the strings are options to be selected
	get_next_dialogue(option:int = 0) -> Array
	
	# signal emitted when all dialogues have been processed
	dialogues_completed
"""
extends Node

var graph:Dictionary
var current_block:Dictionary
var current_dialogue_pos:int = 0

signal dialogues_completed

func load_graph(file_path:String) -> bool:
	var file = File.new()
	var error = file.open(file_path, File.READ)
	if error:
		print("[ERROR]: couldn't open file at %s. Error number %s." % [file_path, error])
		return false
	graph = parse_json(file.get_as_text())
	file.close()
	if not graph is Dictionary:
		print("[ERROR]: failed to parse whiskers file. Is it a valid exported whiskers file?")
		return false
	# TODO: check_valid
	# var success = check_valid(graph)
	var success = true
	current_block = graph.start
	return success
	
func goto_next_block(option:int = 0):
	current_dialogue_pos = 0
	var next_block:String = current_block.next_blocks[option]
	current_block = graph[next_block]
	
func get_next_dialogue(option:int = 0) -> Dictionary:
	var current_dialogue:Dictionary = {}
	# check if current_block has reached the end already, update status if it has
	if current_dialogue_pos >= current_block.dialogues.size():
		if current_block.is_final == true:
			emit_signal("dialogues_completed")
			graph.clear()
			current_block.clear()
			current_dialogue_pos = 0
			return current_dialogue
		goto_next_block(option)
		
	# now read and return the current dialogue
	current_dialogue = current_block.dialogues[current_dialogue_pos]
	current_dialogue_pos += 1
	return current_dialogue
	

