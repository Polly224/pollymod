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
                if (eq.getvar("redice")[0] < 7)
                {
                    reusevals = reusevals.concat(eq.getvar("redice"));
                }
            }
        }
        if (eq.varexists("retdice"))
        {
            if (eq.getvar("retdice").length > 0 && eq.getvar("retdice").length < 6)
            {
                if (eq.getvar("retdice")[0] < 7)
                {
                    reusevals = reusevals.concat(eq.getvar("retdice"));
                }
            }
        }
    }
}
if (reusevals.length == 0) reusevals = [1, 2, 3, 4, 5, 6];
return reusevals;
