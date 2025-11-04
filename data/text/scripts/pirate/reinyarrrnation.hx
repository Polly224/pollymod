var self = args[0];
var e = args[1];
var upgraded = args[2];
var eqlist = upgraded ? self.getvar("randomequipfilter@u") : self.getvar("randomequipfilter");
var modifier = upgraded ? "+" : "";
var pickedname = rand(eqlist);

var eq = new elements.Equipment(pickedname + modifier);
_internalexchangeequipment(self, e, eq, -1);
delay(0.5);
eq.scriptendturn = "e.animate('fastdestroy'); giveequipment('" + e.name + modifier + "', true, false, e);animateequipmentintoplace(self);}}";
var temptest = new elements.Equipment(pickedname + modifier);
eq.finalpos = e.finalpos;
if(!self.isplayer) eq.castdirection *= -1;

var finalvals = [];
for (i in eq.slots)
{
    var text = "";
    text += i;
    if (text.indexOf("FREE") == -1) finalvals.push(runscript("pirate/getpossibledice", [i]));
}
if (eq.slots[0] == "COUNTDOWN")
{
    eq.scriptbeforeexecute += "runscript('pirate/reusecheck', [e, actualdice, 'reinyarrrnationcountdown']);";
}
else
{
    eq.scriptbeforeexecute += "runscript('pirate/reusecheck', [e, actualdice, 'reinyarrrnation']);";
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
