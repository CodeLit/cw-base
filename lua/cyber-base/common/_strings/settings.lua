CWStr.FoulPatterns = {
    'хуй', 'хуя', 'хуе', 'хуё',
    'анал', 'анальн',
    'пизд',
    'жопа', 'ебал', 'соси',
    'дибил', 'дебил',
    'даун', 'гандон', 'чмо',
    'пидар', 'пидор', 'пидр',
    'твою мать', 'гнида',
    'сука', 'сцук', 'сучка',
    'конченый', 'кончел',
    'ебо', 'еба', 'еби', 'ебы', 'ебла',
    'бля', 'хуле',
    'хули', 'уебывай', 'лошара', 'лошпет', 'шлюха', 'твар',
    'паскуда', 'мразь', 'трах',
    'мудак', 'мудил', 'мудач', 'мудац',
    'fuck', 'suck', 'cock', 'dick',
}

CWStr.UpperLowerKV = {
	['А'] = 'а',
	['Б'] = 'б',
	['В'] = 'в',
	['Г'] = 'г',
	['Д'] = 'д',
	['Е'] = 'е',
	['Ё'] = 'ё',
	['Ж'] = 'ж',
	['З'] = 'з',
	['И'] = 'и',
	['Й'] = 'й',
	['К'] = 'к',
	['Л'] = 'л',
	['М'] = 'м',
	['Н'] = 'н',
	['О'] = 'о',
	['П'] = 'п',
	['Р'] = 'р',
	['С'] = 'с',
	['Т'] = 'т',
	['У'] = 'у',
	['Ф'] = 'ф',
	['Х'] = 'х',
	['Ц'] = 'ц',
	['Ч'] = 'ч',
	['Ш'] = 'ш',
	['Щ'] = 'щ',
	['Ъ'] = 'ъ',
	['Ы'] = 'ы',
	['Ь'] = 'ь',
	['Э'] = 'э',
	['Ю'] = 'ю',
	['Я'] = 'я'
}

CWStr.LowerUpperKV = {}

-- Создаём такую же таблицу, только наоборот
for k, v in pairs(CWStr.UpperLowerKV) do
	CWStr.LowerUpperKV[v] = k
end