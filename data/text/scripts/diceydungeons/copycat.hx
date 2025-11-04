//Alternate version of the base game's Copycat script that also copies gamevars.
var _self = args[0];
var _target = args[1];
var upgradeenemyequipment = args[2];
var isfirstturn = args[3];

var isjester = (_target.layout == "DECK");

if(isfirstturn == 0 || isjester){
  _self.destroyallequipment(); 

  var copiedequipment = []; 
  var copiedgamevars = [];
  var eqlist = _target.getcurrentequipment();
  if(eqlist.length > 0){
    for(e in eqlist) { 
      if(upgradeenemyequipment) { 
        var newequipment = e.copy();
        if(isjester && newequipment.size == 1) newequipment.resize(2);
        copiedequipment.push(newequipment);
      } else { 
        var newequipment = e.copy();
        if(isjester && newequipment.size == 1) newequipment.resize(2);
        copiedequipment.push(newequipment);
      } 
      copiedgamevars.push(e.gamevar);
    } 

    for(i in 0...copiedequipment.length){
      _internalgiveequipment(_self, [copiedequipment[i].name + copiedequipment.namemodifier], 1, false, copiedequipment[i]);
      copiedequipment[i].gamevar = copiedgamevars[i];
    }
  }
}