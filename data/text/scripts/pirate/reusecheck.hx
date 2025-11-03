var e = args[0];
var actualdice = args[1];
var dicevalues = [];
var d = 0;
if(e.dicehistory.length > 0){
    actualdice = e.dicehistory;
}
for(dice in actualdice){
    if(dice != null){
        d += dice.get_value();
        dicevalues.push(dice.get_value());
    }
}
var type;
if(args.length > 2) type = args[2];
else type = "standard";
var self = e.equippedby;

runscript("pirate/defaultreuseset", [self, e]);

/* Checks whether to give dice for Bottomless Barrel*/
function botbarrelcheck(actualdice){
    var has1 = false;
    var has2 = false;
    for(dice in actualdice){
        if(dice != null){
            if(dice.get_value() == 1) has1 = true;
            if(dice.get_value() == 2) has2 = true;
        }
    }
    for(eq in self.equipment){
        if(eq.name == "Bottomless Barrel"){
            if(!has1 && !eq.upgraded) eq.doequipmentaction(self, target, 1, [], 0, true, false, false);
            if(!has2 && eq.upgraded) eq.doequipmentaction(self, target, 1, [], 0, true, false, false);
        }
    }
}

function inflictreuse(actualdice){
    inflictself("reequippolly");
    botbarrelcheck(actualdice);
}

function inflictretrigger(actualdice){
    inflictself("retriggerpolly");
    botbarrelcheck(actualdice);
}

/*Under certain circumstances, the script can bypass the check entirely and simply guarantee a re-use/trigger.*/
var reuseguaranteed = false;
var retriggerguaranteed = false;

/*Equipment with a re-use/trigger value of 100 are ones that re-use/trigger on *any* value, such as Scabbarded Stabber.*/
if(e.getvar("redice").indexOf(100) != -1) reuseguaranteed = true;
if(e.getvar("retdice").indexOf(100) != -1) retriggerguaranteed = true;

/*Equipment with a re-use/trigger value of 200 can re-use/re-trigger on any *even* value, such as Which Way Captain.*/
if(e.getvar("redice").indexOf(200) != -1 && d % 2 == 0) reuseguaranteed = true; 
if(e.getvar("retdice").indexOf(200) != -1 && d % 2 == 0) retriggerguaranteed = true; 

/*Equipment with a re-use/trigger value of 300 can re-use/re-trigger on any *odd* value, such as Which Way Captain's retrigger values.*/
if(e.getvar("redice").indexOf(300) != -1 && d % 2 != 0) reuseguaranteed = true; 
if(e.getvar("retdice").indexOf(300) != -1 && d % 2 != 0) retriggerguaranteed = true; 

/*Specific checks for Landlubber's Hack and Marooned Chad*/
if(self.hasstatus("landlubbershack") && (dicevalues.indexOf(1) != -1 || dicevalues.indexOf(2) != -1 || dicevalues.indexOf(3) != -1)) reuseguaranteed = true;
if(self.hasstatus("maroonall")) retriggerguaranteed = true;
for(i in 1...7){
    if(self.hasstatus("recycleon" + i)){
        if(dicevalues.indexOf(i) != -1) reuseguaranteed = true;
        self.decrementstatus("recycleon" + i, true);
    }
}
self.decrementstatus("landlubbershack", true);
if(retriggerguaranteed){
    inflictretrigger(actualdice); return true;
} else if(reuseguaranteed){
    inflictreuse(actualdice); return true;
} else if(e.getvar("redice") != 0 && e.getvar("retdice") != 0){
    switch type{
    case "standard":
        if(e.getvar("redice").indexOf(d) != -1 && !e.getvar("fury")) {
            inflictreuse(actualdice); return true;
        }

    case "multipleslots":
        var reusechck = false;
        for(dice in actualdice){
            if(e.getvar("redice").indexOf(dice.basevalue + dice.modifier) != -1){
                reusechck = true;
            }
        } if(reusechck && !e.getvar("fury")) {
            inflictreuse(actualdice); return true;
        }

    case "countdown":
        if(!e.getvar("fury")){
            if(e.dicehistory.length > 0){
                if(e.getvar("redice").indexOf(e.dicehistory[e.dicehistory.length - 1].basevalue + e.dicehistory[e.dicehistory.length - 1].modifier) != -1){
                    inflictreuse(actualdice); return true;
                }
            }
        }

    case "keelhaul":
        var reusechck = false;
        for(eq in self.equipment){
            if(eq.slots[0] == "COUNTDOWN" && (eq.remainingcountdown - eq.reducecountdownby <= actualdice[1].basevalue + actualdice[1].modifier)){
                reusechck = true;
            }
        } for(dice in actualdice){
            if(e.getvar("redice").indexOf(dice.get_value()) != -1){
                reusechck = true;
            }
        } if(reusechck && !e.getvar("fury")) {
            inflictretrigger(actualdice); return true;
        }

    case "manowar":
        var reusechck = false;
        if(actualdice[0].basevalue + actualdice[0].modifier== actualdice[1].basevalue + actualdice[1].modifier){
            reusechck = true;
        } for(dice in actualdice){
            if(e.getvar("redice").indexOf(dice.basevalue + dice.modifier) != -1){
                reusechck = true;
            }
        } if(reusechck && !e.getvar("fury")) {
            inflictreuse(actualdice); return true;
        }

    case "whichwaycaptain":
        if(!e.getvar("fury")) {
            if(e.getvar("retdice").indexOf(d) != -1){
                inflictretrigger(actualdice); return true;
            } else{
                if(e.getvar("redice").indexOf(d) != -1){
                    inflictreuse(actualdice); return true;
                }
            }
        }
    
    case "reinyarrrnation":
        var ru = true;
        for(i in 0...e.slots.length){
            if((e.slots[i] + 'a').indexOf('FREE') == -1){
                if(actualdice[i].basevalue + actualdice[i].modifier != e.getvar('redice')[i]) ru = false; 
            }
        } 
        if(ru && !e.getvar('fury')) {inflictreuse(actualdice); return true;}

    case "reinyarrrnationcountdown":
        if(e.getvar('redice').indexOf(e.dicehistory[e.dicehistory.length - 1].basevalue) != -1 && !e.getvar('fury')){
            inflictreuse(actualdice); return true;
        }

    case "raftup":
        if((e.getvar("redice").indexOf(d) != -1 || d < 7) && !e.getvar("fury")) {
            inflictreuse(actualdice); return true;
        }
    
    case "reinforcedleg":
        if(!e.getvar("fury")){
            if(e.getvar("redice").indexOf(e.dicehistory[e.dicehistory.length - 1].basevalue + e.dicehistory[e.dicehistory.length - 1].modifier) != -1){
                inflictreuse(actualdice); return true;
            }
        }

    default:
        if(e.getvar("redice").indexOf(d) != -1 && !e.getvar("fury")) {
            inflictreuse(actualdice); return true;
        }
    }
}
return false;