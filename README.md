# AP Study Hub Course Kit

The course format behind **[AP Study Hub](https://www.roblox.com/games/122095973244857/AP-Study-Hub)**, a free Roblox game where students study for AP exams together.

This kit lets any Roblox developer add a full multiple-choice course to a study game with one question file and a few lines of config. You don't have to write new game code for each course. AP Study Hub uses it to run 18 AP courses with about 150 original questions each. One question bank powers every mode: Gate Run, flashcards, timed exams, missed-question review and friend races.

## What's in here

| File | What it is |
|---|---|
| `src/Courses/TEMPLATE.lua` | Blank question bank to copy for a new course |
| `src/Courses/APUSH_SAMPLE.lua` | 10 real questions from the AP Study Hub APUSH bank |
| `src/Config.example.lua` | How courses and their units are listed |
| `src/CourseLoader.lua` | Loads, checks and shuffles question banks on the server |

## How it works

**The question format**

```lua
add(unit, "Question text?",
	{ "Correct answer", "Wrong", "Wrong", "Wrong" },
	"Short explanation shown after answering.",
	[[optional code block]])
```

- **The correct answer always goes first.** That makes banks easy to write and check by eye. The loader shuffles the choices before a player sees them.
- **Answer keys stay on the server.** Banks live in `ServerStorage`, which players can't read. Only the shuffled question goes to them, and the server checks the answer.
- **One bank, every mode.** Each question has a unit number, so the same file feeds unit select, random runs, exams and review.
- **Code and math work.** An optional fifth value shows a code block with its line breaks kept, for CS courses. Math uses real symbols (x², √x, ∫, π).

**CourseLoader checks every bank when the server starts** and warns you about:
- units that don't exist in Config
- questions with fewer than 2 or more than 4 choices
- duplicate choices
- duplicate questions

## Adding a course

1. Copy `src/Courses/TEMPLATE.lua` into `ServerStorage.Courses` as a ModuleScript. Name it the course id, like `APBIO`.
2. Add the course and its units to `Config.Courses`.
3. Write your questions. Start the server and fix anything CourseLoader warns about.

```lua
-- server
local CourseLoader = require(path.to.CourseLoader)
CourseLoader.loadAll()

local q = CourseLoader.draw("APUSH", { unit = 2 })
-- send q.public to the player (question, shuffled choices, optional code)
local right, why = CourseLoader.check(q, playerChoiceIndex)
```

`Config.example.lua` expects to live at `ReplicatedStorage.StudyHub.Config`. Change the `require` path at the top of `CourseLoader.lua` if you put it somewhere else.

## Question content

Every question in AP Study Hub is original, written from the public AP course frameworks. Please do the same. Don't copy questions from released exams, textbooks or review books.

AP and Advanced Placement are trademarks of the College Board, which is not affiliated with this project.

## License

MIT. See `LICENSE`. Use it in your own games, free or paid.
