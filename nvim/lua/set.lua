local M = {}

---@alias Set table<any, true>

---@param list any[]
---@return Set
function M.from_list(list)
	local s = {}
	for _, v in ipairs(list) do
		s[v] = true
	end
	return s
end

---@param ... any
---@return Set
function M.create(...)
	return M.from_list({ ... })
end

---@param s Set
---@return any
function M.to_list(s)
	return vim.tbl_keys(s)
end

-- TODO: just leave this as s[v] == true?
---@param s Set
---@param v any
---@return boolean
function M.has(s, v)
	return s[v] == true
end

-- TODO: overload for vim.set.update(s1, s2) (extend with set)?
-- Check that {v} is a legit Lua key?
---@param s Set
---@param v any
function M.add(s, v)
	s[v] = true
end

---@param s Set
---@param v any
function M.remove(s, v)
	s[v] = nil
end

---@param s Set
---@return any
function M.pop(s)
	local val = next(s)
	s[val] = nil
	return val
end

---@param s Set
---@return integer
function M.size(s)
	local n = 0
	for _ in pairs(s) do
		n = n + 1
	end
	return n
end

---Elements from all sets combined: {s1} ∪ {s2} ∪ ...
---@param ... Set
---@return Set
function M.union(...)
	local out = {}
	for _, s in ipairs({ ... }) do
		for k in pairs(s) do
			out[k] = true
		end
	end
	return out
end

---Elements that are present in all sets: {s1} ∩ {s2} ∩ ...
---@param s1 Set
---@param ... Set
---@return Set
function M.intersection(s1, ...)
	local out = {}
	for k in pairs(s1) do
		local ok = true
		for _, s in ipairs({ ... }) do
			if not s[k] then
				ok = false
				break
			end
		end
		if ok then
			out[k] = true
		end
	end
	return out
end

---Elements in {s1} but not in the others: {s1} ∖ {s2} ∖ ...
---@param s1 Set
---@param ... Set
---@return Set
function M.difference(s1, ...)
	local out = vim.deepcopy(s1, true)
	for _, s in ipairs({ ... }) do
		for k in pairs(s) do
			out[k] = nil
		end
	end
	return out
end

---If all elements of {s1} are contained in {s2}: {s1} ⊆ {s2}.
---@param s1 Set
---@param s2 Set
---@return boolean
function M.issubset(s1, s2)
	return M.issuperset(s1, s2)
end

---If {s1} contains all elements from {s2}: {s1} ⊇ {s2}.
---@param s1 Set
---@param s2 Set
---@return boolean
function M.issuperset(s1, s2)
	for k, _ in pairs(s2) do
		if not s1[k] then
			return false
		end
	end
	return true
end

function M.isdisjoint(s1, s2)
	local smaller, larger = s1, s2
	if M.size(s1) > M.size(s2) then
		smaller, larger = s2, s1
	end

	for k in pairs(smaller) do
		if larger[k] then
			return false
		end
	end
	return true
end

--[[
- [x] set.add(
- [?] set.update(
- [x] set.remove(
- [?] set.discard(
- [x] set.pop(

- [?] set.clear(
- [?] set.copy(

- [x] set.intersection(
- [?] set.intersection_update(
- [x] set.difference(
- [?] set.difference_update(
- [ ] set.symmetric_difference(
- [?] set.symmetric_difference_update(
- [x] set.union(

- [x] set.issubset(
- [x] set.issuperset(
- [x] set.isdisjoint(
--]]


local function test()
	local a, b
	a = M.create('a', 'b', 'a')
	M.add(a, 'a')

	b = M.from_list({ 'b', 'd' })
	local diff = M.difference(a, b)
	vim.print(M.to_list(diff))

	vim.print(M.has(a, 'a'))
	for _, x in ipairs(M.to_list(a)) do

	end
end
test()

return M
