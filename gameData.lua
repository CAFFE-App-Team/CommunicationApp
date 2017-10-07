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

gameData.screenGridPositions ={}

gameData.homeScreenGridPosition = 1

gameData.isNumberScreen=false

gameData.changeSoundName=false
gameData.showSoundName=""

gameData.homeScreen = {

{ text="সান্ধ্যভোজন", audio="sondavujon", image="dinner", ind=1 },
{ text="ময়লা", audio="moyla", image="dirty", ind=2 },
{ text="পরিষ্কার", audio="poriskar", image="clean", ind=3 },
{ text="দরজা", audio="dorja", image="door", ind=4 },
{ text="পান", audio="pan", image="drink", ind=5 },
{ text="খাওয়া", audio="khawa", image="eat", ind=6 },
{ text="খেলা", audio="khela", image="game", ind=7 },
{ text="লাইট", audio="light", image="light", ind=8 },
{ text="উচ্চস্বর", audio="ucchoaawaj", image="loud", ind=9 },
{ text="দুপুরের খাবার", audio="dupurerkhabar", image="lunch", ind=10 },
{ text="টয়লেট", audio="toilet", image="toilet", ind=11 },
{ text="সমস্যা", audio="smasswa", image="problem", ind=12 },
{ text="নীরব", audio="nirob", image="quiet", ind=13 },
{ text="শার্ট", audio="shart", image="shirt", ind=14 },
{ text="জুতা", audio="juta", image="shoes", ind=15 },
{ text="ঘুম", audio="ghum", image="sleep", ind=16 },
{ text="ট্রাউজার্স", audio="tawjers", image="trousers", ind=17 },
{ text="ধোয়া", audio="dhoya", image="wash", ind=18 },
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
{ text="", audio="", image="non", ind=32 },
{ text="", audio="", image="non", ind=33 },
{ text="", audio="", image="non", ind=34 },
{ text="", audio="", image="non", ind=35 },
{ text="", audio="", image="non", ind=36 },
{ text="", audio="", image="non", ind=37 },
{ text="", audio="", image="non", ind=38 },
{ text="", audio="", image="non", ind=39 },
{ text="", audio="", image="non", ind=40 }
 

}

gameData.peopleScreen = {
{ text="মা", audio="ma", image="mum", ind=1 },
{ text="বাবা", audio="baba", image="dad", ind=2 },
{ text="ছেলে", audio="chele", image="boy", ind=3 },
{ text="মেয়ে", audio="meye", image="girl", ind=4 },
{ text="পুরুষ", audio="purush", image="man", ind=5 },
{ text="মহিলা", audio="mohila", image="woman", ind=6 },
{ text="পা", audio="pa", image="leg", ind=7 },
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


gameData.schoolScreen = {

{ text="ব্যাগ", audio="bag", image="bag", ind=1 },
{ text="", audio="", image="non", ind=2 },
--{ text="", audio="", image="blackboard", ind=2 },
{ text="বই", audio="boi", image="book", ind=3 },
{ text="কলম", audio="kolom", image="pen", ind=4 },
{ text="পেন্সিল", audio="pencil", image="pencil", ind=5 },
{ text="শিক্ষক", audio="shikhok", image="teacher", ind=6 },
{ text="ছাত্র", audio="chatro", image="student", ind=7 },
{ text="ভাঙা", audio="vanga", image="break", ind=8 },
{ text="চেয়ার", audio="chair", image="chair", ind=9 },
{ text="কম্পিউটার", audio="computer", image="computer", ind=10 },
{ text="", audio="", image="non", ind=11 },
--{ text="", audio="", image="englishbook", ind=11 },
{ text="মুছনী", audio="muchni", image="eraser", ind=12 },
{ text="ভূগোল", audio="vugol", image="geography", ind=13 },
{ text="খেলা", audio="khela", image="game", ind=14 },
{ text="প্রধান শিক্ষিকা", audio="prodhanShikkhika", image="headteacher", ind=15 },
{ text="", audio="", image="non", ind=16 },
--{ text="", audio="", image="historybook", ind=16 },
{ text="দুপুরের খাবার", audio="dupurerkhabar", image="lunch", ind=17 },
{ text="", audio="", image="non", ind=18 },
--{ text="", audio="", image="mathbook", ind=18 },
{ text="গান", audio="gan", image="music", ind=19 },
{ text="কাগজ", audio="kagoj", image="paper", ind=20 },
{ text="ধর্ম শিক্ষা", audio="dhormoshikka", image="religion", ind=21 },
{ text="মাপনী", audio="maponi", image="ruler", ind=22 },
{ text="বিজ্ঞান", audio="biggan", image="science", ind=23 },
{ text="শার্পনার", audio="sharpner", image="sharpener", ind=24 },
{ text="বসা", audio="boso", image="sit", ind=25 },
{ text="দাড়াও", audio="Daraw", image="stand", ind=26 },
{ text="ট্যাবলেট", audio="tablet", image="tablet", ind=27 },
{ text="টয়লেট", audio="toilet", image="toilet", ind=28 },
{ text="কম্পিউটার", audio="computer", image="computer", ind=29 },
--{ text="", audio="", image="whiteboard", ind=30 }
--{ text="", audio="", image="window", ind=31 },
{ text="", audio="", image="non", ind=30 },
{ text="", audio="", image="non", ind=31 },
{ text="ফ্যান", audio="fan", image="fan", ind=32 },
{ text="", audio="", image="non", ind=33 },
{ text="", audio="", image="non", ind=34 },
{ text="", audio="", image="non", ind=35 },
{ text="", audio="", image="non", ind=36 },
{ text="", audio="", image="non", ind=37 },
{ text="", audio="", image="non", ind=38 },
{ text="", audio="", image="non", ind=39 },
{ text="", audio="", image="non", ind=40 }
 }

gameData.timeScreen = {
{ text="সকাল", audio="sokal", image="morning", ind=1 },
{ text="রাত", audio="rat", image="night", ind=2 },
{ text="", audio="", image="non", ind=3 },
{ text="", audio="", image="non", ind=4 },
{ text="", audio="", image="non", ind=5 },
-- { text="", audio="", image="midday", ind=2 },
-- { text="", audio="", image="afternoon", ind=3 },

-- { text="", audio="", image="break", ind=5 },
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

gameData.actionScreen = {
{ text="যাওয়া", audio="jawa", image="go", ind=1 },
{ text="হাঁটা", audio="hata", image="walk", ind=2 },
{ text="", audio="", image="non", ind=3 },
--{ text="", audio="", image="run", ind=3 },
{ text="খেলা", audio="khela", image="game", ind=4 },
{ text="বসা", audio="boso", image="sit", ind=5 },
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


gameData.questionScreen = {
{ text="হ্যাঁ", audio="ha", image="yes", ind=1 },
{ text="না", audio="na", image="no", ind=2 },
{ text="কে", audio="ke", image="who", ind=3 },
{ text="", audio="", image="non", ind=4 },
-- { text="", audio="", image="what", ind=4 },
{ text="কোথায়", audio="kuthay", image="where", ind=5 },
{ text="কখন", audio="kokhon", image="when", ind=6 },
{ text="সমস্যা", audio="smasswa", image="problem", ind=7 },
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
 { text="শূন্য", audio="0", image="zero", ind=10 },

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
{ text="", audio="ma", image="ma", ind=25 },
{ text="", audio="ya", image="ya", ind=26 },
{ text="", audio="ra", image="ra", ind=27 },
{ text="", audio="la", image="la", ind=28 },
{ text="", audio="sa", image="sa", ind=29},
{ text="", audio="shh", image="shh", ind=30},
{ text="", audio="sshh", image="sshh", ind=31 },
{ text="", audio="ha", image="ha", ind=32 },
{ text="", audio="rhha", image="rhha", ind=33 },
{ text="", audio="drha", image="drha", ind=34 },
{ text="", audio="yaa", image="yaa", ind=35 },
{ text="", audio="ktt", image="ktt", ind=36 },
{ text="", audio="onn", image="onn", ind=37 },
{ text="", audio="bss", image="bss", ind=38 },
{ text="", audio="chn", image="chn", ind=39 },
{ text="", audio="", image="non", ind=40 }


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



gameData.screenList = {gameData.homeScreen, gameData.schoolScreen, 

  gameData.peopleScreen, gameData.banglaNumberScreen, gameData.actionScreen,

  gameData.emotionScreen, gameData.questionScreen,gameData.timeScreen,
   gameData.banglaSorbornoScreen,gameData.banglaBenjorbornoScreen,  gameData.colourScreen

 }


for sgp=1, #gameData.screenList do

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
                          "pha","ba","bha","ma","ya","ra","la","sa","sshh","ha","rhha","drha","yaa","ktt","onn","bss","chn"
                      }

gameData.defaultSounds = {"ma","baba","bhai","bhon","bichana","khudarto","toilet",
                          "shikhok","boi","table","pencil","betha","matha","pet","dukho","khushi",
                          "aro","alo","amake","amar","ami","apni","asa","aste","badami","bag","bangla",
                          "bari","bosa","beguni","biggan","bikel","biroti","bokkosthol","bondho",
                          "bondhokora","boso","chacha","Chachi","chai","chair","chatri","chatro","chele",
                          "chokh","chul","computer","dada","dadi","darate","Daraw","dath","dhormoshikka",
                          "dhoya","dorja","dukkhito","dupurerkhabar","dushor","engreji","etihash","fan","gan",
                          "ghar","ghum","ghumate","golapi","gonith","ha","haath","hata","hathe","holud","jawa",
                          "jete","jolkhabar","joralo","juta","kagoj","kalo","kan","ke","kharap","khawa","khela",
                          "khete","kokhon","kolom","kom","komola","kuthay","lal","light","maponi","meye","mohila",
                          "moyla","muchni","mukh","na","nak","nana","nani","nasta","nil","nirob","ondhokar","opekkhakora",
                          "pa","pakha","pan","pani","pit","pochondo","pochondona","poriskar","prodhanShikkhika","prodip",
                          "proyojon","proyojonna","purush","rat","rabar","rupali","sangith","school","schoole","scooldrees",
                          "shada","shanto","sharpner","shart","she","shikkhika","smasswa","sobuj","sokal","sonali",
                          "sondavujon","sondha","tablet","tader","tar","tara","tawjers","tumar","ucchoaawaj","valo",
                          "vanga","vugol","a","aa","i","ee","u","oo","ri","ae","aae","o","au","k","kh","g","gh","ng",
                          "ch","chh","j","jh","n","t","tth","d","ddh","nn","thho","th","the","thhe","nnn","pa",
                          "pha","ba","bha","ma","ya","ra","la","sa","sshh","ha","rhha","drha","yaa","ktt","onn","bss","chn"
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
                          "ময়লা","মুছনী","মুখ","না","নাক","নানা","নানী","নাস্তা","নীল","নীরব","অন্ধকার","অপেক্ষা করা",
                          "পা","পাখা","পান","পানি","পিঠ","পছন্দ","পছন্দ না","পরিষ্কার","প্রধান শিক্ষিকা","প্রদীপ",
                          "প্রয়োজন","প্রয়োজন না","পুরুষ","রাত","রাবার","রূপালী","সঙ্গীত","স্কুল","স্কুলে","স্কুলের পোশাক",
                          "সাদা","শান্ত"," শার্পনার","শার্ট","সে","শিক্ষিকা","সমস্যা","সবুজ","সকাল","সোনালী",
                          "সান্ধ্যভোজন","সন্ধ্যা"," ট্যাবলেট","তাদের","তার","তারা","ট্রাউজার্স","তোমার","উচ্চস্বর","ভাল",
                          "ভাঙা","ভূগোল",
                        }


return gameData

--{ text="", audio="", image="non", ind=8 },