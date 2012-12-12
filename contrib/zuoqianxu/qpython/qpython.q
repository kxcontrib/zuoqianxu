`pyinit`pyfree`pydo`pyeval`pycall`pyset {x set `qpython 2:(x;y);}' 1 1 1 2 3 3; 
pymeval:pyeval[`];pymset:pyset[`];pymcall:pycall[`];pybcall:pycall[`$"__builtin__"];
pyinit[];

\
pyfree[];
pydo "from time import time,ctime\nprint 'Today is',ctime(time())\n";
pymset[`a;`abc];
pymeval "a";
pybcall[`sum;enlist 1 2 3.5];
pybcall[`pow;3 4];
pycall[`math;`cos;0]