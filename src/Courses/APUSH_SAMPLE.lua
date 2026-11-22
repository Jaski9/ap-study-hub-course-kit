-- AP U.S. History sample bank: a small sample of questions from AP Study Hub.
-- RULE: choices[1] is ALWAYS the correct answer. CourseLoader shuffles before sending to players.
-- All questions are original and written from the APUSH course framework.
local Bank = {}

local function add(unit, q, choices, why)
	table.insert(Bank, { unit = unit, q = q, choices = choices, why = why })
end

-- UNIT 1 (1491-1607)
add(1, "The Columbian Exchange refers to the transfer of what between the Eastern and Western Hemispheres?",
	{ "Crops, livestock, diseases, and people", "Colonial charters and legal systems", "Gold, silver, and precious gems", "Military technology and weapons" },
	"Plants, animals, diseases, and people crossed the Atlantic, reshaping societies on both sides.")
add(1, "Under the Spanish encomienda system, colonists were granted the right to:",
	{ "Demand labor or tribute from Native peoples", "Own all land without owing the Crown", "Trade freely with every European power", "Govern their towns without Spanish oversight" },
	"Encomienda gave Spanish colonists control over Native labor and tribute, and it was often brutal.")
add(1, "Which Spanish conquistador led the conquest of the Aztec Empire beginning in 1519?",
	{ "Hernán Cortés", "Francisco Pizarro", "Juan Ponce de León", "Hernando de Soto" },
	"Cortés allied with Native rivals of the Aztecs and, with the help of disease, overthrew Tenochtitlan. Pizarro conquered the Inca.")

-- UNIT 2 (1607-1754)
add(2, "Which cash crop made the Virginia colony economically successful in the early 1600s?",
	{ "Tobacco", "Sugar", "Rice", "Indigo" },
	"John Rolfe's tobacco created a profitable export and fueled demand for labor in the Chesapeake.")
add(2, "The Mayflower Compact (1620) is significant because it:",
	{ "Set a precedent for self-government by consent of the governed", "Created one constitution for all thirteen colonies", "Granted Plymouth full independence from England", "Banned the Church of England from the colony" },
	"Pilgrim leaders agreed to make and obey laws for the general good, an early example of self-rule.")
add(2, "The 1680 Pueblo Revolt in present-day New Mexico was a rebellion against:",
	{ "Spanish rule and forced religious conversion", "English tax policies", "French fur-trading monopolies", "Dutch land purchases" },
	"Led by Popé, Pueblo peoples drove the Spanish out of New Mexico for over a decade.")
add(2, "Roger Williams founded which colony, known for religious tolerance and separation of church and state?",
	{ "Rhode Island", "Pennsylvania", "Maryland", "Georgia" },
	"Banished from Massachusetts Bay, Williams founded Providence, which grew into Rhode Island.")
add(2, "Bacon's Rebellion (1676) in Virginia was driven mainly by:",
	{ "Frontier settlers angry about the governor's Native American policy", "Merchants protesting taxes on sugar", "Enslaved Africans demanding freedom", "Puritans seeking control of Virginia's churches" },
	"Nathaniel Bacon's followers, many of them poor frontier farmers, wanted land and action against Native peoples.")
add(2, "The First Great Awakening of the 1730s and 1740s mainly:",
	{ "Promoted emotional faith and challenged church authority", "Strengthened the Church of England's control over the colonies", "Ended religious diversity in the colonies", "Led to the founding of Georgia" },
	"Preachers like Jonathan Edwards and George Whitefield sparked revivals that questioned established clergy.")

-- UNIT 3 (1754-1800)
add(3, "The Proclamation of 1763 prohibited colonists from:",
	{ "Settling west of the Appalachian Mountains", "Trading with French merchants", "Printing their own newspapers", "Electing colonial assemblies" },
	"Britain wanted to avoid costly conflicts with Native nations after the French and Indian War, angering colonists who wanted western land.")

return Bank
