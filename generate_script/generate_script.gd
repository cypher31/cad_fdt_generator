extends Node

var fdt_locations_formatted : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func new_script(fdt_locations):
	
	var date = OS.get_date()
	var date_formatted = str(date["month"]) + "/" + str(date["day"]) + "/" + str(date["year"]) + "\r\n"
	var script_dict : Dictionary = {} #script dictionary

#	script_dict[script_dict.size() + 1] = "; created" + date_formatted #key denotes the line number
#	script_dict[script_dict.size() + 1] = "(setq oldosmode (getvar \"OSMODE\"))\r\n"
#	script_dict[script_dict.size() + 1] = "Project Name: %s\r\n" % data_management.project_name
	
	#parse through selected file
	var load_data = File.new()
	# use an empty dictionary to assign temporary data to
	var current_line = {}
	var current_line_formatted : Array

	# read the data in
	load_data.open(fdt_locations, File.READ)
	
	var i : int = 0 #line counter

	while(!load_data.eof_reached()):
		# use currentLine to parse through the file
		current_line[i] = load_data.get_line()
		
		var fdt_data : Dictionary = {}
		
		current_line_formatted = current_line[i].split("\t")
		
		fdt_data["num"] = current_line_formatted[0]
		fdt_data["x_pos"] = current_line_formatted[1]
		fdt_data["y_pos"] = current_line_formatted[2]
		
		script_dict[script_dict.size() + 1] = "-insert\r\n"
		script_dict[script_dict.size() + 1] = "FDT\r\n"
		script_dict[script_dict.size() + 1] =  str(fdt_data["x_pos"]) + "," + str(fdt_data["y_pos"]) + "\r\n"
		script_dict[script_dict.size() + 1] = "5\r\n"
		script_dict[script_dict.size() + 1] = "5\r\n"
		script_dict[script_dict.size() + 1] = "0\r\n"
		script_dict[script_dict.size() + 1] = str(fdt_data["num"]) + "\r\n"
		
		i += 1
		pass
	
	load_data.close()
	
	#generate script file
	var file = File.new()
	var file_date = str(date["month"]) + "_" + str(date["day"]) + "_" + str(date["year"])
	var file_name = data_management.working_directory + "/" + file_date + "_"  + "_fdt.txt"
	
	file.open(file_name, file.WRITE)

	for i in range(1, script_dict.size() + 1):
		file.store_string(str(script_dict[i]))
		pass
	
	file.close()
	return