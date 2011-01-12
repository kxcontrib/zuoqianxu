isWIN:.z.o in `w32`w64;
tmpdir:{$[isWIN;"/tmp/";"/tmp/"]};
rn:{[]n:string first 1?`8;tmpdir[],n};

gplot:{[x;y;z](`$":",y,".cmd") 0: $[z;("set terminal png transparent nocrop enhanced font arial 8 size 840,640";"set output '",y,".png'");$[isWIN;();(enlist "set terminal x11")]],("set autoscale";"set grid"),x,enlist enlist "q";system $[isWIN;"start \\bin\\gnuplot ";"gnuplot "],$[z;"";$[isWIN;"-persist ";"-p "]],y,".cmd";$[z;y,".png";()]}; 

pd:{[x;y;e;f]z:rn[];if[not 0=type e;e:enlist e];xt:$[0=type x;$[0=type x 0;type x[0;0];type x 0];type x];
        $[xt in 13 14 17 18 19h;e,:(enlist "set xdata time"),("set timefmt ";"set format x "),\:"'",$[14h=xt;"%Y.%m.%d";13h=xt;"%Y.%m";17h=xt;"%H:%M";18h=xt;"%H:%M:%S"],"'";];
	(`$":",z,".dat") 0: $[0=type x;
			    	     $[0=type x 0;
				     	      ({x,("";""),y}/) {{" " sv x} each string flip x} each x; /3d(datasets):((x;y);(t;o;h;l;c),...)
				     	      {" " sv x} each string flip x]; /2d:(x;y)»ò(t;o;h;l;c)
					      string x]; /1d:y
	gp:$[0=type y 0;
		    {(til count x),'(0^prev sums x),'x} count each y;
		    enlist 0,0,count x]; 
	if[not 0=type y 0;y:enlist y];
	cmd:e,{[x;y;z;w]u:z,".dat";
		x:x[(w 1)+til w 2];
		y:y w 0;
	"plot ", $[(0=type x 0);
	       "," sv (til count x) ({[x;y;z;w;u]x+:w 1;"'",y,"' i ",(string x)," u ",({":" sv string 1+ til x} u)," ",(z x&-1+count z)}[;u;$[0=type y;y;enlist y];w;])' count each x; /3d
	       "'",u,"' u ",({":" sv string 1+ til x} count $[0=type x;x;x[0]])," ",y] /1d|2d
	       }[x;y;z;] each gp;
	gplot[cmd;z;f]}; 
pds:pd[;;;0b];pdf:pd[;;;1b]; 

pb:pds[;"w boxes";"set key off"];pbf:pdf[;"with boxes";"set key off"]; /bar chart,pb 10?1f
pc:pds[;"w p";"set key off"];pcf:pdf[;"with p";"set key off"]; /dot chart,pc 10?1f
pl:pds[;"w lp ps 0.4 pt 6";"set key off"];plf:pd[;"w lp ps 0.4 pt 6";"set key off"];  /line chart,pl 10?1f
pk:pds[;"w candlesticks";"set key off"]; /candle line
pe:pds[;"w errorb";"set key off"]; /error bar
pl2y:{if[0h<>type x[0];x:enlist each x];pds[x;("w lp ps 0.4 pt 6 axes x1y1";"w lp ps 0.4 pt 6 axes x1y2");("set y2tics";"set key bot center outside")]}; /eg:pl2y (til 10;til 20)
plyn:{pl {(til count x;x)} each x;}; /eg:plyn (til 10;2*til 20;3*til 30)
plxyn:('[pl;{(1#x),/:enlist each 1_x}]); /eg:plyn (til 10;2*til 20;3*til 30)
plyn01:{pl {[x]n:count x;((til n)%(n-1);x)} each x;};
pkv:{pds[(-1_x;x[0 5]);(enlist "w candlesticks";enlist "with boxes");("set key off";"set tmargin 0;set bmargin 0;set lmargin 10;set rmargin 3;";"set multiplot layout 2,1")]};

