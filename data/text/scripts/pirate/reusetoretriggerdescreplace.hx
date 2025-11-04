var swappedeq = [];
if(self.varexists("descreuseswappedeq")) swappedeq = self.getvar("descreuseswappedeq");
var swapall = true;
if(args.length > 0) swapall = args[0];

if(swapall){
    for(eq in self.equipment){
        if(swappedeq.indexOf(eq) != -1) swappedeq.remove(eq);
        else swappedeq.push(eq);
        runscript("pirate/retriggerdescreplace", ["recycle", "placeholder", eq]);
        runscript("pirate/retriggerdescreplace", ["re-use", "placeholdy", eq]);
        runscript("pirate/retriggerdescreplace", ["re-trigger", "re-use", eq]);
        runscript("pirate/retriggerdescreplace", ["retrigger", "recycle", eq]);
        runscript("pirate/retriggerdescreplace", ["placeholder", "retrigger", eq]);
        runscript("pirate/retriggerdescreplace", ["placeholdy", "re-trigger", eq]);
    }
    self.setvar("descreuseswappedeq", swappedeq);
} else{
    for(eq in swappedeq){
        runscript("pirate/retriggerdescreplace", ["recycle", "placeholder", eq]);
        runscript("pirate/retriggerdescreplace", ["re-use", "placeholdy", eq]);
        runscript("pirate/retriggerdescreplace", ["re-trigger", "re-use", eq]);
        runscript("pirate/retriggerdescreplace", ["retrigger", "recycle", eq]);
        runscript("pirate/retriggerdescreplace", ["placeholder", "retrigger", eq]);
        runscript("pirate/retriggerdescreplace", ["placeholdy", "re-trigger", eq]);
    }
    self.resetvar("descreuseswappedeq");
}