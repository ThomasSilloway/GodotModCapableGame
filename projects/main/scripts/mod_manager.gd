extends Node

var mod_main_directory : String = "mods"
var replace_files_on_mod_load: bool = true

# Get the executable's directory
var executable_dir : String = OS.get_executable_path().get_base_dir()
var mods_paths : Array[String] = []
var mod_order : Array[String] = []

func _init() -> void:
	var err = initialize_mod_system()
	if err != OK:
		push_error("Mod Manager: Critical error during initialization")

func initialize_mod_system() -> Error:
	# Load mod order from YAML
	var yaml_path = executable_dir.path_join(mod_main_directory).path_join("mod_order.yaml")
	if not FileAccess.file_exists(yaml_path):
		push_error("Mod Manager: No mod order file found at " + yaml_path)
		return ERR_FILE_NOT_FOUND
		
	var parsed = YamlParser.parse_file(yaml_path)
	if not parsed:
		push_error("Mod Manager: YAML parsing failed")
		return ERR_PARSE_ERROR
	
	if not parsed.has("mods"):
		push_error("Mod Manager: YAML file missing 'mods' key")
		return ERR_INVALID_DATA
	
	# Convert the untyped array to Array[String]
	mod_order.clear()
	for mod in parsed.mods:
		mod_order.append(str(mod))
	
	var err = load_and_sort_mods()
	if err != OK:
		push_error("Mod Manager: Error during mod loading")
		return err
		
	return OK

func load_and_sort_mods() -> Error:
	# Find all PCK/ZIP
	var scan_path = executable_dir.path_join(mod_main_directory)
	if not DirAccess.dir_exists_absolute(scan_path):
		push_error("Mod Manager: Mods directory not found at " + scan_path)
		return ERR_FILE_NOT_FOUND
		
	FileManager.get_all_files(mods_paths, scan_path)
	
	# Filter for only .zip files
	mods_paths = mods_paths.filter(func(path): return path.get_extension() == "zip")
	
	if mods_paths.is_empty():
		push_error("Mod Manager: No mod zip files found in " + scan_path)
		return ERR_FILE_NOT_FOUND
	
	# Sort mods_paths according to mod_order
	if mod_order.size() > 0:
		var sorted_paths : Array[String] = []
		var unordered_paths : Array[String] = []
		
		# First collect all paths that aren't in the mod order
		for path in mods_paths:
			var file_name = path.get_file().split(".")[0]
			if not mod_order.has(file_name):
				push_warning("Mod Manager: Mod not in order list - " + file_name)
				unordered_paths.append(path)
		
		# Then add all ordered mods first
		for mod_name in mod_order:
			for path in mods_paths:
				var file_name = path.get_file().split(".")[0]
				if file_name == mod_name:
					sorted_paths.append(path)
					break
		
		# Finally append all unordered mods
		sorted_paths.append_array(unordered_paths)
		mods_paths = sorted_paths
		print("Mod Manager: Sorted mod loading order:")
		for mod_path in mods_paths:
			print("  - ", mod_path.get_file())

	# Load all PCK/ZIP into the project in the specified order
	for path in mods_paths:
		var file_name = path.get_file()
		var mod_name = file_name.split(".")[0]
		load_mod_from_pck_or_zip(path)
	
	return OK

func _ready() -> void:
	# Now that all mods have been loaded, let's launch the main menu
	call_deferred("load_main_menu")

func load_main_menu() -> void:
	var main_menu_scene : String = ConfigManager.config.main_menu_scene
	get_tree().change_scene_to_file(main_menu_scene)

func load_mod_from_pck_or_zip(path : String) -> void:
	var result : bool = ProjectSettings.load_resource_pack(path, replace_files_on_mod_load)
	print("Mod Manager: Loaded mod - %s: %s" % [path.get_file(), result])
	if result:
		var file_name = path.get_file()
		var mod_name = file_name.split(".")[0]
		var mod_init_scene = load("res://" + mod_name + "/init_scene.tscn").instantiate()
		add_child(mod_init_scene)
