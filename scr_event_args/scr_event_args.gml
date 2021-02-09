/// @func							EventArgs(instance)
/// @desc							Struct containing information about the current event.
/// @returns {EventArgs}			A new EventArgs struct.
/// @param {instance_or_struct} 	Instance

function EventArgs(instance) constructor {
	self.instance = instance;
	event = undefined;
	
	static copy = function() {
		var return_struct = new EventArgs(instance);
		var names = variable_struct_get_names(self);
		var current_name;
		var current_value;
		
		for (var i = 0; i < array_length(names); i++) {
			current_name = names[i];
			current_value = variable_struct_get(self, current_name);
			
			return_struct[$ current_name] = current_value;
		}
		
		return return_struct;
	}
}
