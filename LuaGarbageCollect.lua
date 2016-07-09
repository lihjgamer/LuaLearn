
table_0 = {1,2,3};
table_1 = {1,2,3};

table_2 = {
	 table_0;
	 table_1;
};


setmetatable(table_2,{__mode="kv"});
table_0 = nil;

collectgarbage();

print(table.getn(table_2))
print(table_2[1])
print(table_2[2])


--print(table_2["1"])




