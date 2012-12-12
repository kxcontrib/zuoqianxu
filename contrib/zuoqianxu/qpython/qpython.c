#include "k.h"

#include <Python.h>

#define LONGBUFLEN 262144
#define K3(f) K f(K x,K y,K z)
#define xz xK[2]
#define min(a,b) (((a)>(b))?(b):(a))

int kstrncpy(char*buf,K x,int n){
  int size=min(n-1,xn);
  memcpy(buf,kG(x),size);
  *(buf+size)=0;
  return size;
}


ZI pyinited=0;
Z PyObject *mmain=NULL,*mdict=NULL;

K1(pyinit){ 
  if(!pyinited){pyinited=1;Py_Initialize();mmain=PyImport_AddModule("__main__");mdict=PyModule_GetDict(mmain);} 
  R ki(0);
}

K1(pyfree){
  if(pyinited){Py_Finalize();pyinited=0;}
  R ki(0);
} 

K1(pydo){
  C buf[LONGBUFLEN];
  if(!pyinited) R ki(-1);
  kstrncpy(buf,x,sizeof(buf));
  R ki(PyRun_SimpleString(buf));
}

K pv2q(PyObject *pV){
  K v=NULL,Lk,Lv;
  Py_ssize_t n=-1,i=0;
  PyObject* seq;

  if((NULL==pV)||(Py_None==pV)) R v;

  if(PyBool_Check(pV)){
    v=kb(Py_True==pV);
  }else if(PyInt_Check(pV)){
    v=ki(PyInt_AsLong(pV));
  }else if(PyLong_Check(pV)){
    v=kj(PyInt_AsLong(pV));
  }else if(PyFloat_Check(pV)){
    v=kf(PyFloat_AsDouble(pV));
  }else if(PyString_Check(pV)){
    v=ks(PyString_AsString(pV));
  }else if(PyByteArray_Check(pV)){
    v=kpn(PyByteArray_AsString(pV),PyByteArray_Size(pV));
  }else if(PySequence_Check(pV)){
    n=PySequence_Size(pV);
    v=knk(0);
    seq=PySequence_Fast(pV, "expected a sequence");
    for (i=0;i<n;i++) {
      jk(&v,pv2q(PySequence_Fast_GET_ITEM(seq,i)));
    }
    Py_DECREF(seq);
  }else if(PyMapping_Check(pV)){
    n=PyMapping_Size(pV);
    seq=PyMapping_Keys(pV);
    Lk=pv2q(seq);   
    Py_DECREF(seq);
    seq=PyMapping_Values(pV);
    Lv=pv2q(seq);   
    Py_DECREF(seq);
    v=xD(Lk,Lv);
  }else{}

  R v;
}

PyObject *q2pv(K x);

PyObject * qi2p(K x,I i){
  int qt=xt;
  PyObject *pV=Py_None;

  if(KB==qt){
    pV=xG[i]?Py_True:Py_False;
  }else if((KG==qt)||(KC==qt)){
    pV=PyInt_FromLong((long)xG[i]);
  }else if(KH==qt){
    pV=PyInt_FromLong((long)xH[i]);
  }else if(KI==qt){
    pV=PyInt_FromLong((long)xI[i]);
  }else if(KJ==qt){
    pV=PyLong_FromLong(xJ[i]);
  }else if(KE==qt){
    pV=PyFloat_FromDouble((double)xE[i]);
  }else if(KF==qt){
    pV=PyFloat_FromDouble(xF[i]);
  }else if(KS==qt){
    pV=PyString_FromString(xS[i]);    
  }else if(0==qt){
    pV=q2pv(xK[i]);
  }else{}

  R pV;
}

PyObject *q2pv(K x){
  PyObject *pV=Py_None;
  int qt=xt,qn=xn,i;
  K Lk,Lv;

  if(((-KB)==qt)){
    pV=xg?Py_True:Py_False;
  }else if(((-KG)==qt)||((-KC)==qt)){
    pV=PyInt_FromLong((long)xg);
  }else if((-KH)==qt){
    pV=PyInt_FromLong((long)xh);
  }else if((-KI)==qt){
    pV=PyInt_FromLong((long)xi);
  }else if((-KJ)==qt){
    pV=PyLong_FromLong(xj);
  }else if((-KE)==qt){
    pV=PyFloat_FromDouble((double)xe);
  }else if((-KF)==qt){
    pV=PyFloat_FromDouble(xf);
  }else if((-KS)==qt){
    pV=PyString_FromString(xs);
  }else if((KG==qt)||(KC==qt)){
    pV= PyByteArray_FromStringAndSize(xG,qn);
  }else if(KB==qt){
    pV=PyTuple_New(qn);for(i=0;i<qn;i++)PyTuple_SetItem(pV,i,xG[i]?Py_True:Py_False);
  }else if(KH==qt){
    pV=PyTuple_New(qn);for(i=0;i<qn;i++)PyTuple_SetItem(pV,i,PyInt_FromLong(xH[i]));
  }else if(KI==qt){
    pV=PyTuple_New(qn);for(i=0;i<qn;i++)PyTuple_SetItem(pV,i,PyInt_FromLong(xI[i]));
  }else if(KJ==qt){
    pV=PyTuple_New(qn);for(i=0;i<qn;i++)PyTuple_SetItem(pV,i,PyInt_FromLong(xJ[i]));
  }else if(KE==qt){
    pV=PyTuple_New(qn);for(i=0;i<qn;i++)PyTuple_SetItem(pV,i,PyFloat_FromDouble(xE[i]));
  }else if(KF==qt){
    pV=PyTuple_New(qn);for(i=0;i<qn;i++)PyTuple_SetItem(pV,i,PyFloat_FromDouble(xF[i]));
  }else if(KS==qt){
    pV=PyTuple_New(qn);for(i=0;i<qn;i++)PyTuple_SetItem(pV,i,PyString_FromString(xS[i]));
  }else if(0==qt){
    pV=PyTuple_New(qn);for(i=0;i<qn;i++)PyTuple_SetItem(pV,i,q2pv(xK[i]));
  }else if((99==qt)||(98==qt)){
    pV=PyDict_New();
    Lk=xK[0];Lv=xK[1];
    qn=Lk->n;
    for(i=0;i<qn;i++)PyDict_SetItem(pV,qi2p(Lk,i),qi2p(Lv,i));
  }else{}

  R pV;
}
 
K2(pyeval){
  C buf[LONGBUFLEN];
  PyObject *pValue=NULL,*pName=NULL,*pModule=NULL,*pDict=NULL;
  if(!pyinited) R ki(-1);
  if(0<y->t){
    kstrncpy(buf,y,sizeof(buf));
  }else{
    buf[0]=y->g;buf[1]=0;
  }

  if(0==strlen(xs)){
    pDict=mdict;
  }else{
    pName=PyString_FromString(xs);
    pModule=PyImport_Import(pName);Py_DECREF(pName);if(NULL==pModule) R (K)0;
    pDict=PyModule_GetDict(pModule);
  }
  pValue=PyRun_String(buf,Py_eval_input,pDict,pDict);
  if(NULL!=pModule)Py_DECREF(pModule);
  R pv2q(pValue);
}

K3(pycall){
  PyObject *pValue=NULL,*pName=NULL,*pModule=NULL,*pDict=NULL,*pFunc=NULL,*pArgs=NULL;
  if(!pyinited) R ki(-1);

  if(0==strlen(xs)){
    pDict=mdict;
  }else{
    pName=PyString_FromString(xs);
    pModule=PyImport_Import(pName);Py_DECREF(pName);if(NULL==pModule) R ki(-2);
    pDict=PyModule_GetDict(pModule);
  }

  pFunc=PyDict_GetItemString(pDict,y->s);if(NULL==pFunc) R ki(-3);
  if(PyCallable_Check(pFunc)){
    if(0<=z->t){
      pArgs=q2pv(z);
    }else{
      pArgs=PyTuple_New(1);
      PyTuple_SetItem(pArgs,0,q2pv(z));
    }
    pValue=PyObject_CallObject(pFunc,pArgs);
  }else{PyErr_Print();}
  if(NULL!=pModule)Py_DECREF(pModule);
  if(NULL!=pFunc)Py_DECREF(pFunc);

  R pv2q(pValue);
}

K3(pyset){
  PyObject *pValue=NULL,*pName=NULL,*pModule=NULL,*pDict=NULL;
  int r=0;
  if(!pyinited) R ki(-1);
  if(0==strlen(xs)){
    pDict=mdict;
  }else{
    pName=PyString_FromString(xs);
    pModule=PyImport_Import(pName);Py_DECREF(pName);if(NULL==pModule) R ki(-1);
    pDict=PyModule_GetDict(pModule);
  }
  r=PyDict_SetItemString(pDict,y->s,q2pv(z));
  R ki(r);
}
