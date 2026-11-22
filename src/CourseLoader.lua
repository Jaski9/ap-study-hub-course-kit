-- CourseLoader (ServerScriptService or ServerStorage, server only)
--
-- Loads every question bank in ServerStorage.Courses, checks it for mistakes,
-- and hands out shuffled questions that never include the answer key.
--
-- Usage (server):
--   local CourseLoader = require(path.to.CourseLoader)
--   CourseLoader.loadAll()                         -- call once on server start
--   local q = CourseLoader.draw("APUSH", { unit = 2 })
--   -- send q.public to the player; keep q.correct on the server
--   local right, why = CourseLoader.check(q, playerChoiceIndex)

local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Config = require(ReplicatedStorage:WaitForChild("StudyHub"):WaitForChild("Config"))

local CourseLoader = {}
CourseLoader.Banks = {} -- [courseId] = { questions }

local rng = Random.new()

-- Two questions with the same text but different code blocks are different questions.
local function keyOf(item)
	return item.q .. "\0" .. (item.code or "")
end

local function shuffled(list)
	local copy = table.clone(list)
	for i = #copy, 2, -1 do
		local j = rng:NextInteger(1, i)
		copy[i], copy[j] = copy[j], copy[i]
	end
	return copy
end

-- Returns a list of problems found in a bank (empty list = all good).
function CourseLoader.validate(courseId, bank)
	local problems = {}
	local course = Config.CourseById[courseId]
	local unitCount = course and #course.units or 0
	if not course then
		table.insert(problems, courseId .. ": no matching course in Config.Courses")
	end
	local seen = {}
	for i, item in ipairs(bank) do
		local where = string.format("%s #%d", courseId, i)
		if type(item.q) ~= "string" or item.q == "" then
			table.insert(problems, where .. ": missing question text")
		end
		if type(item.unit) ~= "number" or item.unit < 1 or (course and item.unit > unitCount) then
			table.insert(problems, where .. ": unit " .. tostring(item.unit) .. " is not in Config")
		end
		if type(item.choices) ~= "table" or #item.choices < 2 or #item.choices > 4 then
			table.insert(problems, where .. ": needs 2 to 4 choices")
		else
			local dupe = {}
			for _, c in ipairs(item.choices) do
				if dupe[c] then
					table.insert(problems, where .. ": duplicate choice \"" .. tostring(c) .. "\"")
				end
				dupe[c] = true
			end
		end
		if type(item.q) == "string" then
			local key = keyOf(item)
			if seen[key] then
				table.insert(problems, where .. ": same question as #" .. seen[key])
			end
			seen[key] = i
		end
	end
	return problems
end

function CourseLoader.loadAll()
	local folder = ServerStorage:WaitForChild("Courses")
	for _, course in ipairs(Config.Courses) do
		local module = folder:FindFirstChild(course.id)
		if not module then
			warn("[CourseLoader] no question file for " .. course.id)
			continue
		end
		local ok, bank = pcall(require, module)
		if not ok then
			warn("[CourseLoader] " .. course.id .. " failed to load: " .. tostring(bank))
			continue
		end
		for _, problem in ipairs(CourseLoader.validate(course.id, bank)) do
			warn("[CourseLoader] " .. problem)
		end
		CourseLoader.Banks[course.id] = bank
	end
end

-- Draw one question. opts.unit limits it to one unit; opts.exclude is a set of
-- question keys (q.key) to skip, for example ones the player just saw.
function CourseLoader.draw(courseId, opts)
	opts = opts or {}
	local bank = CourseLoader.Banks[courseId]
	if not bank or #bank == 0 then
		return nil
	end
	local pool = {}
	for _, item in ipairs(bank) do
		if (not opts.unit or item.unit == opts.unit) and not (opts.exclude and opts.exclude[keyOf(item)]) then
			table.insert(pool, item)
		end
	end
	if #pool == 0 then
		return nil
	end
	local item = pool[rng:NextInteger(1, #pool)]
	local choices = shuffled(item.choices)
	local correct = table.find(choices, item.choices[1])
	return {
		key = keyOf(item), -- use with opts.exclude
		correct = correct, -- server only
		why = item.why, -- send after the player answers
		public = { q = item.q, choices = choices, unit = item.unit, code = item.code },
	}
end

-- Draw a whole run: units in order, up to `perUnit` random questions from each.
function CourseLoader.drawRun(courseId, perUnit)
	local course = Config.CourseById[courseId]
	local run = {}
	if not course then
		return run
	end
	for unit = 1, #course.units do
		local picked = {}
		for _ = 1, perUnit or Config.Run.stagesPerUnit do
			local q = CourseLoader.draw(courseId, { unit = unit, exclude = picked })
			if not q then
				break
			end
			picked[q.key] = true
			table.insert(run, q)
		end
	end
	return run
end

function CourseLoader.check(question, choiceIndex)
	return choiceIndex == question.correct, question.why
end

return CourseLoader
