var self = args[0];
var excludequip;
if (args.length > 0) excludequip = args[1];
else excludequip = 0;
var reusevals = [];
for (eq in self.equipment)
{
    if (eq.ready && eq.shockedsetting <= 0 && eq != excludequip)
    {
        if (eq.varexists("redice"))
        {
            if (eq.getvar("redice").length > 0 && eq.getvar("redice").length < 6)
            {
                var tempredice = eq.getvar("redice");
                for(i in tempredice){
                    if(i > 0 && i < 7) reusevals.push(i);
                }
            }
        }
        if (eq.varexists("retdice"))
        {
            if (eq.getvar("retdice").length > 0 && eq.getvar("retdice").length < 6)
            {
                var tempretdice = eq.getvar("retdice");
                for(i in tempretdice){
                    if(i > 0 && i < 7) reusevals.push(i);
                }
            }
        }
    }
}
if (reusevals.length == 0) reusevals = [1, 2, 3, 4, 5, 6];
return reusevals;
