extends Control

signal units_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	var file_dialog_button = $tab_master/vbox/mc/vbox/button_working_dir
	var file_dialog_popup = $tab_master/vbox/mc/vbox/button_working_dir/FileDialog
	
	var load_button = $tab_master/vbox/mc/vbox/button_load_file
	var load_file_dialog = $tab_master/vbox/mc/vbox/button_load_file/file_search

	var button_new_trench = $tab_master/vbox/mc/vbox/button_add_trench
	var pop_up_new_trench = $tab_master/vbox/mc/vbox/button_add_trench/new_trench_pop
	
	file_dialog_button.connect("button_up", self, "file_dialog")
	file_dialog_popup.connect("dir_selected", self, "set_working_dir")
	
	load_button.connect("button_up", self, "load_data")
	
	load_file_dialog.connect("file_selected", self, "set_file_to_load")

	
	pass # Replace with function body.

func file_dialog():
	var popup = $tab_master/vbox/mc/vbox/button_working_dir/FileDialog
	
	popup.popup_centered()
	return
	
func set_working_dir(dir):
	get_node("tab_master/vbox/mc/vbox/input_working_directory/user_input").set_text(dir)
	data_management.working_directory = dir
	pass


func load_data():
	if $tab_master/vbox/mc/vbox/input_working_directory/user_input.get_text() != "":
		var popup = $tab_master/vbox/mc/vbox/button_load_file/file_search
	
		popup.popup_centered()
	else:
		utility.output_node.set_text("Please Set Working Directory Before Loading File...")
	pass

func set_file_to_load(file):
	generate_script.new_script(file)
	pass
