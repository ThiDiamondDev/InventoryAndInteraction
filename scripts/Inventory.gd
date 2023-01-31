extends Control

# Load the custom images for the mouse cursor
var arrow = load("res://arrow.png")
var hand = load("res://hand.png")

var slots = []

func _ready():
	for item in get_tree().get_nodes_in_group("items"):
		item.connect("mouse_entered",self, "on_item_mouse_entered",[])
		item.connect("mouse_exited",self, "on_item_mouse_exited",[])
		item.connect("pressed",self, "on_item_pressed",[item])

	var slots_group = get_tree().get_nodes_in_group("slots")
	for index in slots_group.size():
		var slot = slots_group[index]
		slots.append({"slot": slot, "selected": false,
			   "index": index, "empty": true})
		
		var params = [slots[index]]

		slot.connect("mouse_entered",self, "on_slot_mouse_entered",params)
		slot.connect("mouse_exited",self, "on_slot_mouse_exited",params)
		slot.connect("pressed",self, "on_slot_pressed",params)
		


func on_item_mouse_entered():
	Input.set_custom_mouse_cursor(hand)

	
func on_item_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)

		
func on_item_pressed(item: TextureButton):
	for slot in slots:
		if slot["empty"]:
			slot["empty"] = false
			slot.slot.set_normal_texture(item.get_normal_texture())
			Input.set_custom_mouse_cursor(arrow)
			remove_child(item)
			return
		
func on_slot_mouse_entered(slot):
	var slotContainer : ColorRect = slot.slot.get_parent()
	if slotContainer and not slot["selected"]:
		slotContainer.color = Color.white

func on_slot_mouse_exited(slot):
	var slotContainer : ColorRect = slot.slot.get_parent()
	if slotContainer and not slot["selected"]:
		slotContainer.color = Color.black

func on_slot_pressed(slot):
	var slotContainer : ColorRect = slot.slot.get_parent()
	if not slotContainer:
		return
	if slot["selected"]:
		slot["selected"] = false
		slotContainer.color = Color.white
	else: 
		slot["selected"] = true
		slotContainer.color = Color.green

