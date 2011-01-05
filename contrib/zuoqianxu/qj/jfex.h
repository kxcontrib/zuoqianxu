// J Front End Example
// define minimal subset of JE for JFE use of JE

#ifdef J64
 typedef long long JI;
#else
 typedef long JI;
#endif

typedef char JC;
typedef void* JJ;

typedef struct {JI k,flag,m,t,c,n,r,s[1];}* A; // J array struct used in Jwd

// A field access
#define AK(x)           ((x)->k)        // offset of ravel wrt x
#define AT(x)           ((x)->t)        // Type; one of the #define below
#define AN(x)           ((x)->n)        // # elements in ravel
#define AR(x)           ((x)->r)        // Rank
#define AS(x)           ((x)->s)        // Pointer to shape

// A data access
#define AV(x)           ( (JI*)((JC*)(x)+AK(x)))  // pointer to ravel
#define BAV(x)          (      (JC*)(x)+AK(x) )  // boolean
#define CAV(x)          (      (JC*)(x)+AK(x) )  // character
#define USAV(x)         ((US*)((JC*)(x)+AK(x)))  // wchar
#define UAV(x)          (     (UC*)(x)+AK(x) )  // unsigned character
#define IAV(x)          AV(x)                   // integer
#define DAV(x)          ( (D*)((JC*)(x)+AK(x)))  // double
#define ZAV(x)          ( (Z*)((JC*)(x)+AK(x)))  // complex

// A types - AT(x) and jga
#define B01             (JI)1L           // B  boolean
#define LIT             (JI)2L           // C  literal (character)
#define INT             (JI)4L           // I  integer
#define FL              (JI)8L           // D  double (IEEE floating point)
#define CMPX            (JI)16L          // Z  complex
#define UNICODE         (JI)131072L      // U  unicode

#define EVDOMAIN 3
