-- Shared course settings (ReplicatedStorage). Clients can read this, so no answers live here.
--
-- TO ADD A COURSE
--   1. Put a question file in ServerStorage.Courses named exactly like the course id
--      (copy Courses/TEMPLATE.lua).
--   2. Add the course below with its units, in the same order as the unit numbers
--      used in the question file.
local Config = {}

Config.Courses = {
	{
		id = "APUSH", name = "AP U.S. History", short = "APUSH", color = Color3.fromRGB(86, 140, 255),
		units = {
			{ label = "UNIT 1", detail = "1491–1607" },
			{ label = "UNIT 2", detail = "1607–1754" },
			{ label = "UNIT 3", detail = "1754–1800" },
			{ label = "UNIT 4", detail = "1800–1848" },
			{ label = "UNIT 5", detail = "1844–1877" },
			{ label = "UNIT 6", detail = "1865–1898" },
			{ label = "UNIT 7", detail = "1890–1945" },
			{ label = "UNIT 8", detail = "1945–1980" },
			{ label = "UNIT 9", detail = "1980–Present" },
		},
	},
	{
		id = "APBIO", name = "AP Biology", short = "AP BIO", color = Color3.fromRGB(72, 201, 137),
		units = {
			{ label = "UNIT 1", detail = "Chemistry of Life" },
			{ label = "UNIT 2", detail = "Cell Structure and Function" },
			{ label = "UNIT 3", detail = "Cellular Energetics" },
			{ label = "UNIT 4", detail = "Cell Communication and Cell Cycle" },
			{ label = "UNIT 5", detail = "Heredity" },
			{ label = "UNIT 6", detail = "Gene Expression and Regulation" },
			{ label = "UNIT 7", detail = "Natural Selection" },
			{ label = "UNIT 8", detail = "Ecology" },
		},
	},
}

Config.CourseById = {}
for _, course in ipairs(Config.Courses) do
	Config.CourseById[course.id] = course
end

-- Gate Run: how many questions to draw per unit, in random order (999 = all).
Config.Run = { stagesPerUnit = 999 }

-- Timed exam.
Config.Exam = { questions = 20, secondsPerQuestion = 45 }

-- Friend race.
Config.Race = { minPlayers = 2, maxPlayers = 6, questions = 10 }

return Config
