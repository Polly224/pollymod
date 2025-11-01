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
    return true;
}

function inflictretrigger(actualdice){
    inflictself("retriggerpolly");
    botbarrelcheck(actualdice);
    return true;
}
var reuseguaranteed = false;

if(self.hasstatus("landlubbershack") && (dicevalues.indexOf(1) != -1 || dicevalues.indexOf(2) != -1 || dicevalues.indexOf(3) != -1)) reuseguaranteed = true;
if(reuseguaranteed){
    inflictreuse(actualdice);
} else{
    switch type{
    case "standard":
        if(e.getvar("redice").indexOf(d) != -1 && !e.getvar("fury")) {
            inflictreuse(actualdice);
        }

    case "multipleslots":
        var reusechck = false;
        for(dice in actualdice){
            if(e.getvar("redice").indexOf(dice.basevalue + dice.modifier) != -1){
                reusechck = true;
            }
        } if(reusechck && !e.getvar("fury")) {
            inflictreuse(actualdice);
        }

    case "countdown":
        if(!e.getvar("fury")){
            if(e.dicehistory.length > 0){
                if(e.getvar("redice").indexOf(e.dicehistory[e.dicehistory.length - 1].basevalue + e.dicehistory[e.dicehistory.length - 1].modifier) != -1){
                    inflictreuse(actualdice);
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
            inflictretrigger(actualdice);
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
            inflictreuse(actualdice);
        }

    case "whichwaycaptain":
        if(!e.getvar("fury")) {
            if(e.getvar("retdice").indexOf(d) != -1){
                inflictretrigger(actualdice);
            } else{
                if(e.getvar("redice").indexOf(d) != -1){
                    inflictreuse(actualdice);
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
        if(ru && !e.getvar('fury')) {inflictreuse(actualdice);}

    case "reinyarrrnationcountdown":
        if(e.getvar('redice').indexOf(e.dicehistory[e.dicehistory.length - 1].basevalue) != -1 && !e.getvar('fury')){
            inflictreuse(actualdice);
        }

    case "raftup":
        if((e.getvar("redice").indexOf(d) != -1 || d < 7) && !e.getvar("fury")) {
            inflictreuse(actualdice);
        }
    
    case "reinforcedleg":
        if(!e.getvar("fury")){
            if(e.getvar("redice").indexOf(e.dicehistory[e.dicehistory.length - 1].basevalue + e.dicehistory[e.dicehistory.length - 1].modifier) != -1){
                inflictreuse(actualdice);
            }
        }

    default:
        if(e.getvar("redice").indexOf(d) != -1 && !e.getvar("fury")) {
            inflictreuse(actualdice);
        }
    }
}
return false;