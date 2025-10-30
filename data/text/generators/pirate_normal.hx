usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];
var attackstuff = ["Pocket Hook", "Keelhaul", "Pillage", "Charge 'N Load", "Scrape"];
var defensestuff = ["Patch Up", "Which Way Captain?", "Reinforced Leg"];
var dicemanipstuff = ["Rolling Barrel", "Rocking Waves", "Capsize", "Raft Up"];
var passivestuff = ["Reinyarrrnation", "Daily Doubloons", "Landlubber's Hack", "Clap of Thunder", "Spray And Pray"];
var strongstuff = ["Strengthen The Hull", "Treasure Trove", "Safety Net", "Reel It In", "Bottomless Barrel", "Scabbarded Stabber", "Hack And Slash"];
shuffle(dicemanipstuff);
shuffle(attackstuff);
shuffle(defensestuff);
shuffle(passivestuff);
shuffle(strongstuff);
var allstuff = attackstuff.concat(defensestuff).concat(dicemanipstuff).concat(passivestuff).concat(strongstuff);

//Floor 1:
items = [];
gooditems = [attackstuff.pop()];
otherstuff = [];
goodotherstuff = [];
addfloor("tiny")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:
items = [];
dicemanipstuff = dicemanipstuff.concat(["Pick Leg"]);
attackstuff.push("Man O War");
shuffle(dicemanipstuff);
gooditems = [defensestuff.pop()];
otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle([dicemanipstuff.pop(), "health", passivestuff.pop()]))
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 3:
dicemanipstuff.push("Liar's Dice");
attackstuff.push("Walk The Plank");
attackstuff.push("Glowing Cutlass");
attackstuff.push("Buried Treasure");
attackstuff.push("Muzzleloading");
shuffle(dicemanipstuff);
items = [dicemanipstuff.pop()];
gooditems = [];
shuffle(attackstuff);

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
gooditems = [pick([defensestuff.pop(), dicemanipstuff.pop()])];

otherstuff = [health(), health()];
goodotherstuff = [
  trade(allstuff.concat(["Pirate Hook", "Anchor", "Swab The Deck"]),[strongstuff.pop()]),
  shop([dicemanipstuff.pop(), "upgrade", passivestuff.pop()])
];
addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 5:
items = [];
gooditems = [strongstuff.pop()];
otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle([attackstuff.pop(), "upgrade", strongstuff.pop()])), 
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