extends Node

var cc: Array[int] = []

signal cc_changed(cc_number)
signal key_pressed(key)

func _ready():
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())

	#initialise tous les CC
	cc.resize(128)
	for n in cc:
		cc[n] = 0

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
		if event.message == MIDI_MESSAGE_NOTE_ON:
			if event.pitch > 40:
				key_pressed.emit(event.pitch)
		else:
			if event.controller_number > 0:
				cc[event.controller_number] = event.controller_value
				cc_changed.emit(event.controller_number)
		#print(event.controller_number, ": ", cc[event.controller_number])
		#print(event.pitch)
