# Documentation

## `Event()`
To create a new event, use `new Event()`. This constructs a struct containing methods for adding event functions to the event, removing event functions from the event, triggering the event, deleting the event, and clearing the event. The struct also contains methods beginning with `__`, these are *private* methods and **should not** be called from outside the struct.

----

## `Event.add(func, \[instance], \[auto_remove])`
Adds an event function to the event.

### Arguments
- `{method} func` - The method to trigger once the event is triggered. This method will be rebound to `instance`.
- `{instance or struct} instance` - Optional, defaults to `global`. The instance to bind `func` to.
- `{bool} auto_remove` - Option, defaults to `false`. Whether to automatically remove the event function from the event when the event is triggered.

### Returns
An `EventFuncInfo` instance corresponding to the arguments provided. Equivalent to `new EventFuncInfo(func, instance, auto_remove)`.

----

## `Event.remove(func_info)`
Removes an event function from the event.

### Arguments
- `{EventFuncInfo} func_info` - The event function to remove from the event.

### Returns
A boolean value corresponding to whether the event function was successfully removed.

----

## `Event.trigger(event_args)`
Triggers the event and all event functions within it.

### Arguments
- `{EventArgs} event_args` - The event arguments to be provided to the event functions.

----

## `Event.destroy()`
Destroys the event. Like any other datastructure within GML, the event should be destroyed once it is no longer in use by anything, otherwise might cause a memory leak.

----

## `Event.clear()`
Clears all of the event's event functions. Does not destroy the event or the event functions, merely clears them from the event.

----

## `EventFuncInfo(func_method, instance, auto_remove)`
Struct containing information about an event function. Is returned by `Event.add(func, \[instance], \[auto_remove])` and used as an argument in `Event.remove(func_info)`, as well as being passed as an argument to all event functions. This struct should never need to be manually constructed as it is only used internally and as an argument in event functions.

### Struct variables
- `{method} func_method` - The method to trigger once the event is triggered.
- `{instance or struct} instance` - The instance `func_method` is bound to.
- `{bool} auto_remove` - Whether the event function will be automatically removed once the event has been triggered.

----

## `EventArgs(instance)`
Struct containing information about an event. Is passed as an argument to `Event.trigger(event_args)` where a copy of the passed instance is given as an argument to all event functions in the event. This struct contains a `copy` method which creates a shallow copy of the struct, it doesn't break anything if called outside of an `Event` struct, but there's really no use in doing such.

### Struct variables
- `{instance or struct} instance` - The instance the event is bound to.
- `{Event} event` - The `Event` instance representing the event.

Note that this struct is meant to contain more variables than the ones listed above, specific to the unique purpose of the each event. Add them as you wish using `<EventArgs>.<variable_name>` before passing the struct to `Event.trigger(event_args)`.
