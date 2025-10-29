var self = args[0];
var e = args[1];
var upgraded = args[2];
var eqlist = upgraded ? (self.spaceleft() > 1 ? self.getvar("bigrandomequipfilter@u") : self.getvar("randomequipfilter@u")) : (self.spaceleft() > 1 ? self.getvar("bigrandomequipfilter") : self.getvar("randomequipfilter"));
var modifier = upgraded ? "+" : "";
var pickedname = rand(eqlist);

var eq = new elements.Equipment(pickedname + modifier);
_internalexchangeequipment(self, e, eq, -1);
delay(0.5);
eq.scriptendturn = "e.animate('fastdestroy'); giveequipment('" + e.name + modifier + "', true, false, e); for(eq in self.equipment){if(eq.name == 'Reinyarrrnation'){eq.x = -50000; eq.finalpos.x = -50000; animateequipmentintoplace(self);}}";
var temptest = new elements.Equipment(pickedname + modifier);
if(temptest.size == 2)
{
    eq.resize(2);
    eq.finalpos.y = 630;
    animateequipmentintoplace(self);
}

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
    eq.scriptbeforeexecute += " var ru = true; for(i in 0...e.slots.length){ if((e.slots[i] + '1').indexOf('FREE' == -1)) if(actualdice[i].basevalue + actualdice[i].modifier != e.getvar('redice')[i]) ru = false; } if(ru && !e.getvar('fury')) {inflictself('reequippolly');}";
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
