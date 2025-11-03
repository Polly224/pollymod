var self = args[0];
var eq = args[1];

/*If the equipment's re-use value doesn't exist, this script checks whether the equipment has default values, and assigns them if so.*/
if(eq.getvar("redice") == 0){
    var newredice = [];
    for(i in 1...7){
        if(eq.hastag("ru" + i)){
            newredice.push(i);
        }
    }
    if(eq.hastag("rueven")) newredice.push(200);
    if(eq.hastag("ruodd")) newredice.push(300);
    if(eq.hastag("ruany")) newredice.push(100);
    eq.setvar("redice", newredice);
}
if(eq.getvar("retdice") == 0){
    var newretdice = [];
    for(i in 1...7){
        if(eq.hastag("rt" + i)){
            newretdice.push(i);
        }
    }
    if(eq.hastag("rteven")) newretdice.push(200);
    if(eq.hastag("rtodd")) newretdice.push(300);
    if(eq.hastag("rtany")) newretdice.push(100);
    eq.setvar("retdice", newretdice);
}