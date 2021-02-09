/// @func					Event()
/// @desc					Constructs a new Event.
/// @returns {Event}		A new Event struct, representing an Event invokable through Event.trigger(event_args).

function Event() constructor {
	
	// Private readonly struct variables
	__getset_func_list = function(val) {
		static func_list = undefined;
		if (func_list == undefined) func_list = val;
		return func_list;
	}
	__getset_func_list(ds_list_create());
	
	__getset_instance = function(val) {
		static instance = undefined;
		if (instance == undefined) instance = val;
		return instance;
	}
	__getset_instance(other);
	
	
	
	/// @func										add(func, instance, auto_remove)
	/// @desc										Adds an event function to the event.
	/// @returns {EventFuncInfo}					An EventFuncInfo struct corresponding to the arguments provided.
	/// @param {method} func						The method to be called when the event is triggered. This method is rebound to the specified instance.
	/// @param {instance_or_struct} instance		The instance to bind the specified method to. Default: global.
	/// @param {bool} auto_remove					Whether to automatically remove the event function when the event is triggered. Default: false.
	
	static add = function(func, instance, auto_remove) {
		
		// Default arguments
		if (instance == undefined) instance = global;
		if (auto_remove == undefined) auto_remove = false;
		
		// Argument type exceptions
		if (func == undefined || !is_method(func)) __exception_invalid_argument("event function", string(func));
		if (!instance_exists(instance) && instance != global) __exception_invalid_argument("instance", string(instance));
		//if (!is_bool(auto_remove)) throw string(auto_remove) + " not a boolean value";		Broken
		
		var func_method = method(instance, func);
		var func_info = new EventFuncInfo(func_method, instance, auto_remove);
		ds_list_add(__getset_func_list(), func_info);
		return func_info;
		
	}
	
	
	
	/// @func									remove(func_info)
	/// @desc									Removes an event function from the event.
	/// @returns {bool}							Whether the specified event function was successfully removed.
	/// @param {EventFuncInfo} func_info		The event function to remove from the event.
	
	static remove = function(func_info) {
		
		if (instanceof(func_info) != "EventFuncInfo") __exception_invalid_constructor(string(func_info), "func info", "EventFuncInfo");
		
		var func_list = __getset_func_list();
		for (var i = 0; i < ds_list_size(func_list); i++) {
			if (func_info == func_list[| i]) {
				ds_list_delete(func_list, i);
				return true;
			}
		}
		
		return false;
		
	}
	
	
	
	/// @func								trigger(event_args)
	/// @desc								Triggers the event.
	/// @returns {}							
	/// @param {EventArgs} event_args		The arguments for the event.
	
	static trigger = function(event_args) {
		
		// Shorthand for func_list/instance
		var func_list = __getset_func_list();
		var bound_instance = __getset_instance();
		
		if (ds_list_size(func_list) == 0) return;
		
		// Trigger instance exception
		if (other != bound_instance) __exception_invalid_caller();
		
		// Default arguments and exceptions
		if (event_args == undefined) event_args = new EventArgs(bound_instance);
		if (instanceof(event_args) != "EventArgs") __exception_invalid_constructor(string(event_args), "event args", "EventArgs");
		var event_args_copy = event_args.copy();
		event_args_copy.event = self;
		
		// Loop through event funcs
		var func_info;
		for (var i = 0; i < ds_list_size(func_list); i++) {
			func_info = func_list[| i];
			
			func_info.func_method(event_args_copy.copy(), func_info);
			
			if (func_info.auto_remove) {
				ds_list_delete(func_list, i);
				i--;
			}
		}
		
	}
	
	
	
	/// @func			destroy()
	/// @desc			Destroys and cleans up the event.
	/// @returns {}		
	
	static destroy = function() {
		
		ds_list_destroy(__getset_func_list());
		
	}
	
	
	
	/// @func			clear()
	/// @desc			Clears the event's event functions.
	/// @returns {}		
	
	static clear = function() {
		
		ds_list_clear(__getset_func_list());
		
	}
	
	
	
	// Exceptions
	static __exception_invalid_argument = function(type, value) {
		throw "invalid " + type + " " + string(value) + ".";
	};
	static __exception_invalid_constructor = function(struct, argument_name, constructor_name) {
		throw "invalid " + argument_name + " " + string(struct) + ", " +
		argument_name + " struct has to be constructed from constructor " + constructor_name + ".";
	};
	static __exception_invalid_caller = function() {
		throw "cannot trigger event from outside instance."
	};
	
}
