
-- 这里用来构建类,实现类的继承
function class(...)
	local class_type = {};
	class_type.__is_class = true;
	class_type.__super_class = arg or {};

	--[[
	local function check_parent_class(parent_class_list)
		for _,parent_class in ipairs(parent_class_list) do
			if not parent_class.__is_class then
				return false;
			end
		end
		return true;
	end

	if not check_parent_class(arg) then
		return nil;
	end
	--]]

	
	function class_type.new()
		local class_obj = {};

		setmetatable(class_obj,
		{
			__index = class_type;
			-- __newindex = class_type;() 
		});
		
		-- 构造函数名字 ctor (约定的规则)
		class_obj:recursive("ctor");
		return class_obj;
	end
	
	local function do_recursive(class_obj,class_type,func_name,...)
		for _,super_class in ipairs(class_type.__super_class) do
			if super_class.__is_class and not class_obj.ctor_list[super_class] then
				class_obj.ctor_list[super_class] = 1;
				do_recursive(class_obj,super_class,func_name,unpack(arg));
			end
		end
		
		local func = rawget(class_type,func_name);
		if func and type(func) == "function" then
			func(class_obj,unpack(arg));
		end
	end
	
	function class_type.recursive(obj,func_name)
		obj.ctor_list = {};
		do_recursive(obj,class_type,func_name);
		obj.ctor_list = nil;
	end
	
	setmetatable(class_type,
	{
		__index = function(tb,k)
			--local val = nil;
			for _,parent_class in ipairs(class_type.__super_class) do
				local val = parent_class[k];
				if val then
					return val;
				end
			end
			return nil;
		end
	});

	return class_type;
end