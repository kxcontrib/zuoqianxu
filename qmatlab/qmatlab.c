#include "engine.h"
#include "kcomm.h"

Z Engine *ep=NULL;

K1(eng_Open){
  C buf[SHORTBUFLEN];

  if(NULL!=ep)R ki(-2);
  kstrncpy(buf,x,sizeof(buf));
  ep=engOpen(buf);
  if(NULL==ep)R ki(-1);
  R ki(0);
}

K1(eng_Close){
  int r=-1;
  if(NULL==ep)R ki(r);
  r=engClose(ep);
  ep=NULL;
  R ki(r);
}

K1(eng_Eval){
  int r=-1;
  C buf[LONGBUFLEN];

  if(NULL==ep)R ki(r);
  kstrncpy(buf,x,sizeof(buf));
  r=engEvalString(ep,buf);
  R ki(r);
}


K1(eng_Get){
  mxArray *pm=NULL;
  K L,Row; 
  size_t M,N;
  int i=0,j=0;
  double *pd=NULL;

  if(NULL==ep)R (K)0;
  pm=engGetVariable(ep,xs);
  if(NULL==pm)R (K)0;
  if(0==mxIsDouble(pm))R (K)0;

  M=mxGetM(pm);
  N=mxGetN(pm);
  pd=mxGetPr(pm);
  if(NULL==pd)R (K)0;
  L=knk(0);
  for(i=0;i<M;i++){
    Row=ktn(KF,N);
    for(j=0;j<N;j++){
      kF(Row)[j]=*pd++;
    }
    jk(&L,Row);
  }
  R L;
}


K2(eng_Put){
  mxArray *pm=NULL;
  int r=-1,M=0,N=0,i=0,j=0;
  double *pd=NULL;
  K Row;

  if(NULL==ep)R ki(r);
  M=y->n;
  Row=kK(y)[0];
  N=Row->n;
  pm=mxCreateDoubleMatrix(M,N,mxREAL);
  pd=mxGetPr(pm);
  for(i=0;i<M;i++){
    Row=kK(y)[i];
    for(j=0;j<N;j++){
      *pd++=kF(Row)[j];
    }
  }

  r=engPutVariable(ep,xs,pm);
  R ki(r);
}
