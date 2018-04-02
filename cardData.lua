--[[local cardData = {}

return cardData--]]


local cardData = {}

cardData.studentName=""

cardData.topics={}


--common
cardData.topics[1] = {
{ text="common", audio="", image="", ind=0 },
 { text="আমি ", audio="ami", image="me", ind=1 },
 { text="বাড়ি", audio="bari", image="home", ind=2 },
 { text="ব্যথা", audio="batha", image="pain", ind=3 },
 { text="চাই", audio="cai", image="want", ind=4 },
 { text="দুঃখ", audio="dukkhito", image="sad", ind=5 },
 { text="ঘুম", audio="ghum", image="sleep", ind=6 },
 { text="খেতে", audio="khete", image="eat", ind=7 },
 { text="খুশি", audio="khushi", image="happy", ind=8 },
 { text="মাথা", audio="matha", image="head", ind=9 },
 { text="পান", audio="pan", image="drink", ind=10 },
 { text="পানি", audio="pani", image="water", ind=11 },
 { text="পেট", audio="pet", image="stomach", ind=12 },
 { text="পছন্দ", audio="pochondo", image="like", ind=13 },
 { text="পছন্দ না", audio="pochondona", image="dontlike", ind=14 },
 { text="স্কুল", audio="school", image="school", ind=15 },
 { text="সমস্যা", audio="somossa", image="problem", ind=16 },
 { text="সন্ধ্যা ভুজন", audio="sondavujon", image="dinner", ind=17 },
 { text="তুমি", audio="tumi", image="you", ind=18 },
 { text="উচ্চস্বর", audio="ucchoshor", image="loud", ind=19 },
 { text="টয়লেট ", audio="toilet", image="toilet", ind=20 },
 { text="", audio="", image="non", ind=21 },
 { text="", audio="", image="non", ind=22 },
 { text="", audio="", image="non", ind=23 },
 { text="", audio="", image="non", ind=24 }
}


--bangla number
cardData.topics[2] = {
{ text="bengaliNumbers", audio="", image="", ind=0 },
 { text="এক", audio="1", image="one", ind=1 },
 { text="দুই", audio="2", image="two", ind=2 },
 { text="তিন", audio="3", image="three", ind=3 },
 { text="চার", audio="4", image="four", ind=4 },
 { text="পাঁচ", audio="5", image="five", ind=5 },
 { text="ছয়", audio="6", image="six", ind=6 },
 { text="সাত", audio="7", image="seven", ind=7 },
 { text="আট", audio="8", image="eight", ind=8 },
 { text="নয়", audio="9", image="nine", ind=9 },
 { text="শূন্য", audio="0", image="zero", ind=10 }
}

--english number
cardData.topics[3] = {
{ text="englishNumbers", audio="", image="", ind=0 },
 { text="One", audio="1", image="1", ind=1 },
 { text="Two", audio="2", image="2", ind=2 },
 { text="Three", audio="3", image="3", ind=3 },
 { text="Four", audio="4", image="4", ind=4 },
 { text="Five", audio="5", image="5", ind=5 },
 { text="Six", audio="6", image="6", ind=6 },
 { text="Seven", audio="7", image="7", ind=7 },
 { text="Eight", audio="8", image="8", ind=8 },
 { text="Nine", audio="9", image="9", ind=9 },
 { text="Zero", audio="0", image="0", ind=10 }
}

-- sorborno screen
cardData.topics[4] = {
{ text="bengalilLettersShorborno", audio="", image="", ind=0 },
{ text="অ", audio="a", image="a", ind=1 },
{ text="আ", audio="aa", image="aa", ind=2 },
{ text="", audio="i", image="i", ind=3 },
{ text="", audio="ee", image="ee", ind=4 },
{ text="", audio="u", image="u", ind=5 },
{ text="", audio="oo", image="oo", ind=6 },
{ text="", audio="ri", image="ri", ind=7 },
{ text="", audio="ae", image="ae", ind=8 },
{ text="", audio="aae", image="aae", ind=9 },
{ text="", audio="o", image="o", ind=10},
{ text="", audio="au", image="au", ind=11 },
{ text="", audio="", image="non", ind=12 },
{ text="", audio="", image="non", ind=13 },
{ text="", audio="", image="non", ind=14 },
{ text="", audio="", image="non", ind=15 },
{ text="", audio="", image="non", ind=16 }
}

--borno

cardData.topics[5] = {
{ text="bengalilLettersBenjonborno", audio="", image="", ind=0 },
{ text="ক", audio="k", image="k", ind=1 },
{ text="", audio="kh", image="kh", ind=2 },
{ text="", audio="g", image="g", ind=3 },
{ text="", audio="gh", image="gh", ind=4 },
{ text="", audio="ng", image="ng", ind=5 },
{ text="", audio="ch", image="ch", ind=6 },
{ text="", audio="chh", image="chh", ind=7 },
{ text="", audio="j", image="j", ind=8 },
{ text="", audio="jh", image="jh", ind=9},
{ text="", audio="n", image="n", ind=10 },
{ text="", audio="t", image="t", ind=11 },
{ text="", audio="tth", image="tth", ind=12 },
{ text="", audio="d", image="d", ind=13 },
{ text="", audio="ddh", image="ddh", ind=14 },
{ text="", audio="nn", image="nn", ind=15 },
{ text="", audio="thho", image="thho", ind=16 },
{ text="", audio="th", image="th", ind=17 },
{ text="", audio="the", image="the", ind=18 },
{ text="", audio="thhe", image="thhe", ind=19},
{ text="", audio="nnn", image="nnn", ind=20 },
{ text="", audio="pa", image="pa", ind=21 },
{ text="", audio="pha", image="pha", ind=22 },
{ text="", audio="ba", image="ba", ind=23 },
{ text="", audio="bha", image="bha", ind=24 },
{ text="", audio="maa", image="maa", ind=25 },
{ text="", audio="ya", image="ya", ind=26 },
{ text="", audio="ra", image="ra", ind=27 },
{ text="", audio="la", image="la", ind=28 },
{ text="", audio="sa", image="sa", ind=29},
{ text="", audio="shh", image="shh", ind=30},
{ text="", audio="sshh", image="sshh", ind=31 },
{ text="", audio="haa", image="haa", ind=32 },
{ text="", audio="rhha", image="rhha", ind=33 },
{ text="", audio="drha", image="drha", ind=34 },
{ text="", audio="yaa", image="yaa", ind=35 },
{ text="", audio="ktt", image="ktt", ind=36 },
{ text="", audio="onn", image="onn", ind=37 },
{ text="", audio="bss", image="bss", ind=38 },
{ text="", audio="chn", image="chn", ind=39 },
{ text="", audio="", image="non", ind=40 }
}

--english letters

cardData.topics[6] = {
{ text="englishLetters", audio="", image="", ind=0 },
{ text="A", audio="Aaaa", image="Aaaa", ind=1 },
{ text="B", audio="Bb", image="Bb", ind=2 },
{ text="C", audio="Cc", image="Cc", ind=3 },
{ text="D", audio="Dd", image="Dd", ind=4 },
{ text="E", audio="Eeee", image="Eeee", ind=5 },
{ text="F", audio="Ff", image="Ff", ind=6 },
{ text="G", audio="Gg", image="Gg", ind=7 },
{ text="H", audio="Hh", image="Hh", ind=8 },
{ text="I", audio="Ii", image="Ii", ind=9},
{ text="J", audio="Jj", image="Jj", ind=10 },
{ text="K", audio="Kk", image="Kk", ind=11 },
{ text="L", audio="Ll", image="Ll", ind=12 },
{ text="M", audio="Mm", image="Mm", ind=13 },
{ text="N", audio="Nnnnn", image="Nnnnn", ind=14 },
{ text="O", audio="Ooo", image="Ooo", ind=15 },
{ text="P", audio="Pp", image="Pp", ind=16 },
{ text="Q", audio="Qq", image="Qq", ind=17 },
{ text="R", audio="Rr", image="Rr", ind=18 },
{ text="S", audio="Ss", image="Ss", ind=19},
{ text="T", audio="Tt", image="Tt", ind=20 },
{ text="U", audio="Uu", image="Uu", ind=21 },
{ text="V", audio="Vv", image="Vv", ind=22 },
{ text="W", audio="Ww", image="Ww", ind=23 },
{ text="X", audio="Xx", image="Xx", ind=24 },
{ text="Y", audio="Yy", image="Yy", ind=25 },
{ text="Z", audio="Zz", image="Zz", ind=26 },
{ text="", audio="", image="non", ind=27 },
{ text="", audio="", image="non", ind=28 },
{ text="", audio="", image="non", ind=29},
{ text="", audio="", image="non", ind=30},
{ text="", audio="", image="non", ind=31 },
{ text="", audio="", image="non", ind=32 }
}


--for amarjoti

cardData.topics[7]={
{ text="school", audio="", image="", ind=0 },
{ text=" বেসিন ", audio="besin", image="basin", ind=1 },
{ text="বাটি", audio="bati", image="bati", ind=2 },
{ text="বেঞ্চ", audio="bench", image="bench", ind=3 },
{ text="চেয়ার", audio="chair", image="chair", ind=4 },
{ text="ঘড়ি", audio="ghori", image="clock", ind=5 },
{ text="কম্পিউটার", audio="computer", image="computer1", ind=6 },
{ text="দরজা", audio="dorja", image="door1", ind=7 },
{ text="ফ্যান", audio="fan", image="fan", ind=8 },
{ text="গ্লাস", audio="glass", image="glass", ind=9 },
{ text="থালা", audio="thala", image="plate", ind=10 },
{ text="রুলার", audio="ruler", image="ruler", ind=11 },
{ text="বিশেষ চেয়ার", audio="bisesChair", image="specialChair", ind=12 },
{ text="চামচ", audio="chamoch", image="spoon", ind=13 },
{ text="টুল", audio="tul", image="stool", ind=14 },
{ text="সুইচ", audio="switch", image="switch", ind=15 },
{ text="টেবিল", audio="table", image="table", ind=16 },
{ text="টয়লেট", audio="toilet", image="toylet", ind=17 },
{ text="", audio="", image="non", ind=18 },
{ text="", audio="", image="non", ind=19 },
{ text="", audio="", image="non", ind=20 },
{ text="", audio="", image="non", ind=21 },
{ text="", audio="", image="non", ind=22 },
{ text="", audio="", image="non", ind=23 },
{ text="", audio="", image="non", ind=24 }
}

--people
cardData.topics[8]={
{ text="people", audio="", image="", ind=0 },
{ text="মা", audio="ma", image="mum", ind=1 },
{ text="বাবা", audio="baba", image="dad", ind=2 },
{ text="ছেলে", audio="chele", image="boy", ind=3 },
{ text="মেয়ে", audio="meye", image="girl", ind=4 },
{ text="পুরুষ", audio="purush", image="man", ind=5 },
{ text="মহিলা", audio="mohila", image="woman", ind=6 },
{ text="পা", audio="paa", image="leg", ind=7 },
{ text="মাথা", audio="matha", image="head", ind=8 },
{ text="চুল", audio="chul", image="hair", ind=9 },
{ text="হাত", audio="haath", image="arm", ind=10 },
{ text="পেট", audio="pet", image="stomach", ind=11 },
{ text="নাক", audio="nak", image="nose", ind=12 },
{ text="চোখ", audio="chokh", image="eyes", ind=13 },
{ text="কান", audio="kan", image="ear", ind=14 },
{ text="মুখ", audio="mukh", image="mouth", ind=15 },
{ text="দাঁত", audio="dath", image="teeth", ind=16 },
{ text="", audio="", image="non", ind=17 },
{ text="", audio="", image="non", ind=18 },
{ text="", audio="", image="non", ind=19 },
{ text="", audio="", image="non", ind=20 },
{ text="", audio="", image="non", ind=21 },
{ text="", audio="", image="non", ind=22 },
{ text="", audio="", image="non", ind=23 },
{ text="", audio="", image="non", ind=24 },
{ text="", audio="", image="non", ind=25 },
{ text="", audio="", image="non", ind=26 },
{ text="", audio="", image="non", ind=27 },
{ text="", audio="", image="non", ind=28 },
{ text="", audio="", image="non", ind=29 },
{ text="", audio="", image="non", ind=30 },
{ text="", audio="", image="non", ind=31 },
{ text="", audio="", image="non", ind=32 }
}


--action
cardData.topics[9]={
{ text="action", audio="", image="", ind=0 },
{ text="যেতে", audio="jete", image="go", ind=1 },
{ text="হাঁটা", audio="hata", image="walk", ind=2 },
{ text="ধোয়া", audio="dhoya", image="wash", ind=3 },
--{ text="", audio="", image="run", ind=3 },
{ text="খাওয়া", audio="khawa", image="eat", ind=4 },
{ text="খেলা", audio="khela", image="game", ind=5 },
{ text="বসো", audio="boso", image="sit", ind=6 },
{ text="দাড়াও", audio="Daraw", image="stand", ind=7 },
{ text="সমস্যা", audio="smasswa", image="problem", ind=8 },

{ text="গান", audio="gan", image="music", ind=9 },
{ text="", audio="", image="non", ind=10 },
{ text="", audio="", image="non", ind=11 },
{ text="", audio="", image="non", ind=12 },
{ text="", audio="", image="non", ind=13 },
{ text="", audio="", image="non", ind=14 },
{ text="", audio="", image="non", ind=15 },
{ text="", audio="", image="non", ind=16 }
}


--emotion
cardData.topics[10]={
{ text="emotion", audio="", image="", ind=0 },
{ text="খুশি", audio="khushi", image="happy", ind=1 },
{ text="দুঃখ", audio="dukho", image="sad", ind=2 },
{ text="পছন্দ না", audio="pochondona", image="dontlike", ind=3 },
{ text="", audio="", image="non", ind=4 },
{ text="", audio="", image="non", ind=5 },
{ text="", audio="", image="non", ind=6 },
{ text="", audio="", image="non", ind=7 },
{ text="", audio="", image="non", ind=8 },
{ text="", audio="", image="non", ind=9 },
{ text="", audio="", image="non", ind=10 },
{ text="", audio="", image="non", ind=11 },
{ text="", audio="", image="non", ind=12 },
{ text="", audio="", image="non", ind=13 },
{ text="", audio="", image="non", ind=14 },
{ text="", audio="", image="non", ind=15 },
{ text="", audio="", image="non", ind=16 }

}

--color
cardData.topics[11] = {
{ text="colours", audio="", image="", ind=0 },
{ text="লাল", audio="lal", image="red", ind=1 },
{ text="হলুদ", audio="holud", image="yellow", ind=2 },
{ text="সবুজ", audio="sobuj", image="green", ind=3 },
{ text="নীল", audio="nil", image="blue", ind=4 },
{ text="কালো", audio="kalo", image="black", ind=5 },
{ text="সাদা", audio="shada", image="white", ind=6 },
{ text="গোলাপী", audio="golapi", image="pink", ind=7 },
{ text="বেগুনি", audio="beguni", image="purple", ind=8 },
{ text="কমলা", audio="komola", image="orange", ind=9 },
{ text="বাদামী", audio="badami", image="brown", ind=10 },
{ text="ধূসর", audio="dushor", image="grey", ind=11 },
{ text="রূপালী", audio="rupali", image="silver", ind=12 },
{ text="সোনালী", audio="sonali", image="golden", ind=13 },
{ text="", audio="", image="non", ind=14 },
{ text="", audio="", image="non", ind=15 },
{ text="", audio="", image="non", ind=16 }
}

--toys
cardData.topics[12] = {
{ text="toys", audio="", image="", ind=0 },
	{ text="খেলনা", audio="khelna", image="toy1", ind=1 },
{ text="খেলনা", audio="khelna", image="toy2", ind=2 },
{ text="খেলনা", audio="khelna", image="toy3", ind=3 },
{ text="খেলনা", audio="khelna", image="toy4", ind=4 },
{ text="খেলনা", audio="khelna", image="toy5", ind=5 },
{ text="খেলনা", audio="khelna", image="toy6", ind=6 },
{ text="খেলনা", audio="khela", image="toy7", ind=7 },
{ text="খেলনা", audio="khelna", image="toy8", ind=8 },
{ text="খেলনা", audio="khelna", image="toy10", ind=9 },
{ text="খেলনা", audio="khelna", image="toy11", ind=10 },
{ text="খেলনা", audio="khelna", image="toy12", ind=11 },
{ text="খেলনা পুতুল", audio="khelnaPutul", image="toyBear", ind=12 },
{ text="খেলনা গাড়ি", audio="khelnaGari", image="toyCar1", ind=13 },
{ text="খেলনা গাড়ি", audio="khelnaGari", image="toyCar2", ind=14 },
{ text="খেলনা গাড়ি", audio="khelnaGari", image="toyCar3", ind=15 },
{ text="খেলনা গাড়ি", audio="khelnaGari", image="toyCar4", ind=16 },
{ text="খেলনা পুতুল", audio="khelnaPutul", image="toyDoll2", ind=17 },
{ text="খেলনা পুতুল", audio="khelnaPutul", image="toyDoll3", ind=18 },
{ text="খেলনা ক্যাঙ্গারু", audio="khelnaKengaru", image="toyKangaroo", ind=19 },
{ text="খেলনা সিংহ", audio="khelnaShinho", image="toyLion", ind=20 },
{ text="", audio="", image="non", ind=21 },
{ text="", audio="", image="non", ind=22 },
{ text="", audio="", image="non", ind=23 },
{ text="", audio="", image="non", ind=24 },
{ text="", audio="", image="non", ind=25 },
{ text="", audio="", image="non", ind=26 },
{ text="", audio="", image="non", ind=27 },
{ text="", audio="", image="non", ind=28 },
{ text="", audio="", image="non", ind=29 },
{ text="", audio="", image="non", ind=30 },
{ text="", audio="", image="non", ind=31 },
{ text="", audio="", image="non", ind=32 }
}


--story
cardData.topics[13] = {
{ text="stories", audio="", image="", ind=0 },
 { text="", audio="", image="story1", ind=1 },
 { text="", audio="", image="story2", ind=2 },
 { text="", audio="", image="story3", ind=3 },
 { text="", audio="", image="story4", ind=4 },
 { text="", audio="", image="story5", ind=5 },
 { text="", audio="", image="story6", ind=6 },
 { text="", audio="", image="story7", ind=7 },
 { text="", audio="", image="story8", ind=8 },
 { text="", audio="", image="story9", ind=9 },
 { text="", audio="", image="story10", ind=10 },
 { text="", audio="", image="story11", ind=11 },
 { text="", audio="", image="story12", ind=12 },
 { text="", audio="", image="story13", ind=13 },
 { text="", audio="", image="non", ind=14 },
 { text="", audio="", image="non", ind=15 },
 { text="", audio="", image="non", ind=16 }
}





cardData.defaultImages = {
                          "afternoon","arm","bag","blackboard","book","boy","break","broken","chair","clean","computer","dark","dinner",
                          "dirty","dontlike","door","drink","ear","eat","englishbook","eraser","eyes","fan","foot",
                          "game","geography","girl","go","hair","hand","happy","head","headteacher",
                          "historybook","leg","light","loud","lunch","man","mathbook","midday","morning","mouth","music","night","no","nose","pain",
                          "paper","pen","pencil","problem","quiet","religion","ruler","run","sad","scared","science","sharpener","shirt",
                          "shoes","sit","sleep","stand","stomach","stop","student","tablet","teacher","teeth","toilet",
                          "trousers","walk","want","wash","water","what","when","where","whiteboard","who","window","woman","yes",
                          "a","aa","i","ee","u","oo","ri","ae","aae","o","au","k","kh","g","gh","ng","ch","chh","j","jh","n","t","tth","d","ddh","nn","thho","th","the","thhe","nnn","pa",
                          "pha","ba","bha","maa","ya","ra","la","sa","sshh","haa","rhha","drha","yaa","ktt","onn","bss","chn","Aaaa","Bb","Cc","Dd","Eeee","Ff","Gg","Hh","Ii","Jj","Kk","Ll","Mm",
                          "Nnnnn","Ooo","Pp","Qq","Rr","Ss","Tt","Uu","Vv","Ww","Xx","Yy","Zz","basin","bati","bench","chair","clock","computer1","door1","fan","glass"
                          ,"plate","ruler","specialChair","spoon","stool","switch","table","toylet","1","2","3","4","5","6","7","8","9","0","story1","story2","story3","story4","story5","story6","story7","story8","story9","story10","story11","story12","story13"
                      }
                      

cardData.englishBangla ={"ma","মা",  "baba","বাবা",  "bhai","ভাই",    "bhon","বোন"    ,"bichana","বিছানা",   "khudarto","ক্ষুদার্থ",   "toilet","টয়লেট","shikhok","শিক্ষক",  "boi","বই",  "table","টেবিল",  
                         "pencil","পেন্সিল",  "betha","ব্যথা",  "matha","মাথা",  "pet","পেট",  "dukho","দুঃখ",  "khushi","খুশি",   "aro","আরো",  "alo","আলো",  "amake","আমাকে",  "amar","আমার",  "ami","আমি",
                         "apni","আপনি",  "asa","আসা",  "aste","আসতে",  "badami","বাদামী",  "bag","ব্যাগ",  "bangla","বাংলা",  "bari","বাড়ি",  "bosa","বসা",  "beguni","বেগুনি",  "biggan","বিজ্ঞান",  
                         "bikel","বিকেল",  "biroti","বিরতি",  "bokkosthol","বক্ষস্থল",  "bondho","বন্ধ",    "bondhokora","বন্ধ করা",  "boso","বসও",  "chacha","চাচা","Chachi","চাচী",  "chai","চাই",  "chair","চেয়ার",  
                         "chatri","ছাত্রী",  "chatro","ছাত্র",  "chele","ছেলে",  "chokh","চোখ",  "chul","চুল",  "computer","কম্পিউটার",  "dada","দাদা",  "dadi","দাদী",  "darate","দাঁড়াতে",  "Daraw","দাড়াও",  "dath","দাঁত",
                         "dhormoshikka","ধর্ম শিক্ষা",  "dhoya","ধোয়া",  "dorja","দরজা",  "dukkhito","দু:খিত",  "dupurerkhabar","দুপুরের খাবার",  "dushor","ধূসর",  "engreji","ইংরেজি",  "etihash","ইতিহাস",  "fan","ফ্যান",  "gan","গান",
                         "ghar","ঘাড়",  "ghum","ঘুম",  "ghumate","ঘুমাতে",  "golapi","গোলাপী",  "gonith","গণিত",  "ha","হ্যাঁ",  "haath","হাত",  "hata","হাঁটা",  "hathe","হাঁটতে",  "holud","হলুদ",  "jethe","যাওয়া",
                         "jete","যেতে",  "jolkhabar","জলখাবার",  "joralo","জোরালো",  "juta","জুতা",  "kagoj","কাগজ",  "kalo","কালো",  "kan","কান",  "ke","কে",  "kharap","খারাপ",  "khawa","খাওয়া",  "khela","খেলা",
                         "khete","খেতে",  "kokhon","কখন",  "kolom","কলম",  "kom","কম",  "komola","কমলা",  "kuthay","কোথায়",  "lal","লাল",  "light","লাইট",  "maponi","মাপনী",  "meye","মেয়ে",  "mohila","মহিলা","moyla","ময়লা",  
                         "muchni","রুলার",  "mukh","মুখ",  "na","না",  "nak","নাক",  "nana","নানা",  "nani","নানী",  "nasta","নাস্তা",  "nil","নীল",  "nirob","নীরব",  "ondhokar","অন্ধকার",  "opekkhakora","অপেক্ষা করা",
                         "pa","পা",  "pakha","পাখা",  "pan","পান",  "pani","পানি",  "pit","পিঠ",  "pochondo","পছন্দ",  "pochondona","পছন্দ না",  "poriskar","পরিষ্কার",  "prodhanShikkhika","প্রধান শিক্ষিকা",  "prodip","প্রদীপ",
                         "proyojon","প্রয়োজন",  "proyojonna","প্রয়োজন না",  "purush","পুরুষ",  "rat","রাত",  "rabar","রাবার",  "rupali","রূপালী",  "sangith","সঙ্গীত",  "school","স্কুল",  "schoole","স্কুলে",  "scooldrees","স্কুলের পোশাক",
                         "shada","সাদা",  "shanto","শান্ত",  "sharpner","শার্পনার",  "shart","শার্ট",  "she","সে",  "shikkhika","শিক্ষিকা",  "smasswa","সমস্যা",  "sobuj","সবুজ",  "sokal","সকাল",  "sonali","সোনালী",
                         "sondavujon","সান্ধ্যভোজন",  "sondha","সন্ধ্যা",  "tablet","ট্যাবলেট",  "tader","তাদের",  "tar","তার",  "tara","তারা",  "tawjers","ট্রাউজার্স",  "tumar","তোমার",  "ucchoaawaj","উচ্চস্বর",  "valo","ভাল",
                         "vanga","ভাঙা",  "vugol","ভূগোল",  "bati","বাটি",  "besin","বেসিন",  "bench","বেঞ্চ",  "ghori","ঘড়ি", "bisesChair","বিশেষ চেয়ার", "chamoch", "চামচ",  "glass","গ্লাস",  "switch","সুইচ", "thala","থালা",  
                         "tul","টুল",  "khelna","খেলনা",  "khelnaGari","খেলনা গাড়ি",  "khelnaKengaru","খেলনা ক্যাঙ্গারু", "khelnaPutul","খেলনা পুতুল",   "khelnaShinho","খেলনা সিংহ",  "aalote","আলোতে",  "apnader","আপনাদের",  
                         "apnar","আপনার",  "apni","আপনি",  "babar","বাবার",  "babake","বাবাকে",  "barite","বাড়িতে",   "bathroome","বাথরুমে",    "berate","বেড়াতে",  "bicanay","বিছানায়",  "bichanate","বিছানাতে",  "boner","বোনের",  "bonke","বোনকে",  
                          "boro","বড়",  "boromach","বড়োমাছ",  "cuto","ছোট", "cutomach","ছোটমাছ",  "darate","দাঁড়াতে",  "Dhute","ধুতে",  "dukkhito","দুঃখিত",  "ekhane","এখানে",  "ghore","ঘরে",  "ghumabo","ঘুমাবো",  "gorom","গরম",
                          "jabo","যাবো",  "kacakachi","কাছাকাছি",  "klanto","ক্লান্ত",  "maar","মার",  "make","মাকে",  "pore","পরে"
                          }




return cardData
