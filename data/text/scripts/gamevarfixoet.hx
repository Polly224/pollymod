/*Run in the fighter's On End Turn script, *after* setting any gamevars on equipment.*/

/*Stores the gamevars of the weakened equipment, so it can later re-assign them to said equipment on the next run of gamevarfixbst.*/

var self = args[0];
var storage = self.getvar("eqvarstorage");
var unweakenstorage = [];
if(storage.length > 0){
    for(i in storage){
        if(i[0].weakened){
            unweakenstorage.push([i[0], i[1]]);
        }
    } 
}
self.setvar("unweakenvars", unweakenstorage);