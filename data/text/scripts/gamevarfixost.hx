/*Run in the fighter's On Turn Start script, before setting any gamevars on equipment.*/

/*Sets gamevars back to the respective weakened equipment, allowing weakened equips to keep their gamevars instead of resetting them.*/

var self = args[0];
var storage = self.getvar("eqvarstorage");
if(storage.length > 0){
    for(i in storage){
        if(i[0].weakened){
            i[0].gamevar = i[1];
        }
    }
}