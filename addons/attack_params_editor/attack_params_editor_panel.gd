@tool
extends VBoxContainer

var current_attack_param: AttackParams = null
var attack_animation_names = PlayerAnimationNames.get_attack_animation_names()

@onready var current_resource_path: LineEdit = $CurrentResourcePath
@onready var attack_editor_panel: VBoxContainer = $AttackEditorPanel

@onready var attack_name: LineEdit = $AttackEditorPanel/AttackName
@onready var knockbacks: CheckBox = $AttackEditorPanel/Knockbacks
@onready var animation_option_button: OptionButton = $AttackEditorPanel/AnimationOptionButton

var file_dialog := FileDialog.new()
var file_saver := FileDialog.new()


func _ready():
	add_child(file_dialog)
	add_child(file_saver)
	
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.access = FileDialog.ACCESS_RESOURCES
	file_dialog.filters = ["*.tres ; AttackParams Resource"]
	file_dialog.file_selected.connect(_on_file_opened)
	file_dialog.min_size = Vector2(640, 480)
	
	file_saver.file_mode = FileDialog.FILE_MODE_SAVE_FILE
	file_saver.access = FileDialog.ACCESS_RESOURCES
	file_saver.filters = ["*.tres ; AttackParams Resource"]
	file_saver.file_selected.connect(_on_file_saved)
	file_saver.min_size = Vector2(640, 480)
	
	animation_option_button.clear()
	for anim in attack_animation_names:
		print(anim)
		animation_option_button.add_item(anim)


func edit_attack(attack_params: AttackParams):
	current_attack_param = attack_params
	
	attack_name.text = current_attack_param.name
	knockbacks.button_pressed = current_attack_param.knocks_back
	
	var animation_index = attack_animation_names.find(current_attack_param.animation)
	if animation_index != -1:
		animation_option_button.select(animation_index)


func _on_attack_name_text_changed(new_text: String) -> void:
	if current_attack_param:
		current_attack_param.name = new_text


func _on_animation_option_button_item_selected(index: int) -> void:
	if current_attack_param:
		current_attack_param.animation = attack_animation_names[index]


func _on_knockbacks_toggled(toggled_on: bool) -> void:
	if current_attack_param:
		current_attack_param.knocks_back = toggled_on


func _on_load_attack_params_button_pressed() -> void:
	file_dialog.popup_centered()


func _on_file_opened(path):
	var attack_params = load(path)
	if attack_params and attack_params is AttackParams:
		edit_attack(attack_params)
		current_resource_path.text = path
		attack_editor_panel.visible = true


func _on_save_button_pressed() -> void:
	if current_attack_param:
		var path = current_attack_param.resource_path
		if path:
			ResourceSaver.save(current_attack_param, path)
			print("Сохранено: ", path)
		else:
			_on_save_as_button_pressed()


func _on_save_as_button_pressed() -> void:
	file_saver.popup_centered()


func _on_file_saved(path) -> void:
	if current_attack_param:
		ResourceSaver.save(current_attack_param, path)
		current_attack_param.resource_path = path
		current_resource_path.text = path
		print("Сохранено как: ", path)
