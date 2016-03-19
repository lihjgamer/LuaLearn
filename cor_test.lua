
--[[
	简单介绍下 协成函数
	coroutine.create 创建协成
	coroutine.status 以字符串形式 输出协成协成状态 running suspended dead
	coroutine.yield  跳出协成，其携带的参数 作为 coroutine.resume 的额外返回值
	coroutine.resume 继续 从中断处执行 器携带的参数 作为yield 的返回值
--]]
local co_instance 
function corcoutine_fun(...)
	print(coroutine.status(co_instance));
	--print(...);
	local arglist = nil 
	math.randomseed(1000);
	while (true) do
		--arglist = {};
		print(coroutine.yield(math.random(1000)));

	end	
	--print("resume args : ",coroutine.yield(math.random(1000)));
end

co_instance = coroutine.create(corcoutine_fun);

print(coroutine.status(co_instance)); 				-- 刚创建的协成 默认是 suspended 状态
print(coroutine.resume(co_instance,1,2,3,4));		-- 
--print(coroutine.resume(co_instance));
print(coroutine.status(co_instance));
print(coroutine.resume(co_instance,"12312354",90,10));
print(coroutine.status(co_instance));
