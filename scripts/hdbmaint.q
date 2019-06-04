d:.Q.opt .z.x;
database: hsym `$ first d[`database];

system "c 2000 2000";

\d .log
print:{(-1)(" " sv string (.z.D;.z.T)),x;};
out:{[x]print[": INFO : ",x]};
err:{[x]print[": ERROR : ",x]};
errexit:{err x;err"Exiting";exit 1};
sucexit:{out "Exiting";exit 0};
\d .

.log.out "Loading database: ",string database;
system "l ",1_string database;

.log.out "Adding val to trades table...";
addcol[database;`trades;`val;0Nf];

.log.out "Setting val as (qty*px) in trade table ...";
calcVal:{(hsym `$(y,"/",string[x],"/trades/val")) set {x[0]*x[1]} get@'(hsym`$/:(y,"/",string[x],"/trades/qty";y,"/",string[x],"/trades/px"))}[;1_string database];
calcVal each date;

.log.out "Changing symbols to uppercase...";
(` sv (database;`sym)) set `$upper string get ` sv (database;`sym); /disclaimer, never run something like this on production!

.log.out "Reloading database: ",string database;
system "l ",1_string database;

.log.out "Maintenance complete";
.log.sucexit;
