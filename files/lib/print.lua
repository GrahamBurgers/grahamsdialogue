local function print_tabbed(tabbing,text)
	msg = ""
	for i = 1,tabbing do
		msg = msg.."\t"
	end
	print(msg..text)
end
function print_any(object,iter,prefix)
	iter = iter or 0
	prefix = prefix or ""
	if type(object) == "table" then
		if prefix == "" then
			print_tabbed(iter,prefix.."{")
		else
			print_tabbed(iter,prefix..": {")
		end
		for k,v in pairs(object) do
			print_any(v,iter+1,tostring(k))
		end
		print_tabbed(iter,"}")
	else
		if prefix == "" then
			print_tabbed(iter,type(object):sub(1,2):upper().."("..tostring(object)..")")
		else
			print_tabbed(iter,table.concat({prefix,": ",type(object):sub(1,3),"(",tostring(object),")"}))
		end
	end
end