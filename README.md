# GML Events
A collection of scripts implementing C#-style events in GML.

See [documentation](DOCS.md) for information regarding use of individual methods and structs.



## How to use
Construct a new event using `new Event()`, and ideally store in an instance variable or somewhere other objects can easily access. To add an event function to the event, use `Event.add` and pass the function you want the event to trigger, and optionally the instance the method should be bound to (`global` by default) and whether the event function should automatically be removed from the event once it's been triggered. To trigger the event, use `Event.trigger` inside the object the event was declared in, but first construct an `EventArgs` struct containing the instance which triggered the event and whatever other info you wish your event function methods to have access to.

### Example code
Creation code of `obj_foo`:
```gml
event_key_press = new Event();
```

Creation code of `obj_bar`:
```gml
var key_func = function(event_args, func_info) {
	show_message(
		"Key " +
		string(event_args.key) +
		" was pressed from instance " +
		string(event_args.instance) +
		"."
	);
}

obj_main.event_key_press.add(key_func, self, false);
```

Step code of `obj_foo`:
```gml
if (keyboard_check_pressed(vk_anykey)) {
	var event_args = new EventArgs(id);
	event_args.key = keyboard_key;
	
	event_key_press.trigger(event_args);
}
```

The above code will open a message window with the text "\<pressed key> was pressed from instance \<`id` of `obj_main`>" whenever a keyboard key has been pressed.
