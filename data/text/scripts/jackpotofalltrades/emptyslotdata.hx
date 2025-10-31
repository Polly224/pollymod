var backCastList = ["PC Fans", "Basil's Protection", "Cthulhu's Shield", "Ctrl + C", "Dead Ringer", "Double Roll", "Dragon's Roll", "Duplicate", "Fifths Roll", "Final Countdown", "Firey Roll", "Guarded Fling", "Icy Roll", "Jimbo's Trick", "Ka... Ching!", "Lifeblood", "Limit Break", "Lucky Roll", "Midnight Snake", "Nanomachines", "Perfect Spanner", "Persona", "Prickly Pear", "Reshuffle", "Ripper Mode", "Run It Back", "Salvaging", "Sandvich", "Slippery Shoes", "Stars And Time", "Stored Prize", "Suit Up", "The 50/50", "The 75/25", "Timebomb"];

var eqname = args[0];

var results = [1, "PURPLE"];
var colors = ["GRAY", "BLUE", "RED", "GREEN", "YELLOW", "PURPLE", "ORANGE", "BLACK", "PINK"];
for(c in colors){
    if(getcolumn(loaddata("jackpotofalltrades/skillcolors"), c).indexOf(eqname) != -1){
        results[1] = c;
        break;
    }
}
if(backCastList.indexOf(eqname) != -1) results[0] = -1;

return results;