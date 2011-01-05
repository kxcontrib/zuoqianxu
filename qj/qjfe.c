// J Front End For Kdb+
// define _WIN32 for Windows, __MACH__ for MAC, J64 for 64-bit

#include "k.h" 
#define BUFLEN 8192
#define K3(f) K f(K x,K y,K z)

#if defined(WIN32)||defined(WIN64)
 #define _CRT_SECURE_NO_WARNINGS
 #include <windows.h>
 #include <direct.h>
 #define GETPROCADDRESS(h,p) GetProcAddress(h,p)
 #define JDLLNAME "j.dll"
#else
 #define _stdcall
 #include <dlfcn.h>
 #define GETPROCADDRESS(h,p)	dlsym(h,p)
 #ifdef __MACH__ 
  #define JDLLNAME "libj.dylib"
 #else
  #define JDLLNAME "libj.so"
 #endif
 #define _getcwd getcwd
#endif

#if defined(J64)
   #define KINT KJ 
   #define kint kj 
   #define kINT kJ 
   #define yint (y->j) 

#else
   #define KINT KI 
   #define kint ki 
   #define kINT kI 
   #define yint (y->i) 
#endif

#include <stdio.h>
#include <signal.h>
#include "jfex.h"
#include "jlib.h"

static JDoType jdo;
static JFreeType jfree;
static JGetLocaleType jgetlocale;
static JgaType jga;

static JSetMType jsetm;
static JGetMType jgetm;

static JSetAType jseta;
static JGetAType jgeta;

static JJ je=NULL;
static void* hjdll;

static char **adadbreak;
static void sigint(int k){**adadbreak+=1;signal(SIGINT,sigint);}
static char input[1000];

// J calls for input (debug suspension and 1!:1[1) and we call for input
char* _stdcall Jinput(JJ je,char* prompt)
{
	fputs(prompt,stdout);
	if(!fgets(input, sizeof(input), stdin))
	{
		fputs("\n",stdout);
		**adadbreak+=1;
	}
	return input;
}

// J calls for output
void _stdcall Joutput(JJ je,int type, char* s)
{
  if(MTYOEXIT==type) exit((int)(I)s);
  fputs(s,stdout);
  fflush(stdout);
}

// J calls for 11!:x y - demonstrates all features of jwdw and jwdp
// pa is y and result array (if any) is returned in pz
// return  pz
//  0           - MTM i.0 0
// -1      A    - A result
// -2      A    - A is pairs of null terminated strings for event table
//  n           - EVDOMAIN etc
int _stdcall Jwd(JJ je, int x, A pa, A* pz)
{
	A r; char c; I i;
	if(!AN(pa)) return EVDOMAIN;
	if(0==x)
	{
		if(LIT!=AT(pa)) return EVDOMAIN;
		c=*CAV(pa);
		if('0'==c) return 0;
		if('1'==c)
		{
			char res[]="result";
			JI cnt=(I)strlen(res);
			r=jga(je,LIT,cnt,1,&cnt);
			if(0==r) return EVDOMAIN;
			strcpy(CAV(r),res);
			*pz=r;
			return -1; // string
		}
		if('2'==c)
		{
			char res[]="a\0aa\0b\0bbb\0"; // null delimited pairs
			JI cnt=(I)sizeof(res);
			r=jga(je,LIT,cnt,1,&cnt);
			memcpy(CAV(r),res,cnt);
			*pz=r;
			return -2; // event data table
		}
		if('3'==c)
		{
			char* res=jgetlocale(je);
			JI cnt=(I)strlen(res);
			r=jga(je,LIT,cnt,1,&cnt);
			if(0==r) return EVDOMAIN;
			strcpy(CAV(r),res);
			*pz=r;
			return -1; // string from current locale
		}
	}
	if(x==2000)
	{
		if(INT!=AT(pa)) return EVDOMAIN;
		i=*IAV(pa);
		if(0==i) return 0;
		if(1==i)
		{
			I res[]={1,2,3,4,5};
			JI cnt=5;
			r=jga(je,INT,cnt,1,&cnt);
			if(0==r) return EVDOMAIN;
			memcpy(IAV(r),res,cnt*sizeof(I));
			*pz=r;
			return -1; // int vector
		}
	}
	return EVDOMAIN;
}

K1(jeinit){
  void* callbacks[] = {Joutput,Jwd,Jinput,0,(void*)SMCON};
  char binpath[BUFLEN];
  char pathdll[BUFLEN];
  char jcmd[BUFLEN];

  if(NULL!=je){O("je inited!\n");R (K)0;};
	kstrncpy(x,binpath,BUFLEN);
	sprintf(pathdll,"%s/%s",binpath,JDLLNAME);
#if defined(WIN32)||defined(WIN64)
	hjdll=LoadLibraryA(pathdll);
#else
	hjdll=dlopen(pathdll,RTLD_LAZY|RTLD_DEEPBIND); 
#endif
	if(!hjdll)
	{
		fputs("Load library failed: ",stderr);
		fputs(pathdll,stderr);
		fputs("\n",stderr);
		return ki(1); // load library failed
	}
	je=((JInitType)GETPROCADDRESS(hjdll,"JInit"))();
	if(!je) return ki(1); // JE init failed
	jdo=(JDoType)GETPROCADDRESS(hjdll,"JDo");
	jfree=(JFreeType)GETPROCADDRESS(hjdll,"JFree");
	jgetlocale=(JGetLocaleType)GETPROCADDRESS(hjdll,"JGetLocale");
	((JSMType)GETPROCADDRESS(hjdll,"JSM"))(je,callbacks);
	adadbreak=(char**)je; // first address in jt is address of breakdata
	signal(SIGINT,sigint);

	jsetm=(JSetMType)GETPROCADDRESS(hjdll,"JSetM");
	jgetm=(JGetMType)GETPROCADDRESS(hjdll,"JGetM");
	jseta=(JSetAType)GETPROCADDRESS(hjdll,"JSetA");
	jgeta=(JGetAType)GETPROCADDRESS(hjdll,"JGetA");

	sprintf(jcmd,"BINPATH_z_=:'%s'",binpath);
	(!jdo(je,jcmd))||printf("jdo[%s]error!\n",jcmd);
	sprintf(jcmd,"ARGV_z_=:,<'%s'","QJFE");
	!(jdo(je,jcmd))||printf("jdo[%s]error!\n",jcmd);
	sprintf(jcmd,"%s","QJLOC_z_=:18!:3<'QJFE'");
	(!jdo(je,jcmd))||printf("jdo[%s]error!\n",jcmd);

	return (K)0;
}

int kstrncpy(K x,char*buf,int n){
  int i,size=x->n;
  char *ptr=buf;
  if((-KC)==x->t){
    *(ptr++)=x->g;
  }else if(KC==x->t){
    if (size>=n)size=n-1;
    for(i=0;i<size;i++)*(ptr++)=kG(x)[i];
  }else{
    size=0;
  }
  *ptr=0;
  return size;
}

K2 (qa2j){
  char jname[BUFLEN];
  JI jt,jr,*js,itmp;
  void *d=NULL;
  int qt=y->t,qn=y->n;
  kstrncpy(x,jname,BUFLEN);
  //printf("qa2j(%s):qt=%d,qn=%d\n",jname,qt,qn);
  js=(JI*)malloc(sizeof(JI));
  if(qt>0){
    jr=1;
    *js=qn;
  }else{
    jr=0;
    *js=0;
  }
  //printf("qa2j(%s):qt=%d,qn=%d,jr=%d,js=%d\n",jname,qt,qn,jr,*js);
  if(((-KF)==qt)||KF==qt){
    jt=FL;
    d=(qt>0)?(kF(y)):(&(y->f));
  }else if(((-KINT)==qt)||(KINT==qt)){
    jt=INT;
    d=(qt>0)?(kINT(y)):(&yint);
#if defined(J64)
  }else if(((-KI)==qt)||(KI==qt)){
    jt=INT;
    if(qt>0){
      if(qn>0){
	d=malloc(qn*sizeof(JI));
	DO(qn,*(((JI*)d)+i)=(JI)kI(y)[i])
      }else{}
    }else{
      itmp=(JI)y->i;
      d=&itmp;
    }
#endif
  }else if(((-KC)==qt)||KC==qt){
    jt=LIT;
    d=(qt>0)?(kC(y)):(&(y->g));
  }else if(((-KB)==qt)||KB==qt){
    jt=B01;
    d=(qt>0)?(kG(y)):(&(y->g));
  }
  //printf("qa2j(%s):qt=%d,qn=%d,jt=%d,jr=%d,js=%d\n",jname,qt,qn,jt,jr,*js);
  jsetm(je,jname,&jt,&jr,&js,&d);

#if defined(J64)
  if((KI==qt)&&(0<qn))free(d);
#endif

  free((JJ)js);
  return (K)0;
}

K2 (q2j){
  char jname[BUFLEN];
  char jelem[BUFLEN];
  char jcmd[BUFLEN];

  int qt=y->t,qn=y->n,i;
  if(NULL==je){O("je not init!\n");R (K)0;};
  kstrncpy(x,jname,BUFLEN);
  //printf("q2j(%s):t=%d,n=%d\n",jname,qt,qn);
  if(((-KB)==qt)||(KB==qt)||((-KF)==qt)||(KF==qt)||((-KINT)==qt)||(KINT==qt)
#if defined(J64)
     ||((-KI)==qt)||(KI==qt)
#endif
     ||((-KC)==qt)||(KC==qt)){
    qa2j(x,y);
  }else if(0==qt){
    if(0==qn){
      sprintf(jcmd,"%s=:a:",jname);
      (!jdo(je,jcmd))||printf("jdo[%s]error!\n",jcmd);
    }else if(1==qn){
      sprintf(jelem,"e_%s",jname);
      q2j(kp(jelem),kK(y)[0]);
      sprintf(jcmd,"%s=:<%s",jname,jelem);
      //printf("[%s](%s)%s\n",jname,jelem,jcmd);
      (!jdo(je,jcmd))||printf("jdo[%s]error!\n",jcmd);
    }else{
      sprintf(jcmd,"%s=:%d#a:",jname,qn);
      //printf("jdo[%s]\n",jcmd);
      (!jdo(je,jcmd))||printf("jdo[%s]error!\n",jcmd);
      for(i=0;i<qn;i++){
	sprintf(jelem,"e%d_%s",i,jname);
	q2j(kp(jelem),kK(y)[i]);
	sprintf(jcmd,"%s=:(<%s) %d}%s",jname,jelem,i,jname);
	//printf("<%d>[%s](%s)%s\n",i,jname,jelem,jcmd);
	(!jdo(je,jcmd))||printf("jdo[%s]error!\n",jcmd);
      }
    }
  }else{
    printf("[q2j] unsupport Q type=%d!\n",qt);
  }
  return (K)0;
}

K ja2q(JI jt,JI jr,JI* js,void* d){
  int i,n,j,ns,nt;
  K r=0;

  //printf("jt=%d,jr=%d,js0=%d\n",jt,jr,*js);
  if(jr>1){
    r=knk(0);
    n=js[0];
    nt=1;
    if(FL==jt){
      nt=8;
    }else if(INT==jt){
      nt=sizeof(JI);
    }else{}
    ns=1;
    for(j=1;j<jr;j++)ns*=js[j];
    //printf("jt=%d,jr=%d,nt=%d,ns=%d\n",jt,jr,nt,ns);
    for(i=0;i<n;i++)jk(&r,ja2q(jt,jr-1,js+1,((char *)d)+i*nt*ns));
  }else{
    n=*js;
    if(FL==jt){
      if(0==jr)r=kf(*(double*)d);
      else if(1==jr){r=ktn(KF,n);for(i=0;i<n;i++)kF(r)[i]=*(((double*)d)+i);}
      else{}
    }else if(INT==jt){
      if(0==jr)r=kint(*(JI*)d);
      else if(1==jr){r=ktn(KINT,n);for(i=0;i<n;i++)kINT(r)[i]=*(((JI*)d)+i);}
      else{}
    }else if(LIT==jt){
      if(0==jr)r=kc(*(char*)d);
      else if(1==jr){r=ktn(KC,n);for(i=0;i<n;i++)kC(r)[i]=*(((char*)d)+i);}
      else{}
    }else if(B01==jt){
      if(0==jr)r=kb(*(char*)d);
      else if(1==jr){r=ktn(KB,n);for(i=0;i<n;i++)kG(r)[i]=*(((char*)d)+i);}
      else{}
      /*
      }else if(UNICODE==jt){
      if(0==jr){
	r=ktn(KC,2);kC(r)[0]=*(char*)d;kC(r)[1]=*((char*)d+1);
      }else if(1==jr){r=ktn(KC,2*n);DO(2*n,kC(r)[i]=*(((char*)d)+i))}
      else{}
      */
    }else if(CMPX==jt){
      if(0==jr){
	r=ktn(KF,2);kF(r)[0]=*(double*)d;kF(r)[1]=*((double*)d+1);
      }else if(1==jr){
	r=knk(2,ktn(KF,n),ktn(KF,n));
	DO(n,kF(kK(r)[0])[i]=*(((double*)d)+2*i);kF(kK(r)[1])[i]=*(((double*)d)+1+2*i))
      }
      else{}
    }
  }
  R r;
}
  
K1(j2q){
  char jname[BUFLEN];
  char jelem[BUFLEN];
  char jcmd[BUFLEN];

  JI jt=0,jr=0,*js,n,i,rc;
  JJ d; 
  K r=0,r1=0;

  if(NULL==je){O("je not init!\n");R (K)0;};
  kstrncpy(x,jname,BUFLEN);
  rc=jgetm(je,jname,&jt,&jr,&js,&d);
  //printf("j2q(%s):t=%d,r=%d,rc=%d\n",jname,jt,jr,rc);

  if(32==jt){
    if(jr>0){
      r=knk(0);
      n=js[0];
      for(i=0;i<n;i++){
	sprintf(jelem,"e%d_%s",i,jname);
	sprintf(jcmd,"%s=:>%d{%s",jelem,i,jname);
	//printf("<%d>[%s](%s)%s\n",i,jname,jelem,jcmd);
	(!jdo(je,jcmd))||printf("jdo[%s]error!\n",jcmd);
	r1=j2q(kp(jelem));
	if(r1)jk(&r,r1);
      }
    }else{
      r=knk(0);
      sprintf(jelem,"e_%s",jname);
      sprintf(jcmd,"%s=:>%s",jelem,jname);
      (!jdo(je,jcmd))||printf("jdo[%s]error!\n",jcmd);
      r1=j2q(kp(jelem));
      if(r1)jk(&r,r1);
    }
  }else if((B01==jt)||(LIT==jt)||(INT==jt)||(FL==jt)||(CMPX==jt)
	   /*||(UNICODE==jt)*/
	   ){
    R ja2q(jt,jr,js,d);
  }else{
    printf("[j2q] unsupport J type=%d!\n",jt);
  }
  R r;
}

K1(jedo){
  char jcmd0[BUFLEN];
  char jcmd[BUFLEN];
  int rc=0;
  K r=0;
  if(NULL==je){O("je not init!\n");R (K)0;};
  kstrncpy(x,jcmd0,BUFLEN);
  sprintf(jcmd,"R__QJLOC=:%s",jcmd0); //[4!:55 <'R__QJLOC'
  //printf("jdo[%s]\n",jcmd);
  rc=jdo(je,jcmd);
  if(rc>0){
    printf("jdo {%s} fail!\n",jcmd);
    r=ki(rc);
  }else{
    r=j2q(kp("R__QJLOC"));
  }
  R r;
}

K2(jemv){
  char jcmd[BUFLEN];
  char jverb[BUFLEN];

  if(NULL==je){O("je not init!\n");R (K)0;};
  kstrncpy(x,jverb,BUFLEN);
  q2j(kp("Y__QJLOC"),y);
  sprintf(jcmd,"(%s) Y__QJLOC",jverb);
  R jedo(kp(jcmd));
}

K3(jedv){
  char jcmd[BUFLEN];
  char jverb[BUFLEN];

  if(NULL==je){O("je not init!\n");R (K)0;};
  kstrncpy(x,jverb,BUFLEN);
  q2j(kp("X__QJLOC"),y);
  q2j(kp("Y__QJLOC"),z);
  sprintf(jcmd,"X__QJLOC (%s) Y__QJLOC",jverb);
  R jedo(kp(jcmd));
}

K1(jefree){
  if(NULL==je){O("je not init!\n");R (K)0;};
  jfree(je);
  return (K)0;
}

