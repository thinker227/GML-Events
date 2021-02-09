/// @func										EventFuncInfo(func_method, instance, auto_remove)
/// @desc										Struct containing information about the event func that is currently being executed.
/// @returns {EventFuncInfo}					A new EventFuncInfo struct.
/// @param {method} func_method					Method to add.
/// @param {instance_or_struct} instance		Instance method is bound to.
/// @param {bool} auto_remove					Whether to automatically remove function from event when the event is triggered.

function EventFuncInfo(func_method, instance, auto_remove) constructor {
	self.func_method = func_method;
	self.instance = instance;
	self.auto_remove = auto_remove;
}
