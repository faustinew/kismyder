extends Node

var cc: Array[int] = []

func _ready():
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())

	#initialise tous les CC
	cc.resize(128)
	for n in cc:
		cc[n] = 64

	#InputMap.action_add_event("face_nose",)

# func _input(input_event):
# 	if input_event is InputEventMIDI:
# 		_print_midi_info(input_event)

func _print_midi_info(midi_event):
	print(midi_event)
	print("Channel ", midi_event.channel)
	print("Message ", midi_event.message)
	print("Pitch ", midi_event.pitch)
	print("Velocity ", midi_event.velocity)
	print("Instrument ", midi_event.instrument)
	print("Pressure ", midi_event.pressure)
	print("Controller number: ", midi_event.controller_number)
	print("Controller value: ", midi_event.controller_value)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMIDI:
		cc[event.controller_number] = event.controller_value
		#print(event.controller_number, ": ", cc[event.controller_number])
