var list = args[0];
var upgraded = args[1];
var finallist = [];
function checkequipmentvalidity(eq, upgraded)
{
    var tempeq = new elements.Equipment(eq, upgraded);

    /* Created equipment shouldn't give new equipment, that probably breaks stuff. */
    if (tempeq.script.indexOf("giveequipment") != -1) return false;

    /* Created equipment shouldn't give dice, that's the easiest way to get an infinite, like, ever. */
    if (tempeq.script.indexOf("givedice") != -1) return false;

    /* Created equipment shouldn't be too difficult to use in 1 turn. */
    if (tempeq.slots.length == 0 || tempeq.slots.length > 2) return false;
    if (tempeq.maxcountdown > 10) return false;

    return true;
}
for (eq in list)
{
    if (checkequipmentvalidity(eq, upgraded)) finallist.push(eq);
}

return finallist;