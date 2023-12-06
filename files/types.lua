---@enum pool
pools = {
	IDLE = 0,
	DAMAGETAKEN = 1,
	DAMAGEDEALT = 2,
	GENERIC = 3,
	ANY = 4,
	CUSTOM = 5,
}

---@class weighted_line
---@field weight number
---@field lines string[]

---@alias line_pool table<string, weighted_line[]>
