function event_add(event, func, instance, auto_remove) {
	event.add(func, instance, auto_remove);
}

function event_remove(event, func_info) {
	event.remove(func_info);
}

function event_trigger(event, event_args) {
	event.trigger(event_args);
}

function event_destory(event) {
	event.destroy();
}

function event_clear(event) {
	event.clear();
}
