usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];
var attackstuff = ["Pocket Hook", "Which Way, Captain?", "Keelhaul", "Pillage", "Walk The Plank", "Man O War"];
var dicemanipstuff = ["Hooked Roll", "Rolling Barrel", "Rocking Waves", "Pick Leg", "Capsize", "Raft Up", "Lucky Pull"];
var passivestuff = ["Reinyarrrnation", "Daily Doubloons", "Landlubber's Hack", "Clap of Thunder", "Buried Treasure"];
var strongstuff = ["Strengthen The Hull", "Treasure Trove", "Safety Net", "Reel It In", "Bottomless Barrel"];
shuffle(dicemanipstuff);
shuffle(attackstuff);
shuffle(passivestuff);
shuffle(strongstuff);
var fickleadded = false;

//Floor 1:
items = [];
gooditems = [dicemanipstuff.pop()];
otherstuff = [];
goodotherstuff = [];
if((dicemanipstuff.indexOf("Lucky Pull") == -1 || passivestuff.indexOf("Landlubber's Hack") == -1) && !fickleadded)
{
    attackstuff.push("Fickle Chain");
    shuffle(attackstuff);
    fickleadded = true;
}
addfloor("tiny")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:
items = [];

gooditems = [attackstuff.pop()];
otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle([attackstuff.pop(), "health", passivestuff.pop()]))
];
if ((dicemanipstuff.indexOf("Lucky Pull") == -1 || passivestuff.indexOf("Landlubber's Hack") == -1) && !fickleadded)
{
    attackstuff.push("Fickle Chain");
    shuffle(attackstuff);
    fickleadded = true;
}
addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 3:
items = [dicemanipstuff.pop()];
gooditems = [];
attackstuff.push("Muzzleloading");
shuffle(attackstuff);

otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop([attackstuff.pop(), passivestuff.pop(), "health"]), 
  upgrade()
];
if ((dicemanipstuff.indexOf("Lucky Pull") == -1 || passivestuff.indexOf("Landlubber's Hack") == -1) && !fickleadded)
{
    attackstuff.push("Fickle Chain");
    shuffle(attackstuff);
    fickleadded = true;
}
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
if ((dicemanipstuff.indexOf("Lucky Pull") == -1 || passivestuff.indexOf("Landlubber's Hack") == -1) && !fickleadded)
{
    attackstuff.push("Fickle Chain");
    shuffle(attackstuff);
    fickleadded = true;
}
addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 5:
if (!fickleadded)
{
    attackstuff.push("Fickle Chain");
    shuffle(attackstuff);
    fickleadded = true;
}
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