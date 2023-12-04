local function get_valid_translation_idx()
	local idx = Random(1, #DIALOGUE_IDLE)
	local key = DIALOGUE_IDLE[idx][1]
	while GameTextGetTranslatedOrNot(key) == key or key == "" do
		idx = Random(1, #DIALOGUE_IDLE)
		key = DIALOGUE_IDLE[idx][1]
	end
	return idx
end

local function entity(stack, pos)
	dofile_once("mods/grahamsdialogue/files/dialogue.lua")
	local new = get_valid_translation_idx()
	stack[pos] = GameTextGetTranslatedOrNot(DIALOGUE_IDLE[new][1])
end

local function entity_and_line(stack, pos)
	dofile_once("mods/grahamsdialogue/files/dialogue.lua")
	local p = DIALOGUE_IDLE[get_valid_translation_idx()]
	local new = GameTextGetTranslatedOrNot(p[1])
	stack[pos] = new
	table.insert(stack, pos + 1, "say ")
	table.insert(stack, pos + 2, "\"")
	table.insert(stack, pos + 3, p[Random(2, #p)])
	table.insert(stack, pos + 4, "\" ")
end

local function just_line(stack, pos)
	local p = DIALOGUE_IDLE[Random(1, #DIALOGUE_IDLE)]
	stack[pos] = p[Random(2, #p)]
end

local function adjective(stack, pos)
	local opt = { "cute", "silly", "foolish", "brave", "cowardly", "giant", "tiny", "suspicious", "crazy" }
	stack[pos] = opt[Random(1, #opt)]
end

local function noun(stack, pos)
	local opt = { "fool", "hero", "coward", "legend", "warrior", "helper" }
	stack[pos] = opt[Random(1, #opt)]
end

local function verb(stack, pos)
	local opt = { "fishing", "cooking", "sleeping", "noiting", "eating", "walking", "burning" }
	stack[pos] = opt[Random(1, #opt)]
end

local function time(stack, pos)
	local opt = { "yesterday", "two days ago", "a while ago", "this morning", "earlier today", "2 years ago",
		"when I was eating" }
	for i = 1, 10 do table.insert(opt, "") end
	stack[pos] = opt[Random(1, #opt)]
end

local function line(stack, pos)
	local opt = {
		-- vscode has some unusual formatting ideas
		{ "I saw a",                                                Random(1, 10) <= 2 and adjective or "",                 Random(1, 10) <= 3 and noun or "", entity,                                 time,               "." },
		{ "I saw a",                                                Random(1, 10) <= 2 and adjective or "",                 entity_and_line,                   time,                                   "." },
		{ "I saw a",                                                Random(1, 10) <= 2 and adjective or "",                 entity,                            verb,                                   time,               "." },
		{ "I saw a",                                                Random(1, 10) <= 2 and adjective or "",                 entity,                            "being a",                              noun,               time,                                              "." },
		{ "I saw a",                                                Random(1, 10) <= 4 and adjective or "",                 entity,                            verb,                                   "." },
		{ "I killed a",                                             Random(1, 10) <= 2 and adjective or "",                 Random(1, 10) <= 3 and noun or "", entity,                                 time,               "." },
		{ "I caught",                                               Random(1, 20) == 1 and Random(70, 100) or Random(1, 5), entity,                            time,                                   "." },
		{ "I talked to a",                                          Random(1, 10) <= 4 and adjective or "",                 entity,                            time,                                   "and they said \"", line,                                              "\" can you believe it?" },
		{ "I said \"",                                              just_line,                                              "\" to a",                         Random(1, 10) == 1 and adjective or "", entity,             time,                                              "." },
		{ "I said \"",                                              just_line,                                              "\" to a",                         Random(1, 10) == 4 and adjective or "", entity,             time,                                              "and they said back \"", line, "\"", "." },
		{ "I hate it when",                                         entity_and_line,                                        "they are so annoying",            "." },
		{ "I ate a",                                                adjective,                                              entity,                            time,                                   ", they were",      Random(1, 2) == 1 and "disgusting" or "delicious", "." },
		{ just_line,                                                "." },
		{ Random(1, 1000) == 1 and "Robin was a fool" or just_line, "." }
	}
	local choice = opt[Random(1, #opt)]
	for k, v in ipairs(choice) do
		if k == 1 then
			stack[pos] = v
		else
			stack[pos + k - 1] = v
		end
	end
end

return function()
	SetRandomSeed(math.random(0, 10000), math.random(0, 10000))
	local stack = { line }
	local ptr = 1
	while ptr <= #stack do
		-- too advanced for lua LSP to understand
		local v = stack[ptr]
		if type(v) == "function" then
			v(stack, ptr)
		else
			ptr = ptr + 1
		end
	end
	built = ""
	local no_space = { ["\""] = true, ["!"] = true, [","] = true, ["."] = true }
	for k, v in ipairs(stack) do
		v = tostring(v) -- silly hax
		if no_space[built:sub(#built, #built)] or built == "" or v == "" or no_space[v:sub(1, 1)] then
			built = built .. v
		else
			built = built .. " " .. v
		end
	end
	dofile_once("mods/grahamsdialogue/files/lib/char_nonsense.lua")
	return strip_chars(built)
end
