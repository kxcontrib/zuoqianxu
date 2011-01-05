/* Copyright 1990-2007, Jsoftware Inc.  All rights reserved.               */
/* Licensed use only. Any other use is in violation of copyright.          */

JJ _stdcall JInit();                         /* init instance */
void _stdcall JSM(JJ jt, void*callbacks[]);  /* set callbacks */ 
int _stdcall JDo(JJ jt,JC*);                  /* run sentence */
JC* _stdcall JGetLocale(JJ jt);               /* get locale */			
int _stdcall JFree(JJ jt);                   /* free instance */
A _stdcall JGetA(JJ jt,JI n,JC* name);         /* get 3!:1 from name */
JI _stdcall JSetA(JJ jt,JI n,JC* name,JI x,JC* d);/* name=:3!:2 data */

int _stdcall JSetM(JJ jt,JC* name,JI* t,JI* r,JI** s,JJ d);/* I h,S n,I*t,I*r,I**s,P d */
int _stdcall JGetM(JJ jt,JC* name,JI* t,JI* r,JI** s,JJ d);/* I h,S n,I*t,I*r,I**s,P d */

typedef void* (_stdcall *JInitType)     ();
typedef int   (_stdcall *JDoType)       (void*,JC*);
typedef JC*    (_stdcall *JGetLocaleType)(void*);    
typedef void  (_stdcall *JSMType)       (void*, void*);
typedef void  (_stdcall *JFreeType)     (void*);
typedef A     (_stdcall *JgaType)       (JJ jt, JI t, JI n, JI r, JI*s);

typedef int     (_stdcall *JSetMType)       (JJ,JC*,JI*,JI*,JI**,JJ);
typedef int     (_stdcall *JGetMType)       (JJ,JC*,JI*,JI*,JI**,JJ);

typedef A      (_stdcall *JGetAType)       (JJ,JI,JC*);
typedef JI     (_stdcall *JSetAType)       (JJ,JI,JC*,JI,JC*);

/*  void* callbacks[] = {Joutput, Jwd, Jinput, unused, smoptions}; */

typedef void  (_stdcall * outputtype)(JJ,int,JC*);
typedef int   (_stdcall * dowdtype)  (JJ,int, A, A*);
typedef JC* (_stdcall * inputtype) (JJ,JC*);

void _stdcall Joutput(JJ jt, int type, JC* s);
int _stdcall Jwd(JJ jt, int x, A parg, A* pres);
JC* _stdcall Jinput(JJ jt, JC*);

// output type
#define MTYOFM		1	/* formatted result array output */
#define MTYOER		2	/* error output */
#define MTYOLOG		3	/* output log */
#define MTYOSYS		4	/* system assertion failure */
#define MTYOEXIT	5	/* exit */
#define MTYOFILE	6	/* output 1!:2[2 */

// smoptions
#define SMWIN    0  /* j.exe    Jwdw (Windows) front end */
#define SMJAVA   2  /* j.jar    Jwdp (Java) front end */
#define SMCON    3  /* jconsole */

