var self = args[0];
var e = args[1];
var upgraded = args[2];
var eqlist = upgraded ? self.getvar("randomequipfilter@u") : self.getvar("randomequipfilter");
var modifier = upgraded ? "+" : "";
giveequipment(rand(eqlist) + modifier, e);
var eq = self.equipment[self.equipment.length - 2];
var finalvals = [];
for (i in eq.slots)
{
    var text = "";
    text += i;
    if (text.indexOf("FREE") == -1) finalvals.push(runscript("pirate/getpossibledice", [i]));
}
if (eq.slots[0] == "COUNTDOWN")
{
    eq.scriptbeforeexecute += "if(e.getvar('redice').indexOf(e.dicehistory[e.dicehistory.length - 1].basevalue) != -1 && !e.getvar('fury')){inflictself('reequippolly'); }";
}
else
{
    eq.scriptbeforeexecute += " var ru = true; for(i in 0...e.slots.length){ if(actualdice[i].basevalue + actualdice[i].modifier != e.getvar('redice')[i]) ru = false; } if(ru && !e.getvar('fury')) {inflictself('reequippolly');}";
}
if (eq.needsdoubles) finalvals[1] = finalvals[0];
if (eq.needstotal > 0)
{
    if (finalvals[0] >= eq.needstotal)
    {
        finalvals[0] = eq.needstotal - 1;
        finalvals[1] = 1;
    }
    else
    {
        finalvals[1] = eq.needstotal - finalvals[0];
    }
}
eq.scriptiffury += "e.setvar('fury', true)";
eq.setvar("redice", finalvals);
eq.setvar("ogredice", finalvals);
eq.setvar("fury", false);
var nameadd = "[recycle]" + finalvals[0];
for (i in 1...finalvals.length)
{
    nameadd += "," + finalvals[i];
}
eq.displayname = nameadd + " " + eq.displayname;
sfx("_thinghappens");
