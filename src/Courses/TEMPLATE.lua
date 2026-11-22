-- COURSE QUESTION BANK TEMPLATE
--
-- 1. Copy this file into ServerStorage.Courses as a ModuleScript.
-- 2. Name it exactly like the course id in Config (for example "APBIO").
-- 3. Replace the example questions with your own.
--
-- Keep it in ServerStorage: clients can't read ServerStorage, so players
-- can never see the answer key.
--
-- RULE: choices[1] is ALWAYS the correct answer. CourseLoader shuffles the
-- choices before anything is sent to a player.
--
-- Write your own questions. Don't copy questions from released exams,
-- textbooks or review books.

local Bank = {}

-- unit   : unit number, matching the order of `units` in Config (1, 2, 3...)
-- q      : the question text
-- choices: 2 to 4 answers, correct answer first
-- why    : one or two sentences shown after the player answers
-- code   : optional block of code shown under the question (keep line breaks)
local function add(unit, q, choices, why, code)
	table.insert(Bank, { unit = unit, q = q, choices = choices, why = why, code = code })
end

-- UNIT 1: Example unit name
add(1, "Example question: what is 2 + 2?",
	{ "4", "3", "5", "22" },
	"Adding 2 and 2 gives 4.")

-- A question with a code block (use [[ ]] so line breaks are kept)
add(1, "What does this Java code print?",
	{ "6", "5", "7", "Nothing" },
	"x starts at 5 and x++ adds one before it is printed.",
	[[int x = 5;
x++;
System.out.println(x);]])

-- UNIT 2: Example unit name
add(2, "Use real math symbols, not plain-text stand-ins: what is the derivative of x²?",
	{ "2x", "x", "2x²", "x³/3" },
	"Power rule: bring down the 2 and subtract one from the exponent.")

return Bank
