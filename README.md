# GML Events
A collection of scripts implementing C#-style events in GML.

See [documentation](DOCS.md) for information regarding use of individual methods and structs.



## How to use
Construct a new event using `new Event()`, and ideally store in an instance variable or somewhere other objects can easily access. To add an event function to the event, use `Event.add` and pass the function you want the event to trigger, and optionally the instance the method should be bound to (`global` by default) and whether the event function should automatically be removed from the event once it's been triggered. To trigger the event, use `Event.trigger` inside the object the event was declared in, but first construct an `EventArgs` struct containing the instance which triggered the event and whatever other info you wish your event function methods to have access to.
