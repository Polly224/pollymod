var backCastList = getcolumn(loaddata("jackpotofalltrades/skilldata"), "BACKCAST");
var eqname = args[0];

var results = [1, "PURPLE"];
var colors = ["GRAY", "BLUE", "RED", "GREEN", "YELLOW", "PURPLE", "ORANGE", "BLACK", "PINK"];
for(c in colors){
    if(getcolumn(loaddata("jackpotofalltrades/skilldata"), c).indexOf(eqname) != -1){
        results[1] = c;
        break;
    }
}
if(backCastList.indexOf(eqname) != -1) results[0] = -1;

return results;