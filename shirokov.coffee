msg = """приходи ёпта я тебя нахуй блядь ушатаю так что забудешь как тебя зовут понял
хули ты блядь даёшь-то ишак ебаный
ебало закрыл своё
я для тебя вообще не играю
ты чёрт ёпта галимый
мне похуй можешь дома сидеть ёпта понял блядь
ещё раз напишете я вас там отпизжу всех нахуй понятно
пидармотина ебаная
вы болеть-то нихуя не умеете
конченные блядь отродья
думаешь там пятьдесят человек у тебя пришло ты такой крутой
хули ты блякаешь-то ёпта
ты вообще ебало закрой чтобы тебя не видно было понял нахуй
здесь что ли хочешь остаться
не для такого быдла как вот это
какого хуя ты туда вылетел-то ёпта мне интересно
что нет-то ёпта что нет
вы чего быдлятина все блядь нахуй ёпта в одном стаде ёпта
это для тебя нормально а для меня нет ёпта
с хуя это я должен футболку ему отдавать
ты мне объясни-ка блядь
ты за слова свои отвечаешь
петух ебаный нахуй"""

phrases = msg.split("\n").map((s) -> s.split(" "))

unique_words = []
phrases.forEach((p) -> p.reduce(
    (r, w) ->

        if not (w in r)

            r.push(w)

        return r

    , unique_words)
)

table = {}
for phrase in phrases

    for i in [1...phrase.length]

        table[phrase[i - 1]] ?= []
        seq = table[phrase[i - 1]]
        wi = unique_words.indexOf(phrase[i])

        if not (wi in seq)

            seq.push(wi)


random = (to, from=0) ->

    return Math.min(to, Math.floor(Math.random() * (to - from)))


gen_phrase = (len) =>

    phrase = []
    cwi = random(unique_words.length - 1)

    while phrase.length < len

        cw = unique_words[cwi]
        phrase.push(cw)

        if table[cw]?

            cwi = table[cw][random(table[cw].length - 1)]

        else

            cwi = random(unique_words.length - 1)

    return phrase.join(" ")


leading_zeroes = (n, len=2) ->

    s = n.toString()
    while s.length < len

        s = "0" + s

    return s


gen_content = () =>

    phrase = gen_phrase(15)
    $("#txt").text(phrase)
    $("#pic").attr("src", "roman/#{leading_zeroes(random(31, 1))}.jpg")


$(gen_content)
