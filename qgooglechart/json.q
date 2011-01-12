\d .json
atom:{
 $[null x;
 "null";
 -1h = type x;
 $[x;"true";"false"]; / JSON has specific keywords for true and false
 -14h = type x;
 "new Date (",(string `year$x),",",(string -1+`mm$x),",",(string `dd$x),")";
 (type x) in neg 5 6 7 8 9h;
 string x;
 "\"",(string x),"\""]
 }

list:{
 r: $[1h = type x;
 string ?[x;`true;`false];
 (type x) in 5 6 7 8 9h;
 string x;
 "\"",'(string x),'"\""];
 "[ ",(", " sv @[r;nullx;:;(count nullx:where null x)#enlist "null"]),"]" / We want to replace occurences of null atoms with the JSON keyword  "null"
 }

genList:{"[ ", (", " sv $[genListCharTest x;jsonT[;0b];jsonT[;1b]] each x), " ]"}
genListCharTest:{(not all 10h = type each x) and all 0h < type each x} /if the list is a list of simple lists and not all the lists are string lists

forceString:{"\"",' (string x),' "\""} / Keys *have* to be strings in JSON
dict:{[x;charListAsAtom]"{ ", (", " sv ": " sv/: flip (forceString key x;jsonT[;charListAsAtom] each value x)), " }"}

/ Tables will be treated as unflipped dictionaries of lists 
/table:{dict[flip x;0b]}
table:{raze "[ ",("," sv dict[;1b]each x)," ]"};
kTable:{"{ \"key\": ", table[key x], ", \"value\":", table[value x], "}"}

jsonT:{[x;charListAsAtom]; / Sometimes character lists should be strings, and sometimes they should be character lists
 $[ 0 > type x;
 atom[x];
 charListAsAtom and 10h = type x;
 "\"",x,"\"";
 (type x) within 1 11h;
 list[x];
 99h = type x;
 $[98h = type key x;kTable[x];dict[x;1b]];
 98h = type x;
 table[x];
 (type x) in 0 14h;
 genList[x];
 "\"Unhandled type: ", (string type x), "\""]
 }

json:{
 $[ (type x) in 98 99h;
 jsonT[x;1b];
 (type x) < 20h;
 "{ ", $[(10h = type x) or 0h > type x; "\"atom\"";(type x) within 019h; "\"list\""; "\"error\""], ": ", jsonT[x;1b], " }";
 "{ \"error\": ", jsonT[x;1b], " }"]
 }
\d .

.h.ty[`jsn]:"application/json"
.h.tx[`jsn]:{enlist .json.json x}