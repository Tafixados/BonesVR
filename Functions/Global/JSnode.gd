extends Node


var _callback_ref = JavaScript.create_callback(self, "_my_callback")
var _permission_callback = JavaScript.create_callback(self, "_on_permissions")

func _on_Button_pressed():
	JavaScript.eval("alert('Hello, world!')")
	#JavaScript.eval("setscore();")
	
	# Get the `window.Notification` JavaScript object.
	var notification = JavaScript.get_interface("Notification")
	# Call the `window.Notification.requestPermission` method which returns a JavaScript
	# Promise, and bind our callback to it.
	notification.requestPermission().then(_permission_callback)
	
	# Asks the user download a file called "hello.txt" whose content will be the string "Hello".
	#JavaScript.download_buffer("Hello".to_utf8(), "hello.txt")
	
func _ready():
	# Get the JavaScript `window` object.
	var window = JavaScript.get_interface("window")
	# Set the `window.onbeforeunload` DOM event listener.
	window.onbeforeunload = _callback_ref

func _my_callback(args):
	# Get the first argument (the DOM event in our case).
	var js_event = args[0]
	# Call preventDefault and set the `returnValue` property of the DOM event.
	js_event.preventDefault()
	js_event.returnValue = ''

func _on_permissions(args):
	# The first argument of this callback is the string "granted" if the permission is granted.
	var permission = args[0]
	if permission == "granted":
		print("Permission granted, sending notification.")
		# Create the notification: `new Notification("Hi there!")`
		JavaScript.create_object("Notification", "Hi there!")
	else:
		print("No notification permission.")
