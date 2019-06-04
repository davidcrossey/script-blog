d:first each .Q.def[enlist[`name]!enlist enlist "Joe"] .Q.opt .z.x;

\d .log
out:{-1 (string[.z.p]," ### INFO ### ",x)};
err:{-2 (string[.z.p]," ### ERROR ### ",x)};
sucexit:{out "Exiting";exit 0};
\d .

sayhello:{.log.out["Hello ", x]};

main:{
  sayhello d[`name];
  .log.sucexit[];
 };

@[main;`;`$"Error running main"];
