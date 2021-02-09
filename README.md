# GML Events
A collection of scripts implementing C#-style events in GML.

## How to use

### `Event()`
To create a new event, use `new Event()`. This constructs a struct containing methods for adding event functions to the event, removing event functions from the event, triggering the event, deleting the event, and clearing the event. The struct also contains methods beginning with `__`, these are *private* methods and **should not** be called from outside the struct.



### `Event.add(func, \[instance], \[auto_remove])`
Adds an event function to the event.

#### Arguments
- `{method} func` - The method to trigger once the event is triggered. This method will be rebound to `instance`.
- `{instance or struct} instance` - Optional, defaults to `global`. The instance to bind `func` to.
- `{bool} auto_remove` - Option, defaults to `false`. Whether to automatically remove the event function from the event when the event is triggered.

#### Returns
An `EventFuncInfo` instance corresponding to the arguments provided. Equivalent to `new EventFuncInfo(func, instance, auto_remove)`.


### `Event.remove(func_info)`
Removes an event function from the event.

#### Arguments
- `{EventFuncInfo} func_info` - The event function to remove from the event.

#### Returns
A boolean value corresponding to whether the event function was successfully removed.
