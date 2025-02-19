extends Node

var mod_main_directory : String = "mods"
var replace_files_on_mod_load: bool = true

# ProjectSettings.globalize_path because you can't use just res:// because 
# it points to the project root but the dlcs-folder is one level higher!
var project_directory : String = ProjectSettings.globalize_path("res://")
var mods_paths : Array[String] = []

func _init() -> void:
	# Find all PCK/ZIP
	print("mod manager: project directory: %s" % project_directory)
	FileManager.get_all_files(mods_paths, project_directory + mod_main_directory)

	# Load all PCK/ZIP into the project
	for path in mods_paths:
		load_mod_from_pck_or_zip(path)

func _ready() -> void:
	# Now that all mods have been loaded, let's launch the main menu
	call_deferred("load_main_menu")

func load_main_menu() -> void:
	var main_menu_scene : String = ConfigManager.config.main_menu_scene
	get_tree().change_scene_to_file(main_menu_scene)

func load_mod_from_pck_or_zip(path : String) -> void:
	var result : bool = ProjectSettings.load_resource_pack(path, replace_files_on_mod_load)
	print("mod manager: %s loaded: %s" % [path, result])
	if result:
		var file_name : String = path.get_file()
		var mod_name : String = file_name.split(".")[0] # Will break if mod has a period in the name
		var mod_init_scene = load("res://" + mod_name + "/init_scene.tscn").instantiate()
		add_child(mod_init_scene)
