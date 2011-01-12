mlopen:`:qmatlab 2:(`eng_Open;1);mlclose:`:qmatlab 2:(`eng_Close;1); mleval:`:qmatlab 2:(`eng_Eval;1);mlget:`:qmatlab 2:(`eng_Get;1);mlput1:`:qmatlab 2:(`eng_Put;2); 
addlib:{mleval["addpath(genpath('",x,"'))"];};mx:{"f"$$[0=t:type x;x;t<0;enlist enlist x;enlist each x]};mlput:{[x;y]mlput1[x;mx y]};

mlopen[];
