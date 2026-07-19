extends HBoxContainer
class_name CraftingUI

const INV_SLOT: PackedScene = preload("uid://chlepjt2juyx8")

@export var recipe_array: Array[ItemRecipe]

@onready var tree: Tree = $Tree
@onready var title_label: Label = $VBoxContainer/TitleLabel
@onready var item_texture: TextureRect = $VBoxContainer/ItemTexture
@onready var materials_container: GridContainer = $VBoxContainer/MaterialsContainer
@onready var craft_button: Button = $VBoxContainer/CraftButton

var recipe_material_dictionary: Dictionary
var recipe_material_array: Array[ItemData]
var selected_recipe: ItemRecipe

func _ready() -> void:
	tree.cell_selected.connect(_on_recipe_selected)
	craft_button.pressed.connect(_craft_pressed)
	build_recipe_tree()
	
	if selected_recipe == null:
		build_recipe_material_window(recipe_array[0])
	else:
		build_recipe_material_window(selected_recipe)

func build_recipe_tree() -> void:
	tree.hide_root = true
	var tree_root: TreeItem = tree.create_item()
	
	for recipe in recipe_array:
		var new_recipe_slot: TreeItem = tree.create_item(tree_root)
		new_recipe_slot.set_icon(0, recipe.recipe_product.texture)
		new_recipe_slot.set_text(0, recipe.recipe_product.name)

func _on_recipe_selected() -> void:
	var cell_recipe_name: String = tree.get_selected().get_text(0)
	
	for recipe in recipe_array:
		if recipe.recipe_product.name == cell_recipe_name:
			build_recipe_material_window(recipe)
			selected_recipe = recipe
			return

func build_recipe_material_window(_selected_recipe: ItemRecipe) -> void:
	clean_material_window()
	
	title_label.text = _selected_recipe.recipe_product.name
	item_texture.texture = _selected_recipe.recipe_product.texture
	
	for recipe_material in _selected_recipe.recipe_materials:
		recipe_material_array.append(recipe_material)
	
	for recipe_material in recipe_material_array:
		var new_material: InvSlotUI = INV_SLOT.instantiate()
		materials_container.add_child(new_material)
		new_material.slot_data = SlotData.new()
		new_material.slot_data.item_data = recipe_material
		new_material.item_icon.texture = recipe_material.texture
	
	check_recipe_craftable()

func clean_material_window() -> void:
	recipe_material_array.clear()
	
	for child in materials_container.get_children():
		child.queue_free()

func check_recipe_craftable() -> void:
	var items: Array[ItemData]
	
	for slot in Player.inventory.slots:
		if slot && slot.item_data:
			items.append(slot.item_data)
	
	for recipe_material in recipe_material_array:
		if items.has(recipe_material):
			craft_button.disabled = false
			print("Material present: ", recipe_material.name)
		elif !items.has(recipe_material):
			craft_button.disabled = true
			print("Material missing: ", recipe_material.name)

func _craft_pressed() -> void:
	for recipe_material in recipe_material_array:
		Player.inventory.remove_item(recipe_material)
		print(recipe_material)
	
	Player.inventory.add_item(selected_recipe.recipe_product)
	
	check_recipe_craftable()
