`jeinit`jefree`j2q`q2j`jedo`jemv`jedv {x set `qjfe 2: (x;y)}' 1 1 1 2 1 2 3;

initj:{[x]jeinit[x];jedo "0!:0<'",x,"/profile.ijs'";};
jver:{jedo "9!:14 ''"};


\

/Examples:

initj["/opt/j64-602/bin"];
initj["/opt/j64-701/bin"]; 
initj["C:\\j602\\bin"];

jemv["#:"] 16
 
jedo "load 'plot'";
jemv["plot"] 100?1f;
.q.plot:jedv["plot"];
"type bar" plot 10?1f; 

jedo "load 'math/fftw'";
jemv["fftw"] 10?1f

jedo "load 'tables/tara'";
\wget http://www.iso15022.org/MIC/ISO10383_MIC_v1_78.xls -O /tmp/10383.xls
{flip (`$x[0])!flip 1_x} trim jedo "\":>readexcel '/tmp/10383.xls'"
