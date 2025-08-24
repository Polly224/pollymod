usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];
var attackstuff = ["Pocket Hook", "Which Way, Captain?", "Keelhaul", "Pillage", "Walk The Plank", "Man O War"];
var dicemanipstuff = ["Hooked Roll", "Rolling Barrel", "Rocking Waves", "Pick Leg", "Capsize", "Raft Up"];
var passivestuff = ["Reinyarrrnation", "Daily Doubloons", "Landlubber's Hack", "Buried Treasure"];
var strongstuff = ["Strengthen The Hull", "Treasure Trove", "Safety Net"];
shuffle(dicemanipstuff);
shuffle(attackstuff);
shuffle(passivestuff);
shuffle(strongstuff);

//Floor 1:
items = [];
gooditems = [dicemanipstuff.pop()];
otherstuff = [];
goodotherstuff = [];

addfloor("tiny")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:
items = [];

gooditems = ["Charge 'N Load"];
otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle([attackstuff.pop(), "health", passivestuff.pop()]))
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 3:
items = [dicemanipstuff.pop()];
gooditems = [];

otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop([attackstuff.pop(), passivestuff.pop(), "health"]), 
  upgrade()
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 4:
items = [];
gooditems = [pick([attackstuff.pop(), dicemanipstuff.pop()])];

otherstuff = [health(), health()];
goodotherstuff = [
  trade(["Charge 'N Load", "Pirate Hook", "Rocking Waves", "Rolling Barrel", "Pick Leg", "any"],[strongstuff.pop()]),
  shop([dicemanipstuff.pop(), "upgrade", passivestuff.pop()])
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 5:
items = [];
gooditems = [attackstuff.pop()];

otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle(["health", "upgrade", strongstuff.pop()])), 
  upgrade()
];

addfloor("big")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 6:
items = [];
gooditems = [];
otherstuff = [];
goodotherstuff = [];

var lastfloor = addfloor("boss");

if (getfinalboss() == "Drake"){
  items.push("Wooden Stake");
}

lastfloor
  .additems(items, gooditems)
  .setlocation('BOSS')
  .setmusic(pick(["music_boss_audrey", "music_boss_aoife", "music_boss_beatrice"]))
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();