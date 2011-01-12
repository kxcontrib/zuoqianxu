\l qffi.q
\d .talib
`Sma`Ema`Wma`Dema`Tema`Trima`Kama`Mama`T3 set' til 9; 
TALIB:`$"/q/l64/libtalib.so";
tainit:.ffi.cf[("i";TALIB,`TA_Initialize)];tainit();
tafree:.ffi.cf[("i";TALIB,`TA_Shutdown)];
tacall:{[fun;no;opt;inp]inp:"f"$inp;if[0<>type inp;inp:enlist inp];ni:count inp[0];b:enlist 0N;n:enlist 0N;out:((abs no),ni)#$[no<0;0N;0n];r:.ffi.cf[("i";TALIB,fun)] (0;ni-1),inp,opt,(b;n),out; $[1=abs no;first;::] ((ni-n[0])#$[no<0;0N;0n]),/:(n[0]#) each out}; 

ACCBANDS:tacall[`TA_ACCBANDS;3]; /Acceleration Bands:{TimePeriod:(2..100000)},[High, Low, Close]->[UpperBand,MiddleBand,LowerBand]
AD:tacall[`TA_AD;1]; /Chaikin A/D Line:{},[High, Low, Close, Volume]->[out]
ADOSC:tacall[`TA_ADOSC;1]; /Chaikin A/D Oscillator:{FastPeriod(2..100000),SlowPeriod(2..100000)},[High, Low, Close, Volume]->[out]
ADX:tacall[`TA_ADX;1]; /Average Directional Movement Index:{TimePeriod(2..100000)},[High, Low, Close]->[out]
ADXR:tacall[`TA_ADXR;1]; /Average Directional Movement Index Rating:{TimePeriod(2..100000)},[High, Low, Close]->[out]
APO:tacall[`TA_APO;1]; /Absolute Price Oscillator:{FastPeriod(2..100000),SlowPeriod(2..100000),MAType},[in]->[out]
AROON:tacall[`TA_AROON;2]; /Aroon:{TimePeriod(2..100000)},[High, Low]->[AroonDown,AroonUp]
AROONOSC:tacall[`TA_AROONOSC;1]; /Aroon Oscillator:{TimePeriod(2..100000)},[High, Low]->[out]:
ATR:tacall[`TA_ATR;1]; /Average True Range:{TimePeriod(1..100000)},[High, Low, Close]->[out]
AVGPRICE:tacall[`TA_AVGPRICE;1]; /Average Price:{},[Open, High, Low, Close]->[out]

BBANDS:tacall[`TA_BBANDS;3]; /Bollinger Bands:{TimePeriod:(2..100000),NbDevUp(TA_REAL_MIN..TA_REAL_MAX),NbDevDn(TA_REAL_MIN..TA_REAL_MAX),MAType},[in]->[UpperBand,MiddleBand,LowerBand]
BETA:tacall[`TA_BETA;1]; /BETA:{TimePeriod(1..100000)},[in0,in1]->[out]
BOP:tacall[`TA_BOP;1]; /Balance Of Power:{},[Open, High, Low, Close]->[out]

CCI:tacall[`TA_CCI;1]; /Balance Of Power:{TimePeriod(2..100000)},[High, Low, Close]->[out]

CDL2CROWS:tacall[`TA_CDL2CROWS;-1]; /Two Crows:{},[Open,High, Low, Close]->[outInt]
CDL3BLACKCROWS:tacall[`TA_CDL3BLACKCROWS;-1]; /Three Black Crows:{},[Open,High, Low, Close]->[outInt]
CDL3INSIDE:tacall[`TA_CDL3INSIDE;-1]; /Three Inside Up/Down:{},[Open,High, Low, Close]->[outInt]
CDL3LINESTRIKE:tacall[`TA_CDL3LINESTRIKE;-1]; /Three-Line Strike:{},[Open,High, Low, Close]->[outInt]
CDL3OUTSIDE:tacall[`TA_CDL3OUTSIDE;-1]; /Three Outside Up/Down:{},[Open,High, Low, Close]->[outInt]
CDL3STARSINSOUTH:tacall[`TA_CDL3STARSINSOUTH;-1]; /Three Stars In The South:{},[Open,High, Low, Close]->[outInt]
CDL3WHITESOLDIERS:tacall[`TA_CDL3WHITESOLDIERS;-1]; /Three Advancing White Soldiers:{},[Open,High, Low, Close]->[outInt]
CDLABANDONEDBABY:tacall[`TA_CDLABANDONEDBABY;-1]; /Abandoned Baby:{Penetration(0..TA_REAL_MAX)},[Open,High, Low, Close]->[outInt]
CDLADVANCEBLOCK:tacall[`TA_CDLADVANCEBLOCK;-1]; /Advance Block:{},[Open,High, Low, Close]->[outInt]
CDLBELTHOLD:tacall[`TA_CDLBELTHOLD;-1]; /Belt-hold:{},[Open,High, Low, Close]->[outInt]
CDLBREAKAWAY:tacall[`TA_CDLBREAKAWAY;-1]; /Breakaway:{},[Open,High, Low, Close]->[outInt]
CDLCLOSINGMARUBOZU:tacall[`TA_CDLCLOSINGMARUBOZU;-1]; /Closing Marubozu:{},[Open,High, Low, Close]->[outInt]
CDLCONCEALBABYSWALL:tacall[`TA_CDLCONCEALBABYSWALL;-1]; /Concealing Baby Swallow:{},[Open,High, Low, Close]->[outInt]
CDLCOUNTERATTACK:tacall[`TA_CDLCOUNTERATTACK;-1]; /Counterattack:{},[Open,High, Low, Close]->[outInt]
CDLDARKCLOUDCOVER:tacall[`TA_CDLDARKCLOUDCOVER;-1]; /Dark Cloud Cover:{Penetration(0..TA_REAL_MAX)},[Open,High, Low, Close]->[outInt]
CDLDOJI:tacall[`TA_CDLDOJI;-1]; /Doji:{},[Open,High, Low, Close]->[outInt]
CDLDOJISTAR:tacall[`TA_CDLDOJISTAR;-1]; /Doji Star:{},[Open,High, Low, Close]->[outInt]
CDLDRAGONFLYDOJI:tacall[`TA_CDLDRAGONFLYDOJI;-1]; /Dragonfly Doji:{},[Open,High, Low, Close]->[outInt]
CDLENGULFING:tacall[`TA_CDLENGULFING;-1]; /Engulfing Pattern:{},[Open,High, Low, Close]->[outInt]
CDLEVENINGDOJISTAR:tacall[`TA_CDLEVENINGDOJISTAR;-1]; /Evening Doji Star:{Penetration(0..TA_REAL_MAX)},[Open,High, Low, Close]->[outInt]
CDLEVENINGSTAR:tacall[`TA_CDLEVENINGSTAR;-1]; /Evening Star:{Penetration(0..TA_REAL_MAX)},[Open,High, Low, Close]->[outInt]
CDLGAPSIDESIDEWHITE:tacall[`TA_CDLGAPSIDESIDEWHITE;-1]; /Up/Down-gap side-by-side white lines:{},[Open,High, Low, Close]->[outInt]
CDLGRAVESTONEDOJI:tacall[`TA_CDLGRAVESTONEDOJI;-1]; /Gravestone Doji:{},[Open,High, Low, Close]->[outInt]
CDLHAMMER:tacall[`TA_CDLHAMMER;-1]; /Hammer:{},[Open,High, Low, Close]->[outInt]
CDLHANGINGMAN:tacall[`TA_CDLHANGINGMAN;-1]; /Hanging Man:{},[Open,High, Low, Close]->[outInt]
CDLHARAMI:tacall[`TA_CDLHARAMI;-1]; /Harami Pattern:{},[Open,High, Low, Close]->[outInt]
CDLHARAMICROSS:tacall[`TA_CDLHARAMICROSS;-1]; /Harami Cross Pattern:{},[Open,High, Low, Close]->[outInt]
CDLHIGHWAVE:tacall[`TA_CDLHIGHWAVE;-1]; /High-Wave Candle:{},[Open,High, Low, Close]->[outInt]
CDLHIKKAKE:tacall[`TA_CDLHIKKAKE;-1]; /Hikkake Pattern:{},[Open,High, Low, Close]->[outInt]
CDLHIKKAKEMOD:tacall[`TA_CDLHIKKAKEMOD;-1]; /Modified Hikkake Pattern:{},[Open,High, Low, Close]->[outInt]
CDLHOMINGPIGEON:tacall[`TA_CDLHOMINGPIGEON;-1]; /Homing Pigeon:{},[Open,High, Low, Close]->[outInt]
CDLIDENTICAL3CROWS:tacall[`TA_CDLIDENTICAL3CROWS;-1]; /Identical Three Crows:{},[Open,High, Low, Close]->[outInt]
CDLINNECK:tacall[`TA_CDLINNECK;-1]; /In-Neck Pattern:{},[Open,High, Low, Close]->[outInt]
CDLINVERTEDHAMMER:tacall[`TA_CDLINVERTEDHAMMER;-1]; /Inverted Hammer:{},[Open,High, Low, Close]->[outInt]
CDLKICKING:tacall[`TA_CDLKICKING;-1]; /Kicking:{},[Open,High, Low, Close]->[outInt]
CDLKICKINGBYLENGTH:tacall[`TA_CDLKICKINGBYLENGTH;-1]; /Kicking - bull/bear determined by the longer marubozu:{},[Open,High, Low, Close]->[outInt]
CDLLADDERBOTTOM:tacall[`TA_CDLLADDERBOTTOM;-1]; /Ladder Bottom:{},[Open,High, Low, Close]->[outInt]
CDLLONGLEGGEDDOJI:tacall[`TA_CDLLONGLEGGEDDOJI;-1]; /Long Legged Doji:{},[Open,High, Low, Close]->[outInt]
CDLLONGLINE:tacall[`TA_CDLLONGLINE;-1]; /Long Line Candle:{},[Open,High, Low, Close]->[outInt]
CDLMARUBOZU:tacall[`TA_CDLMARUBOZU;-1]; /Marubozu:{},[Open,High, Low, Close]->[outInt]
CDLMATCHINGLOW:tacall[`TA_CDLMATCHINGLOW;-1]; /Matching Low:{},[Open,High, Low, Close]->[outInt]
CDLMATHOLD:tacall[`TA_CDLMATHOLD;-1]; /Mat Hold:{Penetration(0..TA_REAL_MAX)},[Open,High, Low, Close]->[outInt]
CDLMORNINGDOJISTAR:tacall[`TA_CDLMORNINGDOJISTAR;-1]; /Morning Doji Star:{Penetration(0..TA_REAL_MAX)},[Open,High, Low, Close]->[outInt]
CDLMORNINGSTAR:tacall[`TA_CDLMORNINGSTAR;-1]; /Morning Star:{Penetration(0..TA_REAL_MAX)},[Open,High, Low, Close]->[outInt]
CDLONNECK:tacall[`TA_CDLONNECK;-1]; /On-Neck Pattern:{},[Open,High, Low, Close]->[outInt]
CDLPIERCING:tacall[`TA_CDLPIERCING;-1]; /Piercing Pattern:{},[Open,High, Low, Close]->[outInt]
CDLRICKSHAWMAN:tacall[`TA_CDLRICKSHAWMAN;-1]; /Rickshaw Man:{},[Open,High, Low, Close]->[outInt]
CDLRISEFALL3METHODS:tacall[`TA_CDLRISEFALL3METHODS;-1]; /Rising/Falling Three Methods:{},[Open,High, Low, Close]->[outInt]
CDLSEPARATINGLINES:tacall[`TA_CDLSEPARATINGLINES;-1]; /Separating Lines:{},[Open,High, Low, Close]->[outInt]
CDLSHOOTINGSTAR:tacall[`TA_CDLSHOOTINGSTAR;-1]; /Shooting Star:{},[Open,High, Low, Close]->[outInt]
CDLSHORTLINE:tacall[`TA_CDLSHORTLINE;-1]; /Short Line Candle:{},[Open,High, Low, Close]->[outInt]
CDLSPINNINGTOP:tacall[`TA_CDLSPINNINGTOP;-1]; /Spinning Top:{},[Open,High, Low, Close]->[outInt]
CDLSTALLEDPATTERN:tacall[`TA_CDLSTALLEDPATTERN;-1]; /Stalled Pattern:{},[Open,High, Low, Close]->[outInt]
CDLSTICKSANDWICH:tacall[`TA_CDLSTICKSANDWICH;-1]; /Stick Sandwich:{},[Open,High, Low, Close]->[outInt]
CDLTAKURI:tacall[`TA_CDLTAKURI;-1]; /Takuri (Dragonfly Doji with very long lower shadow):{},[Open,High, Low, Close]->[outInt]
CDLTASUKIGAP:tacall[`TA_CDLTASUKIGAP;-1]; /Tasuki Gap:{},[Open,High, Low, Close]->[outInt]
CDLTHRUSTING:tacall[`TA_CDLTHRUSTING;-1]; /Thrusting Pattern:{},[Open,High, Low, Close]->[outInt]
CDLTRISTAR:tacall[`TA_CDLTRISTAR;-1]; /Tristar Pattern:{},[Open,High, Low, Close]->[outInt]
CDLUNIQUE3RIVER:tacall[`TA_CDLUNIQUE3RIVER;-1]; /Unique 3 River:{},[Open,High, Low, Close]->[outInt]
CDLUPSIDEGAP2CROWS:tacall[`TA_CDLUPSIDEGAP2CROWS;-1]; /Upside Gap Two Crows:{},[Open,High, Low, Close]->[outInt]
CDLXSIDEGAP3METHODS:tacall[`TA_CDLXSIDEGAP3METHODS;-1]; /Upside/Downside Gap Three Methods:{},[Open,High, Low, Close]->[outInt]

CMO:tacall[`TA_CMO;1]; /Chande Momentum Oscillator:{TimePeriod(2..100000)},[in]->[out]
CORREL:tacall[`TA_CORREL;1]; /Pearson's Correlation Coefficient (r):{TimePeriod(1..100000)},[in0,in1]->[out]

DEMA:tacall[`TA_DEMA;1]; /Double Exponential Moving Average:{TimePeriod(2..100000)},[in]->[out]
DX:tacall[`TA_DX;1]; /Directional Movement Index:{TimePeriod(2..100000)},[High, Low, Close]->[out]

EMA:tacall[`TA_EMA;1]; /Exponential Moving Average:{TimePeriod(2..100000)},[in]->[out]

HT_DCPERIOD:tacall[`TA_HT_DCPERIOD;1]; /Hilbert Transform - Dominant Cycle Period:{},[in]->[out]
HT_DCPHASE:tacall[`TA_HT_DCPHASE;1]; /Hilbert Transform - Dominant Cycle Phase:{},[in]->[out]
HT_PHASOR:tacall[`TA_HT_PHASOR;2]; /Hilbert Transform - Phasor Components:{},[in]->[Phase,Quadrature]
HT_SINE:tacall[`TA_HT_SINE;2]; /Hilbert Transform - SineWave:{},[in]->[Sine,LeadSine]
HT_TRENDLINE:tacall[`TA_HT_TRENDLINE;1]; /Hilbert Transform - Instantaneous Trendline:{},[in]->[out]
HT_TRENDMODE:tacall[`TA_HT_TRENDMODE;-1]; /Hilbert Transform - Trend vs Cycle Mode:{},[in]->[outInt]

KAMA:tacall[`TA_KAMA;1]; /Kaufman Adaptive Moving Average:{TimePeriod(2..100000)},[in]->[out]

LINEARREG:tacall[`TA_LINEARREG;1]; /Linear Regression:{TimePeriod(2..100000)},[in]->[out]
LINEARREG_ANGLE:tacall[`TA_LINEARREG_ANGLE;1]; /Linear Regression Angle:{TimePeriod(2..100000)},[in]->[out]
LINEARREG_INTERCEPT:tacall[`TA_LINEARREG_INTERCEPT;1]; /Linear Regression Intercept:{TimePeriod(2..100000)},[in]->[out]
LINEARREG_SLOPE:tacall[`TA_LINEARREG_SLOPE;1]; /Linear Regression Slope:{TimePeriod(2..100000)},[in]->[out]

MA:tacall[`TA_MA;1]; /Moving average:{TimePeriod(2..100000),MAType},[in]->[out]
MACD:tacall[`TA_MACD;3]; /Moving Average Convergence/Divergence:{FastPeriod(2-1e5),SlowPeriod(2-1e5),SignalPeriod(1-1e5)},[in]->[MACD,MACDSignal,MACDHist]
MACDEXT:tacall[`TA_MACDEXT;3]; /MACD with controllable MA type:{FastPeriod,FastMAType,SlowPeriod,SlowMAType,SignalPeriod,SignalMAType},[in]->[...]
MACDFIX:tacall[`TA_MACDFIX;3]; /Moving Average Convergence/Divergence Fix 12/26:{SignalPeriod},[in]->[...]
MAMA:tacall[`TA_MAMA;2]; /MESA Adaptive Moving Average:{FastLimit(0.01..0.99),SlowLimit(0.01..0.99)},[in]->[MAMA,FAMA]
MAVP:tacall[`TA_MAVP;1]; /Moving average with variable period:{MinPeriod(2..1e5),MaxPeriod(2..1e5),MAType},[in,inPeriods]->[out]
MFI:tacall[`TA_MFI;1]; /Money Flow Index:{TimePeriod(2..100000)},[High, Low, Close, Volume]->[out]
MINUS_DI:tacall[`TA_MINUS_DI;1]; /Minus Directional Indicator:{TimePeriod(1..100000)},[High, Low, Close]->[out]
MINUS_DM:tacall[`TA_MINUS_DM;1]; /Minus Directional Movement:{TimePeriod(1..100000)},[High, Low]->[out]
MOM:tacall[`TA_MOM;1]; /Momentum:{TimePeriod(1..100000)},[in]->[out]

NATR:tacall[`TA_NATR;1]; /Normalized Average True Range:{TimePeriod(1..100000)},[High, Low, Close]->[out]

OBV:tacall[`TA_OBV;1]; /On Balance Volume:{},[in,inVolume]->[out]

PLUS_DI:tacall[`TA_PLUS_DI;1]; /Plus Directional Indicator:{TimePeriod(1..100000)},[High, Low, Close]->[out]
PLUS_DM:tacall[`TA_PLUS_DM;1]; /Plus Directional Movement:{TimePeriod(1..100000)},[High, Low]->[out]
PPO:tacall[`TA_PPO;1]; /Percentage Price Oscillator:{FastPeriod(2..100000),SlowPeriod(2..100000),MAType},[in]->[out]

ROC:tacall[`TA_ROC;1]; /Rate of change : ((price/prevPrice)-1)*100 :{TimePeriod(1..100000)},[in]->[out]
ROCP:tacall[`TA_ROCP;1]; /Rate of change Percentage: (price-prevPrice)/prevPrice :{TimePeriod(1..100000)},[in]->[out]
ROCR:tacall[`TA_ROCR;1]; /Rate of change ratio: (price/prevPrice) :{TimePeriod(1..100000)},[in]->[out]
ROCR100:tacall[`TA_ROCR100;1]; /Rate of change ratio 100 scale: (price/prevPrice)*100 :{TimePeriod(1..100000)},[in]->[out]
RSI:tacall[`TA_RSI;1]; /Relative Strength Index:{TimePeriod(2..100000)},[in]->[out]

SAR:tacall[`TA_SAR;1]; /Parabolic SAR:{Acceleration(0..TA_REAL_MAX),Maximum(0..TA_REAL_MAX)},[High, Low]->[out]
SAREXT:tacall[`TA_SAREXT;1]; /Parabolic SAR - Extended:{StartValue(TA_REAL_MIN..TA_REAL_MAX),OffsetOnReverse(0..TA_REAL_MAX),AccelerationInitLong(0..TA_REAL_MAX),AccelerationLong(0..TA_REAL_MAX),AccelerationMaxLong(0..TA_REAL_MAX),AccelerationInitShort(0..TA_REAL_MAX),AccelerationShort(0..TA_REAL_MAX),AccelerationMaxShort(0..TA_REAL_MAX)},[High, Low]->[out]
SMA:tacall[`TA_SMA;1]; /Simple Moving average:{TimePeriod(2..100000)},[in]->[out]
STOCH:tacall[`TA_STOCH;2]; /Stochastic:{FastK_Period(1-1e5),SlowK_Period(1-1e5),SlowK_MAType,SlowD_Period(1-1e5),SlowD_MAType},[High, Low, Close]->[SlowK,SlowD]
STOCHF:tacall[`TA_STOCHF;2]; /Stochastic Fast:{FastK_Period(1-1e5),FastD_Period(1-1e5),FastD_MAType},[High, Low, Close]->[FastK,FastD]
STOCHRSI:tacall[`TA_STOCHRSI;2]; /Stochastic Relative Strength Index:{TimePeriod(2-1e5),FastK_Period(1-1e5),FastD_Period(1-1e5),FastD_MAType},[High,Low,Close]->[FastK,FastD]

T3:tacall[`TA_T3;1]; /Triple Exponential Moving Average (T3):{TimePeriod(2..100000)},[in]->[out]
TEMA:tacall[`TA_TEMA;1]; /Triple Exponential Moving Average:{TimePeriod(2..100000)},[in]->[out]
TRANGE:tacall[`TA_TRANGE;1]; /True Range:{},[High, Low, Close]->[out]
TRIMA:tacall[`TA_TRIMA;1]; /Triangular Moving Average:{TimePeriod(2..100000)},[in]->[out]
TRIX:tacall[`TA_TRIX;1]; /1-day Rate-Of-Change (ROC) of a Triple Smooth EMA:{TimePeriod(1..100000)},[in]->[out]
TSF:tacall[`TA_TSF;1]; /Time Series Forecast:{TimePeriod(2..100000)},[in]->[out]
TYPPRICE:tacall[`TA_TYPPRICE;1]; /Typical Price:{},[High, Low, Close]->[out]

ULTOSC:tacall[`TA_ULTOSC;1]; /Ultimate Oscillator:{TimePeriod1(1..1e5),TimePeriod2(1..1e5),TimePeriod3(1..1e5)},[High, Low, Close]->[out]

WCLPRICE:tacall[`TA_WCLPRICE;1]; /Weighted Close Price:{},[High, Low, Close]->[out]
WILLR:tacall[`TA_WILLR;1]; /Williams' %R:{TimePeriod(2..1e5)},[High, Low, Close]->[out]
WMA:tacall[`TA_WMA;1]; /Weighted Moving Average:{TimePeriod(2..1e5)},[in]->[out]

DefaultPara:`CDLABANDONEDBABY`CDLDARKCLOUDCOVER`CDLEVENINGDOJISTAR`CDLEVENINGSTAR`CDLMATHOLD`CDLMORNINGDOJISTAR`CDLMORNINGSTAR!enlist each (1f;1f;1f;1f;1f;1f;1f);

\d .
lfill:{(x first where not null x)^fills x}; /left fill,use leftmost not null elem fill list.
N:400;
d:N?1f;
b:enlist 0N;
n:enlist 0N;
z:(3,N)#0n;
r:.ffi.cf[("i";(`$"/usr/local/lib/libta_lib.so"),`TA_MACD)] (0;-1+count d;d;12;26;9;b;n),z;
z1:.talib.MACD[12 26 9;d];