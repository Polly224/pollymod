var thisgenerator = "robot_normal";
var commonlist_basic = [];
var commonlist_advanced = [];
var floor2basic = [];
var floor2advanced = [];
var floor2items = [];
var floor3basic = [];
var floor3advanced = [];
var tradeoffer = [];
var traderesult = [];
var vampireitem = [];
var itempools = [commonlist_basic,commonlist_advanced,floor2basic,floor2advanced,floor2items,floor3basic,floor3advanced,tradeoffer,traderesult,vampireitem]; //Initialize lists like this for clarity

/*NOTICE TO MODDERS:
  All you need to do to get your items in here is append the name of your mod to:
    diceydungeons/itempools/[this generator's name minus file extension]/scriptstorun.txt
  Then add a .hx script of the appropriate name to that directory that returns an array containing arrays of items
  you want to add to each of the generator's item pools. Use the vanilla script for this generator for reference -
  it's important you return the right amount of arrays!
  
  (If you want to replace the generator entirely, in case you have an extremely specific item pool in mind, you should
  get rid of declaring itempools and add items directly to the above lists (or replace pops from them with strings).
  Note however that other mods will no longer be able to add items here.)*/
  
itempools = runscript("diceydungeons/flexible_generator",[thisgenerator,itempools]);
var commonlist_basic = itempools[0];
var commonlist_advanced = itempools[1];
var floor2basic = itempools[2];
var floor2advanced = itempools[3];
var floor2items = itempools[4];
var floor3basic = itempools[5];
var floor3advanced = itempools[6];
var tradeoffer = itempools[7];
var traderesult = itempools[8];
var vampireitem = itempools[9];

usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];
var fightmusic = ["music_combat6"];
for(i in 1...5){
  fightmusic.push("music_combat" + i);
}
//Floor 1:
items = [];
gooditems = [commonlist_basic.pop()];
otherstuff = [];
goodotherstuff = [];

addfloor("tiny")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
    .setmusic(pick(fightmusic))
  .generate();
  
//Floor 2:
commonlist_basic = commonlist_basic.concat(floor2basic);
shuffle(commonlist_basic);

commonlist_advanced = commonlist_advanced.concat(floor2advanced);
shuffle(commonlist_advanced);

items = [];

gooditems = [pick(floor2items)];
otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle([commonlist_advanced.pop(), commonlist_basic.pop(), commonlist_advanced.pop()]))
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
    .setmusic(pick(fightmusic))
  .generate();
  
//Floor 3:
commonlist_basic = commonlist_basic.concat(floor3basic);
shuffle(commonlist_basic);

commonlist_advanced = commonlist_advanced.concat(floor3advanced);
shuffle(commonlist_advanced);

items = [commonlist_basic.pop()];
gooditems = [];

otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop([commonlist_basic.pop(), commonlist_basic.pop(), commonlist_advanced.pop()]), 
  upgrade()
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
    .setmusic(pick(fightmusic))
  .generate();
  
//Floor 4:
items = [];
gooditems = [pick([commonlist_advanced.pop(), commonlist_advanced.pop()])];

otherstuff = [health(), health()];
goodotherstuff = [
  trade(tradeoffer,traderesult),
  shop([commonlist_basic.pop(), commonlist_basic.pop(), commonlist_advanced.pop()])
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
    .setmusic(pick(fightmusic))
  .generate();
  
//Floor 5:
items = [];
gooditems = [commonlist_basic.pop()];

otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle(["health", commonlist_advanced.pop(), commonlist_advanced.pop()])), 
  upgrade()
];

addfloor("big")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
    .setmusic(pick(fightmusic))
  .generate();
  
//Floor 6:
items = [];
gooditems = [];
otherstuff = [];
goodotherstuff = [];

var lastfloor = addfloor("boss");

if (getfinalboss() == "Drake"){
  items.push(vampireitem.pop());
}
var musicoptions = ["music_boss_audrey", "music_boss_aoife", "music_boss_beatrice"];
var pollymodbosses = loadtext("pollymodbossenemies");
if(pollymodbosses.indexOf(getfinalboss()) != -1){
  musicoptions = ["music_combat@pollymod"];
}
lastfloor
  .additems(items, gooditems)
  .setlocation('BOSS')
  .setmusic(pick(musicoptions))
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();