local gameData = {}

gameData.enterEditMode=true

gameData.firstRun=true

gameData.toInsert=true

gameData.size="m"

gameData.collectedWords ={"Am","kl", "kla"}
gameData.collectedLetters = {"A", "l", "m","k", "a"}

gameData.customImages={}

gameData.indexEdit = 0

gameData.screenList = {}

gameData.screenIndex = 1

gameData.screenGridPositions = {}


gameData.homeScreenGridPosition = 1

gameData.isNumberScreen=false

gameData.changeSoundName=false
gameData.showSoundName=""

gameData.canTouch = true


gameData.amarJoti = {

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

gameData.toysScreen = {

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

gameData.peopleScreen = {
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


gameData.banglaNumberScreen = {
  
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

gameData.actionScreen = {
{ text="যেতে", audio="jete", image="go", ind=1 },
{ text="হাঁটা", audio="hata", image="walk", ind=2 },
{ text="", audio="", image="non", ind=3 },
--{ text="", audio="", image="run", ind=3 },
{ text="খেলা", audio="khela", image="game", ind=4 },
{ text="বসো", audio="boso", image="sit", ind=5 },
{ text="দাড়াও", audio="Daraw", image="stand", ind=6 },
{ text="সমস্যা", audio="smasswa", image="problem", ind=7 },

{ text="ধোয়া", audio="dhoya", image="wash", ind=8 },
{ text="গান", audio="gan", image="music", ind=9 },
{ text="খাওয়া", audio="khawa", image="eat", ind=10 },
{ text="", audio="", image="non", ind=11 },
{ text="", audio="", image="non", ind=12 },
{ text="", audio="", image="non", ind=13 },
{ text="", audio="", image="non", ind=14 },
{ text="", audio="", image="non", ind=15 },
{ text="", audio="", image="non", ind=16 }

}

gameData.emotionScreen = {
{ text="খুশি", audio="khushi", image="happy", ind=1 },
{ text="দুঃখ", audio="dukho", image="sad", ind=2 },
{ text="", audio="", image="non", ind=3 },
--{ text="", audio="", image="want", ind=3 },
{ text="পছন্দ না", audio="pochondona", image="dontlike", ind=4 },
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


gameData.banglaSorbornoScreen = {
{ text="", audio="a", image="a", ind=1 },
{ text="", audio="aa", image="aa", ind=2 },
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


gameData.banglaBenjorbornoScreen = {
{ text="", audio="k", image="k", ind=1 },
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

gameData.colourScreen = {
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


gameData.englishLetterScreen = {
{ text="", audio="Aaaa", image="Aaaa", ind=1 },
{ text="", audio="Bb", image="Bb", ind=2 },
{ text="", audio="Cc", image="Cc", ind=3 },
{ text="", audio="Dd", image="Dd", ind=4 },
{ text="", audio="Eeee", image="Eeee", ind=5 },
{ text="", audio="Ff", image="Ff", ind=6 },
{ text="", audio="Gg", image="Gg", ind=7 },
{ text="", audio="Hh", image="Hh", ind=8 },
{ text="", audio="Ii", image="Ii", ind=9},
{ text="", audio="Jj", image="Jj", ind=10 },
{ text="", audio="Kk", image="Kk", ind=11 },
{ text="", audio="Ll", image="Ll", ind=12 },
{ text="", audio="Mm", image="Mm", ind=13 },
{ text="", audio="Nnnnn", image="Nnnnn", ind=14 },
{ text="", audio="Ooo", image="Ooo", ind=15 },
{ text="", audio="Pp", image="Pp", ind=16 },
{ text="", audio="Qq", image="Qq", ind=17 },
{ text="", audio="Rr", image="Rr", ind=18 },
{ text="", audio="Ss", image="Ss", ind=19},
{ text="", audio="Tt", image="Tt", ind=20 },
{ text="", audio="Uu", image="Uu", ind=21 },
{ text="", audio="Vv", image="Vv", ind=22 },
{ text="", audio="Ww", image="Ww", ind=23 },
{ text="", audio="Xx", image="Xx", ind=24 },
{ text="", audio="Yy", image="Yy", ind=25 },
{ text="", audio="Zz", image="Zz", ind=26 },
{ text="", audio="", image="non", ind=27 },
{ text="", audio="", image="non", ind=28 },
{ text="", audio="", image="non", ind=29},
{ text="", audio="", image="non", ind=30},
{ text="", audio="", image="non", ind=31 },
{ text="", audio="", image="non", ind=32 }


}


gameData.englishNumberScreen = {
  
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

-- gameData.foodScreen = {
  
--  { text="এক", audio="1", image="one", ind=1 },
--  { text="দুই", audio="2", image="two", ind=2 },
--  { text="তিন", audio="3", image="three", ind=3 },
--  { text="চার", audio="4", image="four", ind=4 },
--  { text="পাঁচ", audio="5", image="five", ind=5 },
--  { text="ছয়", audio="6", image="six", ind=6 },
--  { text="সাত", audio="7", image="seven", ind=7 },
--  { text="আট", audio="8", image="eight", ind=8 },
--  { text="নয়", audio="9", image="nine", ind=9 },
--  { text="শূন্য", audio="0", image="zero", ind=10 },
--  { text="পাঁচ", audio="5", image="five", ind=11 },
--  { text="ছয়", audio="6", image="six", ind=12 },
--  { text="সাত", audio="7", image="seven", ind=13 },
--  { text="আট", audio="8", image="eight", ind=14 },
--  { text="নয়", audio="9", image="nine", ind=15 },
--  { text="শূন্য", audio="0", image="zero", ind=16 }

-- }

gameData.commonScreen = {
  
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


gameData.workingScreen = {
  
 { text="", audio="", image="", ind=1 },
 { text="", audio="", image="", ind=2 },
  { text="", audio="", image="", ind=3 },
   { text="", audio="", image="", ind=4 },
    { text="", audio="", image="", ind=5 },
     { text="", audio="", image="", ind=6 },
      { text="", audio="", image="", ind=7 },
       { text="", audio="", image="", ind=8 }

}

gameData.workingScreenNumber = {
  
 { text="", audio="", image="", ind=1 },
 { text="", audio="", image="", ind=2 },
  { text="", audio="", image="", ind=3 },
   { text="", audio="", image="", ind=4 },
    { text="", audio="", image="", ind=5 },
     { text="", audio="", image="", ind=6 },
      { text="", audio="", image="", ind=7 },
       { text="", audio="", image="", ind=8 },
        { text="", audio="", image="", ind=9 },
         { text="", audio="", image="", ind=10 }

}


  gameData.screenList = {gameData.amarJoti, gameData.toysScreen, 

  gameData.peopleScreen, gameData.banglaNumberScreen, gameData.actionScreen,

  gameData.emotionScreen, gameData.banglaSorbornoScreen, gameData.banglaBenjorbornoScreen, 

  gameData.colourScreen, gameData.englishLetterScreen, gameData.englishNumberScreen,  gameData.commonScreen

 }


 for sgp = 1, #gameData.screenList do

    gameData.screenGridPositions[sgp] = 1

end

gameData.saveFile=""

gameData.defaultImages = {
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
                          ,"plate","ruler","specialChair","spoon","stool","switch","table","toylet","1","2","3","4","5","6","7","8","9","0"
                      }

gameData.defaultSounds = {"ma","baba","bhai","bhon","bichana","khudarto","toilet",
                          "shikhok","boi","table","pencil","betha","matha","pet","dukho","khushi",
                          "aro","alo","amake","amar","ami","apni","asa","aste","badami","bag","bangla",
                          "bari","bosa","beguni","biggan","bikel","biroti","bokkosthol","bondho",
                          "bondhokora","boso","chacha","Chachi","chai","chair","chatri","chatro","chele",
                          "chokh","chul","computer","dada","dadi","darate","Daraw","dath","dhormoshikka",
                          "dhoya","dorja","dukkhito","dupurerkhabar","dushor","engreji","etihash","fan","gan",
                          "ghar","ghum","ghumate","golapi","gonith","ha","haath","hata","hathe","holud","jethe",
                          "jete","jolkhabar","joralo","juta","kagoj","kalo","kan","ke","kharap","khawa","khela",
                          "khete","kokhon","kolom","kom","komola","kuthay","lal","light","maponi","meye","mohila",
                          "moyla","muchni","mukh","na","nak","nana","nani","nasta","nil","nirob","ondhokar","opekkhakora",
                          "pa","pakha","pan","pani","pit","pochondo","pochondona","poriskar","prodhanShikkhika","prodip",
                          "proyojon","proyojonna","purush","rat","rabar","rupali","sangith","school","schoole","scooldrees",
                          "shada","shanto","sharpner","shart","she","shikkhika","smasswa","sobuj","sokal","sonali",
                          "sondavujon","sondha","tablet","tader","tar","tara","tawjers","tumar","ucchoaawaj","valo",
                          "vanga","vugol","a","aa","i","ee","u","oo","ri","ae","aae","o","au","k","kh","g","gh","ng",
                          "ch","chh","j","jh","n","t","tth","d","ddh","nn","thho","th","the","thhe","nnn","pa",
                          "pha","ba","bha","maa","ya","ra","la","sa","sshh","haa","rhha","drha","yaa","ktt","onn","bss","chn",
                          "Aaaa","Bb","Cc","Dd","Eeee","Ff","Gg","Hh","Ii","Jj","Kk","Ll","Mm",
                          "Nnnnn","Ooo","Pp","Qq","Rr","Ss","Tt","Uu","Vv","Ww","Xx","Yy","Zz","bati",
                          "bench","besin","bisesChair","chamoch","ghori","glass","switch","thala","tul","khelna","khelnaGari",
                          "khelnaKengaru","khelnaPutul","khelnaShinho","1","2","3","4","5","6","7","8","9","0"
                        }

gameData.defaultSoundsBangla = {"মা","বাবা","ভাই","বোন","বিছানা","ক্ষুদার্থ","টয়লেট",
                          "শিক্ষক","বই","টেবিল","পেন্সিল","ব্যথা","মাথা","পেট","দুঃখ","খুশি",
                          "আরো","আলো","আমাকে","আমার","আমি","আপনি","আসা","আসতে","বাদামী","ব্যাগ","বাংলা",
                          "বাড়ি","বসা","বেগুনি","বিজ্ঞান","বিকেল","বিরতি","বক্ষস্থল","বন্ধ",
                          "বন্ধ করা","বসও","চাচা","চাচী","চাই","চেয়ার","ছাত্রী","ছাত্র","ছেলে",
                          "চোখ","চুল","কম্পিউটার","দাদা","দাদী","দাঁড়াতে","দাড়াও","দাঁত","ধর্ম শিক্ষা",
                          "ধোয়া","দরজা","দু:খিত","দুপুরের খাবার","ধূসর","ইংরেজি","ইতিহাস","ফ্যান","গান",
                          "ঘাড়","ঘুম","ঘুমাতে","গোলাপী","গণিত","হ্যাঁ","হাত","হাঁটা","হাঁটতে"," হলুদ","যাওয়া",
                          "যেতে","জলখাবার","জোরালো"," জুতা","কাগজ","কালো","কান","কে","খারাপ","খাওয়া","খেলা",
                          "খেতে","কখন","কলম","কম","কমলা","কোথায়","লাল","লাইট","মাপনী","মেয়ে","মহিলা",
                          "ময়লা","রুলার","মুখ","না","নাক","নানা","নানী","নাস্তা","নীল","নীরব","অন্ধকার","অপেক্ষা করা",
                          "পা","পাখা","পান","পানি","পিঠ","পছন্দ","পছন্দ না","পরিষ্কার","প্রধান শিক্ষিকা","প্রদীপ",
                          "প্রয়োজন","প্রয়োজন না","পুরুষ","রাত","রাবার","রূপালী","সঙ্গীত","স্কুল","স্কুলে","স্কুলের পোশাক",
                          "সাদা","শান্ত"," শার্পনার","শার্ট","সে","শিক্ষিকা","সমস্যা","সবুজ","সকাল","সোনালী",
                          "সান্ধ্যভোজন","সন্ধ্যা"," ট্যাবলেট","তাদের","তার","তারা","ট্রাউজার্স","তোমার","উচ্চস্বর","ভাল",
                          "ভাঙা","ভূগোল","বেসিন ","বাটি","বেঞ্চ","ঘড়ি","গ্লাস","থালা","বিশেষ চেয়ার","চামচ","টুল","সুইচ",
                          "খেলনা গাড়ি","খেলনা","খেলনা পুতুল","খেলনা ক্যাঙ্গারু","খেলনা সিংহ","One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Zero"
                        }


return gameData

--{ text="", audio="", image="non", ind=8 },