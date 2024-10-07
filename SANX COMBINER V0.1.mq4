//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
//============================================================================================================================================================
//demo DATA DA EXPIRAÇÃO                           // demo DATA DA EXPIRAÇÃO
bool use_demo= TRUE; // FALSE  // TRUE            // TRUE ATIVA / FALSE DESATIVA EXPIRAÇÃO
string ExpiryDate= "2050.08.18 00:00:00";                   // DATA DA EXPIRAÇÃO
string expir_msg="SANX COMBINER EXPIRED? CONTACT:@Sanjay_saju"; // MENSAGEM DE AVISO QUANDO EXPIRAR
//============================================================================================================================================================
//NÚMERO DA CONTA MT4                              // NÚMERO DA CONTA MT4
bool use_acc_number= TRUE ; // TRUE  // TRUE      // TRUE ATIVA / FALSE DESATIVA NÚMERO DE CONTA
long acc_number[]={501176196,16189130};                        // NÚMERO DA CONTA
string acc_numb_msg="VERIFY ID!!! CONTACT:@Sanjay_saju !!!"; //ID
//+------------------------------------------------------------------+

#property description   "Sanx-Indicator All rights reserved ©"
#property copyright ""
#property link      ""
#property description "Updated day 18/06/2050"
#property description "======================================================="



#property strict
//============================================================================================================================================================
#property indicator_chart_window
#property indicator_buffers 80
//============================================================================================================================================================
#include <WinUser32.mqh>

string KingBinaryIndicatorProtector[256];

#import "user32.dll"
int   RegisterWindowMessageA(string lpstring);
int   PostMessageA(int  hWnd,int  Msg,int  wParam,string lParam);
#import
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
#import "kernel32.dll"
int  FindFirstFileW(string Path, ushort &Answer[]);
bool FindNextFileW(int handle,  ushort &Answer[]);
bool FindClose(int handle);
#import



//============================================================================================================================================================
//============================================================================================================================================================
#import "Telegram4Mql.dll"
string TelegramSendText(string ApiKey, string ChatId, string ChatText);
string TelegramSendTextAsync(string apiKey, string chatId, string chatText);
string TelegramSendPhotoAsync(string apiKey, string chatId, string filePath, string caption = "");
#import

#import  "Wininet.dll"
int InternetOpenW(string, int, string, string, int);
int InternetConnectW(int, string, int, string, string, int, int, int);
int HttpOpenRequestW(int, string, string, int, string, int, string, int);
int InternetOpenUrlW(int, string, string, int, int, int);
int InternetReadFile(int, uchar & arr[], int, int& OneInt[]);
int InternetCloseHandle(int);
bool HttpSendRequestW(int, string, int, string, int);
#import

#import "Kernel32.dll"
   bool GetVolumeInformationW(string,string,uint,uint&[],uint,uint,string,uint);
   #import
//============================================================================================================================================================
//CORRETORAS DISPONÍVEIS
enum corretora_price_pro
  {
   EmTodas = 1,    //Todas
   EmIQOption = 2, //IQ Option
   EmSpectre = 3,  //Spectre
   EmBinary = 4,   //Binary
   EmGC = 5,       //Grand Capital
   EmBinomo = 6,   //Binomo
   EmOlymp = 7     //Olymp Trade
  };
//============================================================================================================================================================
enum broker
  {
   Todos = 0,   //Todas
   IQOption = 1,
   Binary = 2,
   Spectre = 3,
   Alpari = 4,
   InstaBinary = 5
  };
//============================================================================================================================================================
enum corretora
  {
   Todas = 0,   //Todas
   IQ = 1,      //IQ Option
   Bin = 2,     //Binary
   Spectree = 3,//Spectre
   GC = 4,      //Grand Capital
   Binomo = 5,  //Binomo
   Olymp = 6    //Olymp Trade
  };
//============================================================================================================================================================
enum sinal
  {
   MESMA_VELA = 0,  //SAME CANDLE
   PROXIMA_VELA = 1 //NEXT CANDLE
  };
//============================================================================================================================================================
enum tipo_expiracao
  {
   TEMPO_FIXO = 0, //Fixed Time!
   RETRACAO = 1    //Time Frame Time!
  };
//============================================================================================================================================================
enum entrar
  {
   NO_TOQUE = 0,    //NO TOQUE
   FIM_DA_VELA = 1  //FIM DA VELA
  };
//============================================================================================================================================================
enum modo
  {
   MELHOR_PAYOUT = 'M', //MELHOR PAYOUT
   BINARIAS = 'B',      //BINARIAS
   DIGITAIS = 'D'       //DIGITAIS
  };
//============================================================================================================================================================
enum instrument
  {
   DoBotPro= 3, //DO BOT PRO
   Binaria= 0,  //BINARIA
   Digital = 1, //DIGITAL
   MaiorPay =2  //MAIOR PAYOUT
  }; 
//============================================================================================================================================================
enum signaltype
  {
   IntraBar = 0,          // SAME CANDLE
   ClosedCandle = 1       // NEXT CANDLE
  };
//============================================================================================================================================================
enum martintype
  {
   NoMartingale = 0,             // Sem Martingale (No Martingale)
   OnNextExpiry = 1,             // Próxima Expiração (Next Expiry)
   OnNextSignal = 2,             // Próximo Sinal (Next Signal)
   Anti_OnNextExpiry = 3,        // Anti-/ Próxima Expiração (Next Expiry)
   Anti_OnNextSignal = 4,        // Anti-/ Próximo Sinal (Next Signal)
   OnNextSignal_Global = 5,      // Próximo Sinal (Next Signal) (Global)
   Anti_OnNextSignal_Global = 6  // Anti-/ Próximo Sinal (Global)
  };
//============================================================================================================================================================
enum FiltroEma
  {
   EMA  = 1,  // EMA
   SMMA = 2,  // SMMA
   LWMA = 3,  // LWMA
   LSMA = 4   // LSMA SMA
  };
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
enum SanxChave
  {
   disabled=0, //disabled off
   activate=1     //activate on
  };
enum intervalo
  {
   Cinco = PERIOD_M5,        // 5 MINUTES
   Quinze = PERIOD_M15,      // 15 MINUTES
   Trinta = PERIOD_M30,      // 30 MINUTES
   Uma_Hora = PERIOD_H1,     // 1 HOUR
  };
//============================================================================================================================================================
enum antloss
  {
   off   = 0,  //NÃO
   gale1 = 1  //ENTRAR APOS VELA
  };

enum extensaoROBO
  {
   csv   = 0,  //CSV
   txt = 1  //TXT
  };

enum automtizadores
  {
   DesligarRobo   = 0,  //OFF
   //OperarComBotCopy   = 1,  //BOT EM NUVEM (RECOMENDANDO)
   OperarComMX2 = 2,  //MX2 
 //  OperarComBOTPRO   = 3,  //BOTPRO
   OperarComPricePro = 4,  //PRICE
   OperarComTOPWIN   = 5,  //TOPWIN V4
   OperarComTOPWIN_ATUAL   = 9,  //TOPWIN V6 
   OperarComFrankestain = 6,  //RETORNO
   OperarComMT2 = 7,  //MT2
  // OperarComB2IQ = 8  //B2IQ
  };

enum simnao
  {
   DEACTIVATE = 0, //NO
   ACTIVATE = 1  //YES
  };

enum tipo
  {
   DESATIVAR_PRE_ALERTA, //DISABLE
   ATIVAR_PRE_ALERTA //ACTIVATE
  };
//============================================================================================================================================================
datetime timet;
//============================================================================================================================================================
//============================================================================================================================================================
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                  DEFINIÇÃO DOS TRADES                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  __________SETTINGS_______________________ = "======| SETTINGS |=================================================================================================";//=================================================================================";
input simnao  AtivaPainel     = true;           // ACTIVATE PANEL
input int    Velas    = 300;            // BACKTEST CANDLE
input int    SecEnvio = 2;              // SECONDS BEFORE SENDING / ANTIDELAY
extern tipo           Entrada = ATIVAR_PRE_ALERTA; //USE ANTIDELAY / PRE ALERT
input simnao   AlertsMessage    = true;    // SEND ALERT
input string  __________CANDLE_______________________ = "======| CANDLE FILTER |==================================================================================================";//=================================================================================";
input simnao   AtivarTamanhoVela = ACTIVATE; // BLOCK BIGGER CANDLE PIPS
extern int MinPips   = 500; // MINIMUM PIPS
input simnao   AtivarTamanhoVela1 = ACTIVATE; // BLOCK SMALLER CANDLE PIPS
extern int maxPips   = 0; // MAXIMUM PIPS
input simnao Bloquea = false;               // BLOCK SAME COLOR ENTRY OF CANDLE ?
input int quantidade = 3;                 // NUMBER OF CANDLES ?
input simnao    FiltroVelas     = false;    // USE CANDLE FILTER ?
simnao  Antiloss = false;            // NUMBER OF CANDLE TO ENTER
bool assinatura = false;          // Ver sua expiração de assinatura ?
 simnao  mostrarID = false; //Mostrar ID p/ automatizar @SanxIQBotz
//============================================================================================================================================================
input string  _________HISTRADTEGY___________________ = "==========================================================================================";//=================================================================================";
input string _________Sanx_STRATEGY100_____________= ""; //                                                                      //
input string _________Sanx_STRATEGY99_____________= "======| SANX STRATEGIES |==========================================================================================="; //========| SANX TRADER |====================                              //
input string _________Sanx_STRATEGY98_____________= ""; //                                                                      //
input string _________Sanx_STRATEGY1_____________= "=======| SANX STRATEGY 1 |======================================================================"; //=================================================================================";
extern simnao Arcanjo_Enabled = ACTIVATE;  //SANX STRATEGY 1 ?
input string _________Sanx_STRATEGY2_____________= "=======| SANX STRATEGY 2 |======================================================================"; //=================================================================================";
extern simnao   God_Enabled   = DEACTIVATE; //SANX STRATEGY 2 ?
input string _________Sanx_STRATEGY3_____________= "=======| SANX STRATEGY 3 |======================================================================"; //=================================================================================";
input simnao Harami  = false;                  // SANX CANDLE STRATEGY 3?
input string _________Sanx_STRATEGY4_____________= "=======| SANX STRATEGY 4 |======================================================================"; //=================================================================================";
input simnao Pulback_Enabled  = false;                 //SANX PULLBACK STRATEGY 4 ?
input string _________Sanx_STRATEGY5_____________= "=======| SANX STRATEGY 5 |======================================================================"; //=================================================================================";
input simnao   SanxExtremo    = false;         // SANX EXTREME STRATEGY 5 ?
input string _________Sanx_STRATEGY6_____________= "=======| SANX STRATEGY 6 |======================================================================"; //=================================================================================";
input simnao   ViradaDeHora    = false;          // SANX TIME-TURN STRATEGY 6 ?
input string _________Sanx_STRATEGY7_____________= "=======| SANX STRATEGY 7 |======================================================================"; //=================================================================================";
input simnao   Fluxo = false;                    // SANX FLOW STRATEGY 7 ?
input string _________Sanx_STRATEGY8_____________= "=======| SANX STRATEGY 8 |======================================================================"; //=================================================================================";
input simnao SorosGale_Enabled = false; // SANX REVERSAL STRATEGY 8 ?
input string  __________PRICEACTION6_______________________ = "==== SANX PRICE ACTION! ==================================================================================================";//=================================================================================";
input simnao   HabilitarTaurus  = true;         // SANX PRICE ACTION ?
input string  _________SANX6STRATEGY___________________ = "==========| SANX MHI STRATEGY |================================================================================";//=================================================================================";
input simnao MHI = false; //SANX MHI STRATEGY  ?
input string  _________MHISTRATEGY___________________ = "========| SANX TDF STRATEGY |=============================================================================================";//=================================================================================";
extern simnao Trend = false;//SANX TDF STRTEGY
extern int Periodo = 2; //PERIOD
input string  _________HISTRATEGY___________________ = "==========================================================================================";//=================================================================================";
input string _________Sanx_STRATEGY101_____________= ""; //                                                                      //
input string _________Sanx_STRATEGY97_____________= "======| SANX STRATEGIES |==========================================================================================="; //========| SANX TRADER |====================                              //
input string _________Sanx_STRATEGY96_____________= ""; //                                                                      //            
//+------------------------------------------------------------------+
//|                    BOLLINGAR_BAND                            |
//+------------------------------------------------------------------+
input string  __________BOLLINGARBAND_______________________ = "========| BOLLINGAR BAND |==================================================================================================";//=================================================================================";
ENUM_TIMEFRAMES STCTimeFrame = PERIOD_CURRENT; //TimeFrame
extern simnao              BB_Enabled = DEACTIVATE; // BOLLINGAR BAND
extern int                BB_Period=20;// PERIOD
input double             BB_Deviations=2.0;//DEVIATION
extern int                BB_Shift=1;//SHIFT
extern ENUM_APPLIED_PRICE  BB_Price =PRICE_CLOSE;//PRICE
ENUM_TIMEFRAMES BBTimeFrame = PERIOD_CURRENT; //TimeFrame
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    STOCHASTIC                            |
//+------------------------------------------------------------------+
input string  __________STOCHASTIC_______________________ = "=========| STOCHASTIC |==================================================================================================";//=================================================================================";
extern simnao SO_Enabled = DEACTIVATE; // STOCHASTIC
extern int                SO_KPeriod=5; // %K PERIOD
extern int                SO_DPeriod=3; // %D PERIOD
extern int                SO_Slowing=3; // SLOW
extern ENUM_MA_METHOD     SO_Mode=MODE_SMA;
extern ENUM_STO_PRICE     SO_Price=STO_CLOSECLOSE;
extern int                SO_MAX=80; // MAXIMUM LEVEL
extern int                SO_MIN=20; // MINIMUM LEVEL 
//+------------------------------------------------------------------+
//|                    VOLUE CHART  vs   RSI                         |
//+------------------------------------------------------------------+
input string  _________OperationalEMA___________________ = "=====| EMA CROSS STRATEGY | ================================================================================";//=================================================================================";
input simnao AtivarCruzamento = false;    //EMA CROSS STRTEGY ?
input int FasterEMA = 1;                // RAPID EMA 
input int SlowerEMA = 5;                // SLOW EMA 
//============================================================================================================================================================
input string  _________MACDSTRATEGY___________________ = "========| MACD STRATEGY |================================================================================";//=================================================================================";
extern simnao AtivarMACD = false; // MACD Strategy ?
extern int MACD_Period1 = 12; // MACD PERIOD 1 
extern int MACD_Period2 = 26; // MACD PERIOD 2 
extern int MACD_Period3 = 9;  // MACD PERIOD 3 
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    ESTRETAGTIA_DRAGON                            |
//+------------------------------------------------------------------+
input string  _________Filtros54___________________ = "======================================================================================";//=================================================================================";
extern simnao HILL = false;              //RSI ARROW(REPAINT)
extern int    PeríodoRSI  = 9;            //RsiLength
input int hillp=0  ;//RsiPrice
extern  int    Divisor = 5;               //HalfLength
extern int    PeríodoDesvio = 100;        //DevPeriod
extern double Desvio = 0.8;             //Deviations
input string _________RSI_STRATEGY_____________= "==========| RSI STRATEGY |======================================================================"; //=================================================================================";
input simnao    SanxEstrategia               = false;  //RSI STRATEGY(RSI+SR)
input int PeriodoRSI = 3;                             //PERIOD RSI
input int MaxRSI = 90;                                //MAXIMUM RSI
input int MinRSI = 10;                               //MINIMUM RSI
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    ESTRETAGTIA_DRAGON_1                          |
//+------------------------------------------------------------------+
input string _________CANDLE_CONFIRMATION_____________= "=======| CANDLE RESPECT |======================================================================"; //=================================================================================";
input simnao    SanxEstrategia1               = false;  //CANDLE RESPECT(RSI+SR+CANDLE)
input int PeriodoRSI1 = 3;                             //PERIOD RSI
input int MaxRSI1 = 90;                                //MAXIMUM RSI
input int MinRSI1 = 10;                               //MINIMUM RSI
//============================================================================================================================================================
input string _________VOLUME_STRATEGY_____________= "=======| VOLUME STRATEGY |======================================================================"; //=================================================================================";
input simnao  VolumeStrategy_Enabled               = false;
extern int Volume_Period = 14;            // MA PERIOD FOR VOLUME
extern double Volume_Threshold = 1.5;     // THREHOLD VOLUME
//+------------------------------------------------------------------+
//|                   SUPORTE_E_RESISTENCIA                          |
//+------------------------------------------------------------------+
input string  ________SUPPORT_AND_RESISTANCE___________________ = "====| SUPPORT AND RESISTANCE |================================================================================";//=================================================================================";
input simnao  SeR                = false;  // SUPPORT AND RESSISTENT
input int mediaMovel = 14; //MEDIA MOVEL
//input int mediaMovel2 = 30; //Periodo Segunda Media Movel
static simnao MostrarLinha = false; //Mostrar Marcação SeR
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    AtivaDonchian                                     |
//+------------------------------------------------------------------+
input string  ________DONCHIAN___________________ = "=======| DONCHAIN STRATEGY |================================================================================";//=================================================================================";
extern simnao AtivaDonchian = DEACTIVATE; //ACTIVATE DONCHAIN
extern int       Periods=15; //PERIODS
extern int       Extremes=3; //EXTREMES
extern int       Margins=-2; //MARGINS
int       Advance=0; //ADVANCE
extern int LarguraDonchian = 2; //LINE WIDTH
extern ENUM_LINE_STYLE EstiloDonChian = STYLE_SOLID; //LINE STYLE
extern color CorDonChianAcima = clrGreen; //TOP LINE COLOUR
extern color CorDonChianAbaixo = clrRed; //BOTTOM LINE COLOUR
//====================================================================================================================================================
//+------------------------------------------------------------------+
//|                    CCI                                           |
//+------------------------------------------------------------------+
input string  ________CCI___________________ = "=======| CCI STRATEGY |================================================================================";//=================================================================================";
extern simnao Cci_Enabled  = DEACTIVATE;// ACTIVATE CCI
input int                   CCI_Period               = 6;                     // PERIOD
input ENUM_APPLIED_PRICE    Apply_to                 = PRICE_TYPICAL;         // PRICE
input int                   CCI_Overbought_Level     = 160;                   // MAXIMUM LEVEL
input int                   CCI_Oversold_Level       = -160;                  //MINIMUM LEVEL
//============================================================================================================================================================input string  ________SeR___________________ = "=== SUPORTE E RESITENCIA ================================================================================";//=================================================================================";
//+------------------------------------------------------------------+
//|                    ADX                                           |
//+------------------------------------------------------------------+
input string  ________ADX___________________ = "=======| ADX STRATEGY |================================================================================";//=================================================================================";
extern simnao             Adx_Enabled  = DEACTIVATE;                  // ACTIVATE ADX
extern int                period_adx   = 14;                  // PERIOD
extern double             level_adx    = 60.0;                 // LEVEL
extern ENUM_APPLIED_PRICE price_adx    = 0;                   // PRICE
//============================================================================================================================================================input string  ________SeR___________________ = "=== SUPORTE E RESITENCIA ================================================================================";//=================================================================================";
//============================================================================================================================================================input string  ________SeR___________________ = "=== SUPORTE E RESITENCIA ================================================================================";//=================================================================================";
//+------------------------------------------------------------------+
//|                    DON_FOREX                                     |
//+------------------------------------------------------------------+
input string  ________DON_FOREX___________________ = "=======| DONFOREX STRATEGY |================================================================================";//=================================================================================";
input simnao ativar_donforex = false; //DONFOREX
input int min_size_donforex = 6; //MINIMUM AREA
//============================================================================================================================================================
//============================================================================================================================================================
input string  _________OperationalRVI___________________ = "========| RVI FILTER STRATEGY |================================================================================";//=================================================================================";
input simnao  EnabledRVI  = false;  //STRATEGY RVI ?
input int PERIODORVI = 6;         //PERIOD RVI 
input int Linha = 1;              //0 = RVI LINE, 1 = SIGNAL LINE
input double MAXRVI = 0.1;        //MAXIMUM RVI 
input double MINRVI = -0.1;       //MINIMUM RVI 
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    VOLUE CHART  vs   RSI                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________OperationalMFI___________________ = "========| MFI FILTER STRATEGY |================================================================================";//=================================================================================";
input simnao   EnabledMFI = false; //STRATEGY MFI?
input int PERIODOMFI = 3;        //PERIOD MFI 
input ENUM_APPLIED_PRICE  mfiPrice   = PRICE_CLOSE; // INPUT MODULE
input int MAXMFI = 95;           //MAXIMUM MFI 
input int MINMFI = 5;            //MINIMUM MFI 
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    VOLUE CHART  vs   RSI                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________OperationalWPR___________________ = "========| WPR FILTER STRATEGY |================================================================================";//=================================================================================";
input simnao  EnabledWPR  = false; //STRATEGY WPR  ?
input int PERIODOWPR = 1;        //PERIOD WPR 
input ENUM_APPLIED_PRICE  wprPrice   = PRICE_CLOSE; // INPUT MODULE
input int MAXWPR = -95;          //MAXIMUM WPR 
input int MINWPR = -5;           //MINIMUM WPR 
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   FILTRO_DE_TENDENCIA                            |
//+------------------------------------------------------------------+
input string  ________TREND_FILTER___________________ = "=======| TREND FILTER |================================================================================";//=================================================================================";
input simnao              Filtro_Tendencia               = false;                       // TREND FILTER
input int gi_84 = 80; //PERIOD
input double gd_88 = 0 ; //SHIFT
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   FILTRO_DE_RETRAÇÃO                             |
//+------------------------------------------------------------------+
input string  ________RETRACTION_FILTER___________________ = "=======| RETRACTION FILTER |================================================================================";//=================================================================================";
input simnao              FILT_RET_              = false;                             // RETRACTION FILTER
input int                SanxRatio           =80;                               // BODY x WICK [%]
//============================================================================================================================================================input string  ________SeR___________________ = "=== SUPORTE E RESITENCIA ================================================================================";//=================================================================================";
//+------------------------------------------------------------------+
//|                    INDICADOR_EXTERNO_1                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string ___________EXTERNAL_INDICATOR_1_____________= "========= EXTERNAL INDICATOR  ======================================================================"; //=================================================================================";
input simnao COMBINER = false;         // ACTIVATE THIS INDICATOR ?
input string IndicatorName = "";     // INDICATOR NAME ?
input int IndiBufferCall = 0;        // BUFFER CALL ?
input int IndiBufferPut = 1;         // BUFFER PUT ?
input signaltype SignalType = IntraBar;    // ENTRY TYPE ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    INDICADOR_EXTERNO_2                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string ___________EXTERNAL_INDICATOR_2_____________= "======= EXTERNAL INDICATOR 2! ======================================================================"; //=================================================================================";
input simnao COMBINER2 = false;         // ACTIVATE THIS INDICATOR?
input string IndicatorName2 = "";     // INDICATOR NAME ?
input int IndiBufferCall2= 0;        // BUFFER CALL ?
input int IndiBufferPut2 = 1;         // BUFFER PUT ?
input signaltype SignalType2 = IntraBar;    // ENTRY TYPE ?
//+------------------------------------------------------------------+
//|                    INDICADOR_EXTERNO_3                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string ___________EXTERNAL_INDICATOR_3_____________= "====== EXTERNAL INDICATOR 3!  ======================================================================"; //=================================================================================";
input simnao COMBINER3 = false;         // ACTIVATE THIS INDICATOR?
input string IndicatorName3 = "";     //INDICATOR NAME ?
input int IndiBufferCall3= 0;        // BUFFER CALL ?
input int IndiBufferPut3 = 1;         // BUFFER PUT ?
input signaltype SignalType3 = IntraBar;    // ENTRY TYPE ?
//+------------------------------------------------------------------+
//|                    INDICADOR_EXTERNO_4                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string ___________EXTERNAL_INDICATOR_4_____________= "====== EXTERNAL INDICATOR 4!  ======================================================================"; //=================================================================================";
input simnao COMBINER4 = false;         // ACTIVATE THIS INDICATOR?
input string IndicatorName4 = "";     // INDICATOR NAME ?
input int IndiBufferCall4= 0;        // BUFFER CALL ?
input int IndiBufferPut4 = 1;         // BUFFER PUT ?
input signaltype SignalType4 = IntraBar;    // ENTRY TYPE ?
//============================================================================================================================================================
input string  __________TIME_FILTER_______________________ = "====== TIME FILTER! ==================================================================================================";//=================================================================================";
input simnao           filtro_horario = false;                                //ACTIVATE FILTER
input string         horario_inicio_sinais = "00:00";                     //START TIME
input string         horario_fim_sinais = "16:00";                        //END TIME
input string         horario_inicio_sinais3 = "21:00";                     //START TIME
input string         horario_fim_sinais3 = "23:59";                        //END TIME
//============================================================================================================================================================
//============================================================================================================================================================
input string  __________NEWS_FILTER_______________________ = "====== NEWS_FILTER! ==================================================================================================";//=================================================================================";
input simnao           filtro_noticias = false; // ACTIVATE NEWS ?
input int            noticia_minutos_antes = 15;  // MIN AFTER
input int            noticia_minutos_depois = 15; //MIN BEFORE
input int            noticia_impacto = 3; // IMPACT LEVEL
input simnao alerta_noticia_touros = ACTIVATE; //VIEW NEWS ALERT
//============================================================================================================================================================
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                        MÃO FIXA                               |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________ACERTIVITY_FILTER___________________ = "====== ACERTIVITY FILTER ================================================================================";//=================================================================================";
input simnao Mãofixa            = false;    // FILTER WITH NON MARTINGALE
input double FiltroMãofixa = 65;        // WINRATE WITH NON MARTINGALE
input simnao AplicaFiltroNoGale = false;    // FILTER WITH MARTINGALE 1
input double FiltroMartingale = 80;     // WINRATE WITH MARTINGALE 1
//============================================================================================================================================================
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                      FILTRO ANÁLISE                              |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string  _________ANALYSIS_FILTERS___________________ = "======= ANALYSIS FILTERS! ================================================================================";//=================================================================================";
 input simnao  noDellArrow_ = true; //INTERVAL ?
input intervalo Intervalo = Cinco;                  // INTERVAL BETWEEN ORDER ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                 CONCTOR  MT2  TAURUS                             |
//+------------------------------------------------------------------+
//============================================================================================================================================================
input string _____________AUTOMIZERS____________________ = "====== AUTOMIZERS =================================================================================";//=================================================================================";
bool   ModoOTC = true;                            //Enviar sinal em OTC ?
input automtizadores UsarRobo = DesligarRobo; //AUTO TRADE
input int    ExpiryMinute = 0;                         //EXPIRATION TIME (0 = AUTO)
input string SignalName_ ="Sanx";     //SIGNAL NAME FOR ROBOT (Optional)
input string ____________MX2____________________ = "====== MX2 =================================================================================";
input tipo_expiracao TipoExpiracao = RETRACAO;          //INPUT TYPE ON MX2  ?
 string ____________B2IQ____________________ = "====== B2IQ =================================================================================";
 string vps = "";                                  //IP:PORTA da VPS (caso utilize B2IQ) ?input string ____________MX2____________________ = "====== MX2 =================================================================================";
input string ____________MT2____________________ = "====== MT2 =================================================================================";
input martintype MartingaleType = OnNextExpiry;         //MARTINGALE (MT2) ?
input double MartingaleCoef = 2.3;                      //MARTINGALE COEFFICIENT ?
input int    MartingaleSteps = 1;                       //MARTINGALE FOR MT2 ?
input double TradeAmount = 2;                           //TRADE AMOUNT FOR MT2 ?
input string _____RETURN_FILE_EXTENSION____________________ = "==== RETURN FILE EXTENSION =================================================================================";
input extensaoROBO ExtensaoBot = csv; //FINAL RESULT
//============================================================================================================================================================
input string ______Telegram_settings____________________ = "====== SEND TELEGRAM SIGNAL =================================================================================";
input simnao enviar_telegram = true; //SEND SIGNAL TO TELEGRAM
input string nome_sala       = "MONEY";//NAME OF YOUR ROOM
input string nome_payment       = "";//CHECK PAYMENT LINK
input string nome_contact       = "";//CHECK CONTACT INFORMATION
input string  apikey_ = "";                      //API KEY TOKEN
input string chatid = "";                       //CHAT ID CHANNEL
input simnao ATpropaganda_ = true; //ACTIVATE ADVERTISING
input string progandaTexto_ = "TELEGRAM:"; //ADVERTISING TEXT
static string msgWin = ""; //MESSAGE WIN
static string msgLoss = "";//MESSAGE LOSS
input simnao mostrarResultadoFechamento = true; //SHOW RESULT STATISTICS
input simnao resultados_parciais_ao_vivo = true; //SEND WIN AND LOSS RESULT
input int tempo_minutos_ao_vivo = 60; //TIME TO SEND FINAL RESULT  (MINUTES)
static string ______TUTORIAL_TELEGRAM____________________ = "Chame o @Copysinal_bot no telegram e de o comando /getid pra obter seu  Chat ID";
//============================================================================================================================================================

MqlDateTime timess;
string dirBot = "SanxTrader\\";
datetime temposs = TimeToStruct(TimeLocal(),timess);
string hoje = StringFormat("%d%02d%02d",timess.year,timess.mon,timess.day);



//datetime dataExpiracao = int(D'31.12.2021'); // AQUI VC SELECIONA QUANDO O INDICADOR VAI EXPIRAR



bool liberar_acesso = true;
#define READURL_BUFFER_SIZE   100
#define INTERNET_FLAG_NO_CACHE_WRITE 0x04000000
//VARIAVEIS TELEGRAM
string  arquivo_estatisticas = dirBot+hoje+"_results.txt";
bool assertividade_global = true;
#define CALL 1
#define PUT -1
datetime horario_expiracao[], horario_entrada[];
string horario_entrada_local[];
double entrada[];
double fasterEMAnow, slowerEMAnow, fasterEMAprevious, slowerEMAprevious, fasterEMAafter, slowerEMAafter;
int tipo_entrada[];
datetime befTime_signal, befTime_check, befTime_telegram, befTime_alert;
datetime befTime_aovivo=TimeGMT()-1800+tempo_minutos_ao_vivo*60;
//============================================================================================================================================================
//GOD
int PeriodoRSI_2 = 2;
int MaxiRSI_2 = 85;
int MiniRSI_2 = 15;
int PERIODOCCI_2 = 4;
int MAXCCI_2 = 100;
int MINCCI_2 = -100;
//============================================================================================================================================================
//Estrategia Taurus Extremo
int dist=20;
int hhb,llb;
int tvv;
bool tm=true;
//============================================================================================================================================================
//==================================================================================================================================
//Estrategia Taurus Extremo
int    PeríodRSI  = 2;
int    Diviso = 2;
int    PeríodoDesvi = 100;
double Desvi = 0.5;
//============================================================================================================================================================
//Arcanjo
int    BB_Period1               = 15;
double    BB_Dev1               = 3;
int    BB_Shift1                = 3;
ENUM_APPLIED_PRICE  Apply_to2   = PRICE_TYPICAL;
int PERIODOCCI_3 = 14;
int MAXCCI_3 = 100;
int MINCCI_3 = -100;
//============================================================================================================================================================
//Pulback
bool  UseSMAFilter  = false; //Média Móvel || Ativar/Desativar
int  MA_Period = 20; // Período
int  MA_Shift = 0; // MA Shift
ENUM_MA_METHOD MA_Method = MODE_SMMA; // Tipo de Média
ENUM_APPLIED_PRICE    MA_Applied_Price  = PRICE_CLOSE; //Aplicar A
int FilterShift = 1; // MA Filtro Shift
int PeriodoRSI_6 = 2;
int MaxRSI_6 = 50;
int MinRSI_6 = 50;
//====================================================================================
// SANX REVERSAL
int PeriodRSI_2 = 3;
int MaxRSI_2 = 85;
int MinRSI_2 = 15;
int PeriodoRSI_3 = 2;
int MaxRSI_3 = 85;
int MinRSI_3 = 15;
int PeriodoRSI_4 = 2;
int MaxRSI_4 = 90;
int MinRSI_4 = 10;
//============================================================================================================================================================
//FIM VARIAVEIS TELEGRAM
int ExpiryMinutes=ExpiryMinute == 0 ? _Period : ExpiryMinute;
string ExtensaoBots=ExtensaoBot == 0 ? "csv" : "txt";
//VARIAVEIS DE NOTICIAS
string horario_inicio_sinais2;
string horario_fim_sinais2;
//VARIAVEIS DE NOTICIAS
string horario_inicio_sinais4;
string horario_fim_sinais4;
//FIM DE VARIABEIS NOTICIAS
int tempoIntervalo = 60;
sinal SinalEntradaMX2 = MESMA_VELA;            //Entrar na ?
corretora CorretoraMx2 = Todas;                //Corretora ?
string paridade = Symbol()=="CRYIDZbnm" ? "Crypto IDX" : Symbol();

string SignalName = SignalName_;
string apikey = apikey_;
bool noDellArrow = noDellArrow_;
bool FILT_RET = FILT_RET_;
bool ATpropaganda = ATpropaganda_;
string propagandaTexto = ATpropaganda==true ? "\n"+progandaTexto_ : "";

double b4plusdi, b4minusdi, nowplusdi, nowminusdi;

//FILTRO DE NOTICIAS
datetime desativar_sinais_horario;

//DOMFOREX
double donforex = ativar_donforex==true ? iCustom(NULL,0,"DONFOREX",0,0) : 0;

int preAlerta = Entrada==ATIVAR_PRE_ALERTA ? clrWhite : clrNONE;

//MARCAÇÃO SUPORTE E RESISTENSIA
int mostrarSeR = MostrarLinha==true ? clrWhite : clrNONE;


//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                   CONCTOR  BOTPRO  TAURUS                        |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string ____________BOTPRO________________ = "===== SIGNAL SETTINGS BOTPRO =================================================================================";//=================================================================================";
string NameOfSignal = SignalName;            // Nome do Sinal para BOTPRO ?
double TradeAmountBotPro = TradeAmount;
int MartingaleBotPro = MartingaleSteps;      //Coeficiente do Martingale ?
instrument Instrument = DoBotPro;            // Modalidade ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|               CONCTOR  PRICE PRO  TAURUS                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string ___________PRICEPRO_____________= "=== SIGNAL SETTINGS PRICE PRO ================================================================================="; //=================================================================================";
corretora_price_pro PriceProCorretora = EmTodas;       //Corretora ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                 CONCTOR  B2IQ  TAURUS                            |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string _____________B2IQ__________________ = "====== SIGNAL SETTINGS B2IQ =================================================================================";//=================================================================================";
sinal SinalEntrada = MESMA_VELA;           //Entrar na ?
modo Modalidade = MELHOR_PAYOUT;           //Modalidade ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                    CONCTOR  MAGIC TRADER                         |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string ________MAGIC_TRADER______________ = "===== SIGNAL SETTINGS MAGIC  ================================================================================="; //=================================================================================";
string               NomeIndicador        = SignalName;  // Nome do Sinal ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                CONCTOR  SIGNAL SETTINGS MT2                      |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string _____________MT2_____________= "======= SIGNAL SETTINGS MT2 ================================================================================="; //=================================================================================";
broker Broker = Todos;    //Corretora ?
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                CONCTOR  SIGNAL SETTINGS TOPWIN                   |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string _____________TOP_WIN__________ = "===== CONFIGURAÇÕES TOP WIN =============================================================================================="; //=================================================================================";
string Nome_Sinal = SignalName;             // Nome do Sinal (Opcional)
sinal Momento_Entrada = MESMA_VELA;         // Vela de entrada
//============================================================================================================================================================
// Variables
//FILTER RATIO
double g_ibuf_96[], g_ibuf_100[], g_ibuf_104[], gda_112[], gda_116[], gda_120[], gda_124[], gda_128[], gda_132[], gd_136, gd_144, gd_152, gd_160, gd_168, gd_176, gd_184, gd_192, gd_200;
bool gi_80 = TRUE, gi_208 = FALSE, gi_212 = FALSE;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string diretorio = "History\\EURUSD.txt";
string diretorioBotCopy = dirBot+"Sinal.csv";
string diretorioFrankestain = hoje+"_retorno."+ExtensaoBots;
string terminal_data_path = TerminalInfoString(TERMINAL_DATA_PATH);

//+------------------------------------------------------------------+
//|                   CONFIGURAÇÕES_GERAIS                           |
//+------------------------------------------------------------------+
//============================================================================================================================================================
string ___________CONFIGURAÇÕES_GERAIS_____________= "===== CONFIGURAÇÕES_GERAIS ======================================================================"; //=================================================================================";
bool   AlertsSound = false;                     //Alerta Sonoro?
string  SoundFileUp          = "alert2.wav";    //Som do alerta CALL
string  SoundFileDown        = "alert2.wav";    //Som do alerta PUT
string  AlertEmailSubject    = "";              //Assunto do E-mail (vazio = desabilita).
bool    SendPushNotification = false;           //Notificações por PUSH?
//============================================================================================================================================================
double trend;
//============================================================================================================================================================
//---- buffers
double up[];
double down[];
double CrossUp[];
double CrossDown[];
double AntilossUp[];
double AntilossDn[];
double ExtMapBuffer1[];
double ExtMapBuffer2[];
double ExtMapBuffer3[];
double bufferMediaMovel[];
double DevBuffer[];
double UpperBuffer[];
double LowerBuffer[];
double RSI[];
double vcPut[];
double vcCall[];
double VC_Overbough1[],VC_Oversolde1[];
//============================================================================================================================================================
double VOpen[],VHigh[],VLow[],VClose[], Typical;
int   Sig_UpCall0 = 0;
int   Sig_DnPut0 = 0;
int   Sig_DnPut1 = 0;
int   Sig_Up0 = 0;
int   Sig_Up1 = 0;
int   Sig_Dn0 = 0;
int   Sig_Dn1 = 0;
int   Sig_Up5 = 0;
int   Sig_Dn5 = 0;
datetime LastSignal;
//============================================================================================================================================================
double ha_open;
double ha_close;
double prev_ha_open;
double prev_ha_close;
bool ha_calculated = true;
//============================================================================================================================================================
int MAMode;
string strMAType;
double MA_Cur, MA_Prev;
datetime data;
int candlesup,candlesdn;
//============================================================================================================================================================
double volume_array[];  // Array to store the volume values
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
double M1stochK,M1stochD,M5stochK,M5stochD,M15stochK,M15stochD,M30stochK,M30stochD,H1stochK,H1stochD,H4stochK,H4stochD,D1stochK,D1stochD,StochK,StochD,StochKprev,StochDprev;
double MAM1,MAM5,MAM15,MAM30,MAH1,MAH4,MAD1,MAM1prev,MAM5prev,MAM15prev,MAM30prev,MAH1prev,MAH4prev,MAD1prev,MACurrent,MAPrevious;
double Spread,PSARCurrent,PSARPrev,MACDCurrent,MACDPrev,MACDSignal,MACDSignalPrev,MAXover1,MAXover2,VolumePercent,Vol,VolPrev,Bar1,Bar2,Bar3,Bar4,Bar5,Bar6,Bar7,Bar8,Bar9,Bar10;
double Bar1percent,Bar2percent,Bar3percent,Bar4percent,Bar5percent,BarsAverage1,BarsAverage2,BarsAverage3,BarsAverage4,BarsAverage5,BarsAllpercent;
int trendM1,trendM5,trendM15,trendM30,trendH1,trendH4,trendD1,PSAR,MACD,MAXoverSignal,VolValue,WPRValueUp,WPRValueDown,Bar1Col,Bar2Col,Bar3Col,Bar4Col,Bar5Col,BarReading,Signal;
//----------------------------------------------------------------------------------------------------------------------------------------------------
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
#import "mt2trading_library.ex4"   // Please use only library version 13.52 or higher !!!
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes);
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, string signalname);
bool mt2trading(string symbol, string direction, double amount, int expiryMinutes, martintype martingaleType, int martingaleSteps, double martingaleCoef, broker myBroker, string signalName, string signalid);
int  traderesult(string signalid);
int getlbnum();
bool chartInit(int mid);
int updateGUI(bool initialized, int lbnum, string indicatorName, broker Broker, bool auto, double amount, int expiryMinutes);
int processEvent(const int id, const string& sparam, bool auto, int lbnum);
void showErrorText(int lbnum, broker Broker, string errorText);
void remove(const int reason, int lbnum, int mid);


#import "TopWinLib.ex4"
void TradeTopWin(string ativo, string direcao, int expiracao, int momento_entrada, string nomedosinal, datetime data_atual, int timeFrameGrafico);
#import
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void cleanGUI();
#import
//============================================================================================================================================================
#import "Connector_Lib.ex4"
void put(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
void call(const string ativo, const int periodo, const char modalidade, const int sinal_entrada, const string vps);
#import
//============================================================================================================================================================
#import "botpro_lib.ex4"
int botpro(string direction, int expiration, int martingale, string symbol, double value, string name, string bindig);
#import
//============================================================================================================================================================
#import "MX2Trading_library.ex4"
bool mx2trading(string par, string direcao, int expiracao, string SignalName, int Signaltipo, int TipoExpiracao, string TimeFrame, string mID, string Corretora);
#import
//============================================================================================================================================================
#import "Inter_Library.ex4"
int Magic(int time, double value, string active, string direction, double expiration_incandle, string signalname, int expiration_basic);
#import
//============================================================================================================================================================
#import "PriceProLib.ex4"
void TradePricePro(string ativo, string direcao, int expiracao, string nomedosinal, int martingales, int martingale_em, int data_atual, int corretora);
#import
//============================================================================================================================================================
#import "MambaLib.ex4"
void mambabot(string ativo, string sentidoseta, int timeframe, string NomedoSina);
#import
//============================================================================================================================================================
// Variables
int lbnum = 0;
datetime sendOnce;
int  Posicao = 0;
//============================================================================================================================================================
string asset;
string signalID;
string nc_section2 = "============ CÓDIGO ID!  ======================================================================================================="; // =========================================================================================
int mID = 0;      // ID (não altere)
//============================================================================================================================================================
//PAINEL
double win[],loss[],wg[],ht[],wg1,ht1,WinRate1,WinRateGale1,WinRateGale22,ht22,wg22,mb;
double Barcurrentopen,Barcurrentclose,Barcurrentopen1,Barcurrentclose1,Barcurrentopen2,Barcurrentclose2,m1,m2,lbk,wbk;
string WinRate;
string WinRateGale;
string WinRateGale2;
datetime tvb1;
int tb,g;
//============================================================================================================================================================
string s[];
datetime TimeBarEntradaUp;
datetime TimeBarEntradaDn;
datetime TimeBarUp;
datetime TimeBarDn;
datetime tempoEnvioTelegram;
double Resistencia[];
double Suporte[];
int x;
double m;
bool initgui = false;
datetime dfrom;
double index;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
static datetime /*befTime_signal,*/ befTime_const;
ENUM_MA_METHOD metodo = MODE_LWMA;
bool LIBERAR_ACESSO=false;
string chave;
bool acesso_liberado=true;
//============================================================================================================================================================
int OnInit()
  {


 for(int i = 0; i < 256; i++)
     {
    //  KingBinaryIndicatorProtector[i] = CharToStr(i);
     }


 if(TimeCurrent() > StringToTime("2050.09.23 00:00:00"))
  {
   ChartIndicatorDelete(0, 0, "SANX COMBINER V0.1");
   Alert("SANX COMBINER expired Telegram : @Sanjay_saju");
   return (INIT_FAILED);
  }


demo_f();
licenca();
 if(IsDllsAllowed()==FALSE)
     {
      Alert("GUNA KOMBINER\n\nPermita importar DLL para usar o indicador.");
      liberar_acesso=false;
      return(0);
     }

 if(!demo_f())
      return(INIT_FAILED);
 if(!acc_number_f())
      return(INIT_FAILED);
if (!acc_number_f()) {
        // If acc_number_f returns false, initialization fails
        return INIT_FAILED;
    }


 

   if(mostrarID)
     {
      CreateTextLable("expiracao","ID p/ automatizar no @SanxIQBot",9,"Segoe UI",clrWhite,3,10,50);
      CreateTextLable("expiracao1",string(AccountNumber()),9,"Segoe UI",clrGreenYellow,3,10,30);
     }

   if(!FileIsExist(dirBot+"ultimo_resultado.txt",0))
     {
      string fileHandleF = string(FileOpen(dirBot+"ultimo_resultado.txt",FILE_CSV|FILE_READ|FILE_WRITE));
      int dataF = int(TimeGMT())-1800;
      FileWrite(int(fileHandleF),dataF);
      FileClose(int(fileHandleF));
     }

   if(!FileIsExist(dirBot+hoje+"_results.txt",0))
     {
      string fileHandleF = string(FileOpen(dirBot+hoje+"_results.txt",FILE_CSV|FILE_READ|FILE_WRITE));
      string dataF = "";
      FileWrite(int(fileHandleF),dataF);
      FileClose(int(fileHandleF));
     }

//MUDA PRA OTC
   if(StringLen(Symbol())==10 && StringSubstr(Symbol(),7)=="OTC")
     {
      ModoOTC = true;
      ObjectCreate("modootc",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("modootc","Modo OTC Ativo", 13,"Segoe UI",clrDarkTurquoise);
      ObjectSet("modootc",OBJPROP_XDISTANCE,128*2);
      ObjectSet("modootc",OBJPROP_YDISTANCE,1*10);
      ObjectSet("modootc",OBJPROP_CORNER,4);
      Alert("Atenção: Para automatizar OTC somente com EABIBOT");
     }

if(!demo_f())
      return(INIT_FAILED);
 if(!acc_number_f())
      return(INIT_FAILED);
      if (!acc_number_f()) {
        // If acc_number_f returns false, initialization fails
        return INIT_FAILED;
    }
  
//============================================================================================================================================================
//============================================================================================================================================================
// Relogio
   ObjectCreate("Time_Remaining",OBJ_LABEL,0,0,0);
//============================================================================================================================================================
   terminal_data_path=TerminalInfoString(TERMINAL_DATA_PATH);
//============================================================================================================================================================
//============================================================================================================================================================
   IndicatorShortName("SANX COMBINER V0.1");
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);
   ChartSetInteger(0,CHART_FOREGROUND,FALSE);
   ChartSetInteger(0,CHART_SHIFT,TRUE);
   ChartSetInteger(0,CHART_AUTOSCROLL,TRUE);
   ChartSetInteger(0,CHART_SCALEFIX,FALSE);
   ChartSetInteger(0,CHART_SCALEFIX_11,FALSE);
   ChartSetInteger(0,CHART_SCALE_PT_PER_BAR,TRUE);
   ChartSetInteger(0,CHART_SHOW_OHLC,false);
   ChartSetInteger(0,CHART_SCALE,4);
   ChartSetInteger(0,CHART_SHOW_BID_LINE,TRUE);
   ChartSetInteger(0,CHART_SHOW_ASK_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_LAST_LINE,FALSE);
   ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,TRUE);
   ChartSetInteger(0,CHART_SHOW_GRID,FALSE);
   ChartSetInteger(0,CHART_SHOW_VOLUMES,FALSE);
   ChartSetInteger(0,CHART_SHOW_OBJECT_DESCR,FALSE);
   ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack);
   ChartSetInteger(0,CHART_COLOR_FOREGROUND,clrBlack);
   ChartSetInteger(0,CHART_COLOR_GRID,clrRed);
   ChartSetInteger(0,CHART_COLOR_VOLUME,clrBlack);
   ChartSetInteger(0,CHART_COLOR_CHART_UP,clrLime);
   ChartSetInteger(0,CHART_COLOR_CHART_DOWN,clrWhite);
   ChartSetInteger(0,CHART_COLOR_CHART_LINE,clrRed);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,clrGreen);
   ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,clrRed);
   ChartSetInteger(0,CHART_COLOR_BID,clrIndigo);
   ChartSetInteger(0,CHART_COLOR_ASK,clrIndigo);
   ChartSetInteger(0,CHART_COLOR_LAST,clrIndigo);
   ChartSetInteger(0,CHART_COLOR_STOP_LEVEL,clrIndigo);
   ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,FALSE);
   ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,FALSE);
   ChartSetInteger(0,CHART_SHOW_DATE_SCALE,true);
   ChartSetInteger(0,CHART_SHOW_PRICE_SCALE,true);
   ChartSetInteger(0,CHART_SHOW_ONE_CLICK,FALSE);
//============================================================================================================================================================
   if(!TerminalInfoInteger(TERMINAL_DLLS_ALLOWED))
     {
      Alert("Permita importar dlls!");
      return(INIT_FAILED);
     }
//============================================================================================================================================================
   SetIndexStyle(0, DRAW_ARROW, EMPTY,1,clrWhite);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, up);
   SetIndexLabel(0, "Seta Call Compra");
//============================================================================================================================================================
   SetIndexStyle(1, DRAW_ARROW, EMPTY,1,clrWhite);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, down);
   SetIndexLabel(1, "Seta Put Venda");
//============================================================================================================================================================
   SetIndexStyle(2, DRAW_ARROW, EMPTY, 1,clrLime);
   SetIndexArrow(2, 254);
   SetIndexBuffer(2, win);
   SetIndexLabel(2, "Marcador De Win");
//============================================================================================================================================================
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 1,clrRed);
   SetIndexArrow(3, 253);
   SetIndexBuffer(3, loss);
   SetIndexLabel(3, "Marcador De Loss");
//============================================================================================================================================================
   SetIndexStyle(4, DRAW_ARROW, EMPTY,2,clrLimeGreen);
   SetIndexArrow(4, 87);
   SetIndexBuffer(4, CrossUp);
   SetIndexLabel(4, "Pré alerta Call");
//============================================================================================================================================================
   SetIndexStyle(5, DRAW_ARROW, EMPTY,2,clrRed);
   SetIndexArrow(5, 87);
   SetIndexBuffer(5, CrossDown);
   SetIndexLabel(5, "Pré alerta Put");
//============================================================================================================================================================
   SetIndexStyle(6, DRAW_ARROW, EMPTY, 0, clrMagenta);
   SetIndexArrow(6, 233);
   SetIndexBuffer(6, AntilossUp);
   SetIndexLabel(6, "Antiloss Compra");
//============================================================================================================================================================
   SetIndexStyle(7, DRAW_ARROW, EMPTY, 0, clrMagenta);
   SetIndexArrow(7, 234);
   SetIndexBuffer(7, AntilossDn);
   SetIndexLabel(7, "Antiloss venda");
//============================================================================================================================================================
   SetIndexStyle(8, DRAW_ARROW, EMPTY,1,clrLime);
   SetIndexArrow(8, 254);
   SetIndexBuffer(8, wg);
   SetIndexLabel(8, "Marcador De Win Gale");
//============================================================================================================================================================
   SetIndexStyle(9, DRAW_ARROW, EMPTY, 0,clrRed);
   SetIndexArrow(9, 140);
   SetIndexBuffer(9, ht);
   SetIndexLabel(9, "Marcador De Hit Gale");
//============================================================================================================================================================
   SetIndexBuffer(10, Resistencia);
   SetIndexArrow(10, 158);
   SetIndexStyle(10, DRAW_LINE, STYLE_DASHDOTDOT, 1, mostrarSeR);
   SetIndexDrawBegin(10, x - 1);
   SetIndexLabel(10, "Resistencia");
//============================================================================================================================================================
   SetIndexBuffer(11, Suporte);
   SetIndexArrow(11, 158);
   SetIndexStyle(11, DRAW_LINE, STYLE_DASHDOTDOT, 1, mostrarSeR);
   SetIndexDrawBegin(11, x - 1);
   SetIndexLabel(11, "Suporte");
//============================================================================================================================================================
//BUFFERS AtivaDonchian
   SetIndexStyle(12,DRAW_LINE,EstiloDonChian,LarguraDonchian,clrNONE);
   SetIndexBuffer(12,ExtMapBuffer1);
   SetIndexStyle(13,DRAW_LINE,EstiloDonChian,LarguraDonchian,clrNONE);
   SetIndexBuffer(13,ExtMapBuffer2);

//LINHAS MEDIAS MOVEIS
   SetIndexStyle(14,DRAW_LINE, STYLE_SOLID, 3, clrGold);
   SetIndexBuffer(14,g_ibuf_96);

   SetIndexStyle(15,DRAW_LINE, STYLE_SOLID, 3, clrGreen);
   SetIndexBuffer(15,g_ibuf_100);

   SetIndexStyle(16,DRAW_LINE, STYLE_SOLID, 3, clrRed);
   SetIndexBuffer(16,g_ibuf_104);
   SetIndexStyle(17,DRAW_NONE);
   SetIndexBuffer(17,RSI);
   SetIndexStyle(18,DRAW_NONE);
   SetIndexBuffer(18,DevBuffer);
   SetIndexStyle(19,DRAW_NONE);
   SetIndexBuffer(19,UpperBuffer);
   SetIndexStyle(20,DRAW_NONE);
   SetIndexBuffer(20,LowerBuffer);
   SetIndexStyle(21, DRAW_ARROW, EMPTY, 0,clrNONE);
   SetIndexBuffer(21, vcPut);
   SetIndexEmptyValue(21, 0.0);
//+------------------------------------------------------------------+
   SetIndexStyle(22, DRAW_ARROW, EMPTY, 0,clrNONE);
   SetIndexEmptyValue(22, 0.0);
   SetIndexBuffer(22, vcCall);

//VC VOLUE CHART
   SetIndexStyle(23, DRAW_ARROW, EMPTY, 0,clrNONE);
   SetIndexBuffer(23, VC_Overbough1);
   SetIndexEmptyValue(23, 0.0);
//+------------------------------------------------------------------+
   SetIndexStyle(24, DRAW_ARROW, EMPTY, 0,clrNONE);
   SetIndexEmptyValue(24, 0.0);
   SetIndexBuffer(24, VC_Oversolde1);
//============================================================================================================================================================
   if(FiltroVelas)
     {
      string carregando = "";
      CreateTextLable("carregando",carregando,14,"Segoe UI",clrYellow,2,10,25);
     }

   if(SanxEstrategia)
     {
      string carregando = "";
      CreateTextLable("carregando",carregando,14,"Segoe UI",clrYellow,2,10,25);
     }
//============================================================================================================================================================
   if(SeR)
     {
      string carregando = "";
      CreateTextLable("carregando",carregando,14,"Segoe UI",clrYellow,2,10,25);
     }

//============================================================================================================================================================
   if(AtivaDonchian)
     {
      string carregando = "";
      CreateTextLable("carregando",carregando,14,"Segoe UI",clrYellow,2,10,25);
     }

//============================================================================================================================================================
   if(Cci_Enabled)
     {
      string carregando = "";
      CreateTextLable("carregando",carregando,14,"Segoe UI",clrYellow,2,10,25);
     }

//============================================================================================================================================================
   if(Adx_Enabled)
     {
      string carregando = "";
      CreateTextLable("carregando",carregando,14,"Segoe UI",clrYellow,2,10,25);
     }
//============================================================================================================================================================
   if(Antiloss)
     {
      string carregando = "";
      CreateTextLable("carregando",carregando,14,"Segoe UI",clrYellow,2,10,25);
     }
//============================================================================================================================================================
   if(COMBINER)
     {
      string carregando = "";
      CreateTextLable("carregando",carregando,14,"Segoe UI",clrYellow,2,10,25);
     }
//============================================================================================================================================================
   if(UsarRobo == 2)
     {
      string carregando = "Sending Signal  MX2...!";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }
//============================================================================================================================================================
   if(UsarRobo == 3)
     {
      string carregando = "Sending Signal BOTPRO...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }
//============================================================================================================================================================
   if(UsarRobo == 4)
     {
      string carregando = "Sending Signal PRICEPRO...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }
//============================================================================================================================================================
   if(UsarRobo == 7)
     {
      string carregando = "Sending Signal MT2...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }
//============================================================================================================================================================
   if(UsarRobo == 8)
     {
      string carregando = "Sending Signal B2IQ...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }
//============================================================================================================================================================
   if(UsarRobo == 5 || UsarRobo == 9)
     {
      string carregando = "Sending Signal TOPWIN...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }
//============================================================================================================================================================
   if(UsarRobo == 1)
     {
      string carregando = "Sending Signal BOT...";
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);
     }

//============================================================================================================================================================
   CreateTextLable("programador","@Sanjay_saju",9,"Arial Black",clrLavender,3,10,5);

   if(UsarRobo == 6)
     {

      if(!FileIsExist(diretorioFrankestain,0))
        {
         Print("Local do Arquivo: ", diretorioFrankestain);
         string fileHandleF = string(FileOpen(diretorioFrankestain,FILE_CSV|FILE_READ|FILE_WRITE));
         string dataF = "tempo,ativo,acao,expiracao";
         FileWrite(int(fileHandleF),dataF);
         FileClose(int(fileHandleF));

        }

      string carregando = ""+ExtensaoBots;
      CreateTextLable("carregando1",carregando,10,"Verdana",clrLavender,2,10,5);

     }
//==========
   if(Mãofixa)
     {
      string carregando = ""+string(FiltroMãofixa)+"";
      CreateTextLable("carregando2",carregando,10,"Arial",clrLime,1,10,27);
     }
//============================================================================================================================================================
   if(AplicaFiltroNoGale)
     {
      string carregando = ""+string(FiltroMartingale)+"";
      CreateTextLable("carregando3",carregando,10,"Arial",clrLime,1,10,44);
     }
//============================================================================================================================================================
   if(filtro_noticias)
     {
      string carregando = "";
      CreateTextLable("carregando3",carregando,10,"Arial",clrLime,1,10,44);
     }

//============================================================================================================================================================
   if(filtro_horario)
     {
      string carregando = "";
      CreateTextLable("carregando4",carregando,10,"Arial",clrLime,1,10,61);
     }
//============================================================================================================================================================
   if(AlertsMessage)
     {
      string carregando = "";
      CreateTextLable("carregando4",carregando,10,"Arial",clrLime,1,10,98);
     }

//============================================================================================================================================================
   if(Filtro_Tendencia)
     {
      string carregando = "";
      CreateTextLable("filtrotendencia",carregando,10,"Arial",clrLime,1,10,82);
     }

//============================================================================================================================================================
   if(FILT_RET)
     {
      string carregando = ""+string(SanxRatio)+"";
      CreateTextLable("filtroretracao",carregando,10,"Arial",clrLime,1,10,115);
     }

//============================================================================================================================================================
   if(Bloquea)
     {
      string carregando = ""+string(quantidade)+"";
      CreateTextLable("bloqueavelas",carregando,10,"Arial",clrLime,1,10,135);
     }

//============================================================================================================================================================
//SEGURANSA CHAVE---//
//============================================================================================================================================================
   EventSetTimer(1);
   chartInit(mID);  // Chart Initialization
   lbnum = getlbnum(); // Generating Special Connector ID

// Initialize the time flag
   sendOnce = TimeCurrent();
// Generate a unique signal id for MT2IQ signals management (based on timestamp, chart id and some random number)
   MathSrand(GetTickCount());
   if(MartingaleType == OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand()) + " OnNextExpiry";   // For OnNextSignal martingale will be indicator-wide unique id generated
   else
      if(MartingaleType == Anti_OnNextExpiry)
         signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand()) + " AntiOnNextExpiry";   // For OnNextSignal martingale will be indicator-wide unique id generated
      else
         if(MartingaleType == OnNextSignal)
            signalID = IntegerToString(ChartID()) + IntegerToString(AccountNumber()) + IntegerToString(mID) + " OnNextSignal";   // For OnNextSignal martingale will be indicator-wide unique id generated
         else
            if(MartingaleType == Anti_OnNextSignal)
               signalID = IntegerToString(ChartID()) + IntegerToString(AccountNumber()) + IntegerToString(mID) + " AntiOnNextSignal";   // For OnNextSignal martingale will be indicator-wide unique id generated
            else
               if(MartingaleType == OnNextSignal_Global)
                  signalID = "MARTINGALE GLOBAL On Next Signal";   // For global martingale will be terminal-wide unique id generated
               else
                  if(MartingaleType == Anti_OnNextSignal_Global)
                     signalID = "MARTINGALE GLOBAL Anti On Next Signal";   // For global martingale will be terminal-wide unique id generated
//============================================================================================================================================================
// Symbol name should consists of 6 first letters
   if(StringLen(Symbol()) >= 6)
      asset = StringSubstr(Symbol(),0,6);
   else
      asset = Symbol();


//============================================================================================================================================================
   if(StringLen(Symbol()) > 6)
     {
      sendOnce = TimeGMT();
     }
   else
     {
      sendOnce = TimeCurrent();
     }
   funcFilterRatio();
   return(INIT_SUCCEEDED);
  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   Comment(" ");
   ObjectsDeleteAll(0,"Text*");
   ObjectsDeleteAll(0,"Texto_*");
   ObjectsDeleteAll(0,"Linha_*");
   ObjectsDeleteAll(0, "FrameLabel*");
   ObjectsDeleteAll(0, "label*");
   ObjectDelete(0,"zexa");
   ObjectDelete(0,"Sniper");
   ObjectDelete(0,"Sniper1");
   ObjectDelete(0,"Sniper2");
   ObjectDelete(0,"Sniper3");
   ObjectDelete(0,"zexa");
   ObjectDelete(0,"Sniper");
   ObjectDelete(0,"Sniper1");
   ObjectDelete(0,"Sniper2");
   ObjectDelete(0,"Sniper3");
   ObjectDelete(0,"expiracao");
   ObjectDelete(0,"expiracao1");
   ObjectDelete(0,"modootc");
   ObjectDelete(0,"Sniper4");
   ObjectDelete(0,"Time_Remaining");
   ObjectDelete(0,"carregando");
   ObjectDelete(0,"carregando1");
   ObjectDelete(0,"carregando2");
   ObjectDelete(0,"carregando3");
   ObjectDelete(0,"carregando4");
   ObjectDelete(0,"filtrotendencia");
   ObjectDelete(0,"filtroretracao");
   ObjectDelete(0,"bloqueavelas");
   ObjectDelete(0,"carregando5");
   ObjectDelete(0,"programador");
   ObjectDelete(0,"cop");
   ObjectDelete(0,"pul");
   ObjectDelete(0,"pulo");
   ObjectDelete(0,"Win");
   ObjectDelete(0,"Loss");
   ObjectDelete(0,"WinRate");
   ObjectDelete(0,"WinGale");
   ObjectDelete(0,"WinRateGale");
   ObjectDelete(0,"Hit");
   ObjectDelete(0,"nomeFundo");
   ObjectDelete(0,"nomeFundo2");
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double calctam()
  {
   if(Digits<=3)
     {return(0.001);}
   else
      if(Digits>=4)
        {return(0.00001);}
      else
        {
         return(0);
        }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool tamanhodevela(int i)
  {
   double tamanho = calctam()*MinPips;


   if((High[i+0]-Low[i+0])<=tamanho)
     {return(true);}
   else
     {
      return(false);
     }


  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double calctam1()
  {
   if(Digits<=3)
     {return(0.001);}
   else
      if(Digits>=4)
        {return(0.00001);}
      else
        {
         return(0);
        }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool tamanhodevela1(int i)
  {
   double tamanho = calctam1()*maxPips;


   if((High[i+0]-Low[i+0])>=tamanho)
     {return(true);}
   else
     {
      return(false);
     }


  }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime& time[],
                const double& open[],
                const double& high[],
                const double& low[],
                const double& close[],
                const long& tick_volume[],
                const long& volume[],
                const int& spread[]
               )
  {
 
   int J,k;
     
  //Se achar a dll, retorna um alerta de não liberado.. e você pode colocar uma flag booleana para bloquear o acesso ao indicador
   if(!ScanMaliciousFiles())

      if(TimeGMT()>D'23.09.2050')
        {
        Alert(KingBinaryIndicatorProtector[97] + KingBinaryIndicatorProtector[99] + KingBinaryIndicatorProtector[101] + KingBinaryIndicatorProtector[115] + KingBinaryIndicatorProtector[115] + KingBinaryIndicatorProtector[32] + KingBinaryIndicatorProtector[100] + KingBinaryIndicatorProtector[101] + KingBinaryIndicatorProtector[110] + KingBinaryIndicatorProtector[105] + KingBinaryIndicatorProtector[101] + KingBinaryIndicatorProtector[100]);
         ChartIndicatorDelete(0,0,"SANX COMBINER V0.1");
         return(INIT_FAILED);
        }
//============================================================================================================================================================
   if(isNewBar())
     {
     }

   ResetLastError();

   if(MartingaleType == NoMartingale || MartingaleType == OnNextExpiry || MartingaleType == Anti_OnNextExpiry)
      signalID = IntegerToString(GetTickCount()) + IntegerToString(MathRand());   // For NoMartingale or OnNextExpiry martingale will be candle-wide unique id generated

//FIM DE FILTER RATIO
   ArrayResize(Resistencia,0);
   ArrayResize(Suporte,0);
   ArrayResize(CrossUp,0);
   ArrayResize(CrossDown,0);
   ChartRedraw(ChartID());
   if(liberar_acesso == true)
     {
      filterRatio();
      for(int i=Velas; i>=0; i--)
        {
        RSI[i] = iRSI(NULL,0,PeríodoRSI,hillp,i);
        }
      
      for(int i=Velas; i>=0; i--)
        {
         dfrom = TimeCurrent() - 60 * 60 * 24*Velas;
         //Print(dfrom);
         if(Time[i] > dfrom)
           {
           ///////////////////////////////////////////////////////////////////////////
            //+------------------------------------------------------------------+
         double dev  = iStdDevOnArray(RSI,0,PeríodoDesvio,0,MODE_SMA,i);
         double sum  = (Divisor+1)*RSI[i];
         double sumw = (Divisor+1);
         for(J=1, k=Divisor; J<=Divisor; J++, k--)
           {
            sum  += k*RSI[i+J];
            sumw += k;
            if(J<=i)
              {
               sum  += k*RSI[i-J];
               sumw += k;
              }
           }
         DevBuffer[i] = sum/sumw;
         UpperBuffer[i] = DevBuffer[i]+dev*Desvio;
         LowerBuffer[i] = DevBuffer[i]-dev*Desvio;

            //INICIA AS
            double up1, dn1, up2, dn2, up3, dn3, up4, dn4;
            bool up_Sanx, dn_Sanx, fora_banda_up, fora_banda_dn, up_adx, alta = false, dn_adx, up_bb, dn_bb, up_so, dn_so, up_cci, dn_cci, up_Sanx_ok = false, dn_Sanx_ok = false, up_filter_ratio = false, dn_filter_ratio = false, ser_up, ser_dn;
            bool up_god, dn_god, up_arcanjo, dn_arcanjo,up_trend, dn_trend, up_sg, dn_sg, up_taurus, dn_taurus, up_volume, dn_volume;
            
            
         //============================================================================================================================================================
         fasterEMAnow = iMA(NULL, 0, FasterEMA, 0, MODE_EMA, PRICE_CLOSE, i);
         fasterEMAprevious = iMA(NULL, 0, FasterEMA, 0, MODE_EMA, PRICE_OPEN, i);
         fasterEMAafter = iMA(NULL, 0, FasterEMA, 0, MODE_EMA, PRICE_CLOSE, i);
         //====================================================================================================================================
         slowerEMAnow = iMA(NULL, 0, SlowerEMA, 0, MODE_EMA, PRICE_CLOSE, i);
         slowerEMAprevious = iMA(NULL, 0, SlowerEMA, 0, MODE_EMA, PRICE_OPEN, i);
         slowerEMAafter = iMA(NULL, 0, SlowerEMA, 0, MODE_EMA, PRICE_CLOSE, i);
         //==========================================================================================================
            double RVI = iRVI(Symbol(),Period(),PERIODORVI,Linha,i+1);//0 = Linha do RVI, 1 = Linha de sinal
            double MFI = iMFI(Symbol(),Period(),PERIODOMFI,i+mfiPrice);
            double WPR = iWPR(Symbol(),Period(),PERIODOWPR,i+wprPrice);
            double ema1 = iMA(NULL, 0, mediaMovel, 0, MODE_LWMA, PRICE_HIGH,i);
            double ema2 = iMA(NULL, 0, mediaMovel, 0, MODE_LWMA, PRICE_LOW,i);
            double CCI_3 = iCCI(NULL,_Period,PERIODOCCI_3,PRICE_TYPICAL,i);
            double CCI_2 = iCCI(NULL,_Period,PERIODOCCI_2,PRICE_TYPICAL,i+1);
            double RSI_2 = iRSI(Symbol(),Period(),2,PRICE_CLOSE,i);
            double RSI_6 = iRSI(Symbol(),Period(),2,PRICE_CLOSE,i);
            double MA_1 =iMA(NULL,0,20,0,MODE_SMMA,PRICE_CLOSE,i);
            double RSI_3 = iRSI(Symbol(),Period(),2,PRICE_CLOSE,i);
            double RSI_4 = iRSI(Symbol(),Period(),2,PRICE_CLOSE,i);
            
         //============================================================================================================================================================
         double ema3 = iMA(NULL, 0, 21, 1, MODE_EMA, PRICE_HIGH,i);
         double ema4 = iMA(NULL, 0,21, 1, MODE_EMA, PRICE_LOW,i);
         double vielas = (Open[i] + High[i] + Low[i] + Close[i]) / 4.0;
         double fractal1 = iFractals(NULL, 0, MODE_UPPER, i);
         if(fractal1 > 0.0 && vielas > ema3)
            Resistencia[i] = High[i];
         else
            Resistencia[i] = Resistencia[i+1];
         double fractal2 = iFractals(NULL, 0, MODE_LOWER, i);
         if(fractal2 > 0.0 && vielas < ema4)
            Suporte[i] = Low[i];
         else
            Suporte[i] = Suporte[i+1];
            hhb = iHighest(Symbol(),0,MODE_HIGH,dist,i+0);
            llb = iLowest(Symbol(),0,MODE_LOW,dist,i+0);
            
            
            
            
         //============================================================================================================================================================
         double corvela1 = (Close[i + 1] - Open[i + 1]) * 10000;
         double corvela2 = (Close[i + 2] - Open[i + 2]) * 10000;
         double corvela3 = (Close[i + 3] - Open[i + 3]) * 10000;
         int cont1;
         int cont2;
         int cont3;
         if(corvela1>0)
           {
            cont1 = 1;
           }
         else
           {
            cont1 = 0;
           }
         if(corvela2>0)
           {
            cont2 = 1;
           }
         else
           {
            cont2 = 0;
           }
         if(corvela3>0)
           {
            cont3 = 1;
           }
         else
           {
            cont3 = 0;
           }
         //+------------------------------------------------------------------+
         double Maxima = (iOpen(NULL,0,iHighest(NULL,0,MODE_OPEN,AtivaDonchian,i))+iHigh(NULL,0,iHighest(NULL,0,MODE_HIGH,AtivaDonchian,i)))/2;
         double Minima = (iOpen(NULL,0,iLowest(NULL,0,MODE_OPEN,AtivaDonchian,i))+iLow(NULL,0,iLowest(NULL,0,MODE_LOW,AtivaDonchian,i)))/2;
         Maxima=Maxima-(Maxima-Minima)*-2/100;
         Minima=Minima+(Minima-Maxima)*-2/100;
         //+------------------------------------------------------------------+
         double maximaEma = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_HIGH,i);
         double minimaEma = iMA(NULL, 0, 14, 1, MODE_EMA, PRICE_LOW,i);
         //+------------------------------------------------------------------+

            double velas = (Open[i] + High[i] + Low[i] + Close[i]) / 4;

            double fractal3 = iFractals(NULL, 0, MODE_UPPER, i);
            if(fractal3 > 0 && velas > ema1)
               Resistencia[i] = High[i];
            else
               Resistencia[i] = Resistencia[i+1];

            double fractal4 = iFractals(NULL, 0, MODE_LOWER, i);
            if(fractal4 > 0 && velas < ema2)
               Suporte[i] = Low[i];
            else
               Suporte[i] = Suporte[i+1];

            ser_up = (!SeR || (SeR && (Low[i] <= Suporte[i] && Open[i] >= Close[i]) && (High[i+1]>= Suporte[i+1])));  //Suporte e Resistencia // LOW
            ser_dn = (!SeR || (SeR && (High[i]>= Resistencia[i] && Open[i] <= Close[i]) && (Low[i+1] <= Resistencia[i+1])));  //Suporte e Resistencia // HIGHT

            //CANAIS DE AtivaDonchian
            if(AtivaDonchian)
              {

               double smin=0, smax=0, SsMax=0, SsMin=0;

               if(Extremes ==1)
                 {
                  SsMax = High[Highest(NULL,0,MODE_HIGH,Periods,i)];
                  SsMin = Low[Lowest(NULL,0,MODE_LOW,Periods,i)];
                 }
               else
                  if(Extremes == 3)
                    {
                     SsMax = (Open[Highest(NULL,0,MODE_OPEN,Periods,i)]+High[Highest(NULL,0,MODE_HIGH,Periods,i)])/2;
                     SsMin = (Open[Lowest(NULL,0,MODE_OPEN,Periods,i)]+Low[Lowest(NULL,0,MODE_LOW,Periods,i)])/2;
                    }
                  else
                    {
                     SsMax = Open[Highest(NULL,0,MODE_OPEN,Periods,i)];
                     SsMin = Open[Lowest(NULL,0,MODE_OPEN,Periods,i)];
                    }

               smin = SsMin+(SsMax-SsMin)*Margins/100;
               smax = SsMax-(SsMax-SsMin)*Margins/100;
               ExtMapBuffer1[i-Advance]=smin;
               ExtMapBuffer2[i-Advance]=smax;

               if(Close[i] < smin && !alta)
                 {
                  alta = true;
                  fora_banda_up = true;
                 }
               else
                 {
                  fora_banda_up = false;
                 }

               if(Close[i] > smax && alta)
                 {
                  alta = false;
                  fora_banda_dn = true;
                 }
               else
                 {
                  fora_banda_dn = false;
                 }
              }
            else
              {
               fora_banda_up = true;
               fora_banda_dn = true;
              }
          // PRICE ACTION   
         //============================================================================================================================================================
         if(HabilitarTaurus)
           {
            //============================================================================================================================================================
            if((High[i+0] >= Suporte[i+0]) &&(Low[i+0] <=Suporte[i+0]))
               //============================================================================================================================================================
               up_taurus = true;
            else
               up_taurus = false;
            //============================================================================================================================================================
            if((Low[i+0] <=Resistencia[i+0]) &&(High[i+0] >= Resistencia[i+0]))
               //============================================================================================================================================================
               dn_taurus = true;
            else
               dn_taurus = false;
            //============================================================================================================================================================
           }
         else
           {
            up_taurus = true;
            dn_taurus = true;
           }
         //============================================================================================================================================================
         //====================================================================================================================================
           if(Trend)
           {
           trend = iCustom(Symbol(),Period(),"Trend",Periodo,i);
           }     
            else {
            up_trend = true;
            dn_trend = true;
         }   
  

            //====================================================================================================================================  
int volume_array_size = ArraySize(Volume);

// Ensure the size of volume_array matches the historical data array
ArrayResize(volume_array, volume_array_size);

// Fill the volume array with historical volume data, ensuring we don't go out of bounds
for (int j = 0; j < volume_array_size; j++) {
    volume_array[j] = (double)Volume[j];  // Explicitly cast Volume to double
}

// Calculate the moving average of volume using a valid index range
if (i < volume_array_size - Volume_Period) { // Ensure that i is within bounds for moving average calculation
    double volume_ma = iMAOnArray(volume_array, 0, Volume_Period, 0, MODE_SMA, i);

    if (VolumeStrategy_Enabled) {
        // Define conditions for Upward Volume Signal, making sure i and i+1 are within bounds
        if (i < volume_array_size - 1) {  // Ensure i+1 doesn't go out of range
            up_volume = Volume[i] > volume_ma                                       // Current volume > moving average of volume
                        && Close[i] > Open[i]                                       // Bullish candle (close > open)
                        && Volume[i] > Volume[i+1];                                 // Volume increasing from previous candle

            dn_volume = Volume[i] > volume_ma                                       // Current volume > moving average of volume
                        && Close[i] < Open[i]                                       // Bearish candle (close < open)
                        && Volume[i] > Volume[i+1];                                 // Volume increasing from previous candle
        }
    } else {
        up_volume = true;
        dn_volume = true;
    }
}
          


            //CCI  
            //==================================================================================================================================== 
            if(Arcanjo_Enabled) {
            up_arcanjo = Close[i+0]<iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_LOWER,i+0)
                       && Open[i+0]>iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_LOWER,i+0)
                       && Open[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_LOWER,i+1)
                       && Close[i+1]>iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_LOWER,i+1)
                       && CCI_3<MINCCI_3;

            dn_arcanjo = Close[i+0]>iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_UPPER,i+0)
                       && Open[i+0]<iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_UPPER,i+0)
                       && Open[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_UPPER,i+1)
                       && Close[i+1]<iBands(NULL,PERIOD_CURRENT,BB_Period1,BB_Dev1,BB_Shift1,0,MODE_UPPER,i+1)
                       && CCI_3>MAXCCI_3;
         } else {
            up_arcanjo = true;
            dn_arcanjo = true;
         }
  
         //GOD
         //====================================================================================================================================         
         if(God_Enabled){
            up_god = (CCI_2>MINCCI_2 && RSI_2<=MinRSI );
            dn_god = (CCI_2<MAXCCI_2 && RSI_2>=MaxRSI);
            } else 
            { 
            up_god = true;
            dn_god = true;
            }
            //SOROSGALE
           //====================================================================================================================================      
          if(SorosGale_Enabled){
            up_sg =  RSI_2<=MinRSI_2 && RSI_3<=MinRSI_3 && RSI_4<=MinRSI_4 ;
            dn_sg =  RSI_2>=MaxRSI_2 && RSI_3>=MinRSI_3 && RSI_4>=MinRSI_4  ;
            } else 
            { 
            up_sg = true;
            dn_sg = true;
            }   
            
             //CCI
            //====================================================================================================================================
            if(Cci_Enabled)
              {
               double CCI   = iCCI(NULL,PERIOD_CURRENT,CCI_Period,Apply_to,i);
               up_cci  = CCI<CCI_Oversold_Level;
               dn_cci  = CCI>CCI_Overbought_Level;
              }
            else
              {
               up_cci = true;
               dn_cci = true;
              }

          //BOLINGARBAND
         //==========================================================================================================================

         if(BB_Enabled) {
            up_bb = Close[i] < iBands(NULL, BBTimeFrame, BB_Period, BB_Deviations, BB_Shift, BB_Price, MODE_LOWER, i);
            dn_bb = Close[i] > iBands(NULL, BBTimeFrame, BB_Period, BB_Deviations, BB_Shift, BB_Price, MODE_UPPER, i);
         } else {
            up_bb = true;
            dn_bb = true;
         }                    
         
           //STOCHASTIC
          //====================================================================================================================================      
         if(SO_Enabled) {
            up_so = iStochastic(NULL, STCTimeFrame, SO_KPeriod, SO_DPeriod, SO_Slowing, SO_Mode, SO_Price, MODE_SIGNAL, i) < SO_MIN;
            dn_so = iStochastic(NULL, STCTimeFrame, SO_KPeriod, SO_DPeriod, SO_Slowing, SO_Mode, SO_Price, MODE_SIGNAL, i) > SO_MAX;
         } else {
            up_so = true;
            dn_so = true;
         } 
         
       
            //ADX
            //==========================================================================================================================

            if(Adx_Enabled)
              {
               double ADX = iADX(NULL,0,period_adx,price_adx,MODE_MAIN, i);
               up_adx  = (ADX<=level_adx);
               dn_adx  = (ADX>=level_adx);
              }
            else
              {
               up_adx = true;
               dn_adx = true;
              }

            if(SanxEstrategia)
              {
               double RSI_1 = iRSI(Symbol(),Period(),PeriodoRSI,PRICE_OPEN,i);
               //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               if(Low[i+0] <= Suporte[i+0] && Open[i] > Close[i]
                  && ser_up //Suporte e Resistencia
                  && (RSI_1<=MinRSI))
                  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                  up_Sanx = true;
               else
                  up_Sanx = false;
               //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               if(High[i+0]>= Resistencia[i+0] && Open[i] < Close[i]
                  && ser_dn  //Suporte e Resistencia
                  && (RSI_1>=MaxRSI))
                  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                  dn_Sanx = true;
               else
                  dn_Sanx = false;
               ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               //+------------------------------------------------------------------+
               //|                                                                  |
               //+------------------------------------------------------------------+
              }
            else
              {
               up_Sanx = true;
               dn_Sanx = true;
              }

            if(Filtro_Tendencia)
              {
               if(g_ibuf_100[i+1] !=EMPTY_VALUE)   //RED
                 {
                  up_filter_ratio = true;
                 }
               else
                  if(g_ibuf_104[i+1] !=EMPTY_VALUE)   //GREEN
                    {
                     dn_filter_ratio = true;
                    }
              }
            else
              {
               up_filter_ratio = true;
               dn_filter_ratio = true;
              }

            //+------------------------------------------------------------------+
            //|  FILTRO DE RETRAÇÃO                                              |
            //+------------------------------------------------------------------+

            if(FILT_RET)
              {
               if(Close[i] > Open[i])
                  dn_Sanx_ok = (Close[i] - Open[i])/((High[i] - Open[i])+0.0000001) > ((double)SanxRatio)/100;

               else
                  up_Sanx_ok = (Open[i] - Close[i])/((Open[i] - Low[i])+0.0000001) > ((double)SanxRatio)/100;
              }
            else
              {
               up_Sanx_ok = true;
               dn_Sanx_ok = true;
              }

         //-----------------------------------------------------------------------------------------------------------------------------------------------------------
         // MACD ---------------------------------------
         //-----------------------------------------------------------------------------------------------------------------------------------------------------------
         MACDCurrent = iMACD(NULL,0,MACD_Period1,MACD_Period2,MACD_Period3,PRICE_CLOSE,MODE_MAIN,i);
         MACDPrev = iMACD(NULL,0,MACD_Period1,MACD_Period2,MACD_Period3,PRICE_OPEN,MODE_MAIN,i);
         MACDSignal = iMACD(NULL,0,MACD_Period1,MACD_Period2,MACD_Period3,PRICE_CLOSE,MODE_SIGNAL,i);
         MACDSignalPrev = iMACD(NULL,0,MACD_Period1,MACD_Period2,MACD_Period3,PRICE_OPEN,MODE_SIGNAL,i);

         if(MACDCurrent>MACDPrev && ((MACDCurrent && MACDPrev)>MACDSignal || (MACDCurrent && MACDPrev)<MACDSignal))
           {
            MACD=3;
           }
         if(MACDCurrent<MACDSignal && MACDPrev>MACDSignalPrev)
           {
            MACD=2;
           }
         if(MACDCurrent<MACDPrev && ((MACDCurrent && MACDPrev)>MACDSignal || (MACDCurrent && MACDPrev)<MACDSignal))
           {
            MACD=1;
           }
         if(MACDCurrent>MACDSignal && MACDPrev<MACDSignalPrev)
           {
            MACD=0;
           }
         if(MACDCurrent>0 && MACDPrev<0)
           {
            MACD=4;
           }
         if(MACDCurrent<0 && MACDPrev>0)
           {
            MACD=5;
           }
         //+------------------------------------------------------------------+
           
            //============================================================================================================================================================
            //============================================================================================================================================================
            // primeiro indicador
            if(COMBINER)
              {
               up1 = iCustom(NULL, 0, IndicatorName, IndiBufferCall, i+SignalType);
               dn1 = iCustom(NULL, 0, IndicatorName, IndiBufferPut, i+SignalType);
               up1 = sinal_buffer(up1);
               dn1 = sinal_buffer(dn1);
              }
            else
              {
               up1 = true;
               dn1 = true;
              }
            //============================================================================================================================================================
            //============================================================================================================================================================
            // segundo indicador
            if(COMBINER2)
              {
               up2 = iCustom(NULL, 0, IndicatorName2, IndiBufferCall2, i+SignalType2);
               dn2 = iCustom(NULL, 0, IndicatorName2, IndiBufferPut2, i+SignalType2);
               up2 = sinal_buffer(up2);
               dn2 = sinal_buffer(dn2);
              }
            else
              {
               up2 = true;
               dn2 = true;
              }
            //TERCEIRO INDICADOR
            if(COMBINER3)
              {
               up3 = iCustom(NULL, 0, IndicatorName3, IndiBufferCall3, i+SignalType3);
               dn3 = iCustom(NULL, 0, IndicatorName3, IndiBufferPut3, i+SignalType3);
               up3 = sinal_buffer(up3);
               dn3 = sinal_buffer(dn3);
              }
            else
              {
               up3 = true;
               dn3 = true;
              }

            //QUARTO INDICADOR
            if(COMBINER4)
              {
               up4 = iCustom(NULL, 0, IndicatorName4, IndiBufferCall4, i+SignalType4);
               dn4 = iCustom(NULL, 0, IndicatorName4, IndiBufferPut4, i+SignalType4);
               up4 = sinal_buffer(up4);
               dn4 = sinal_buffer(dn4);
              }
            else
              {
               up4 = true;
               dn4 = true;
              }

            //ESTRATEGIA SANX
            //============================================================================================================================================================
            if(Bloquea)
              {
               candlesup=0;
               candlesdn=0;
               int j;
               for(j = i+quantidade+1 ; j>=i; j--)
                 {
                  if(close[j+1]>=open[j+1]) // && close[j+2] > open[j+2])
                     candlesup++;
                  else
                     candlesup=0;
                  if(close[j+1]<=open[j+1]) // && close[j+2] < open[j+2])
                     candlesdn++;
                  else
                     candlesdn = 0;
                 }
              }

            //============================================================================================================================================================
            //============================================================================================================================================================
            if( //CALL  ----  ACIMA
               //============================================================================================================================================================
               up[i] == EMPTY_VALUE
               && up1  // Combiner
               && up2  // Combiner2
               && up3  // Combiner3
               && up4  // Combiner2
               && up_Sanx //SANX ESTRATEGIA
               && fora_banda_up //AtivaDonchian
               && up_taurus  //PRICE ACTION
               && up_cci //CCI
               && up_adx //ADX
               && up_bb //BOLINGARBAND
               && up_arcanjo //ARCANJO
               && up_god //GOD
               && up_sg  //SOROSGALE
               && up_volume // VOLUME)
               && (!Trend || trend<=-0.99)
               && (!HILL || RSI[i] < LowerBuffer[i])
               &&(!AtivarMACD || MACDPrev>MACDSignal) &&(!AtivarMACD || MACDCurrent>MACDSignal) &&(!AtivarMACD || MACDPrev>MACDSignalPrev) &&(!MHI || (cont1+cont2+cont3)<2) &&(!MHI ||  tm==true)
               &&(!Harami || (Open [i+1] > Close [i+1])) &&(!Harami || (Open [i] < Close [i]))
               &&(!Harami || (Close[i+1] < Open [i])) &&(!Harami || (Open [i+1] > Close [i]))
               &&(!Pulback_Enabled || (RSI_6<=MinRSI_6 &&Padrao("call", i) && Close[i+FilterShift]>MA_1))
               &&(!Adx_Enabled || b4plusdi > b4minusdi) &&(!Adx_Enabled || nowplusdi < nowminusdi) &&(!SanxExtremo || (i==llb))
               &&(!ViradaDeHora || TimeMinute(Time[i])==59)  &&(!ViradaDeHora || Padrao("call", i))  && (!AtivaDonchian || (AtivaDonchian && (iLow(NULL,0,i)<Minima && close[i]<open[i])))
               &&(!EnabledRVI || RVI<=MINRVI) &&(!EnabledMFI || MFI<=MINMFI) &&(!EnabledWPR || WPR<=MAXWPR) &&(!Fluxo || (i==hhb))
               &&(!AtivarMACD || MACDCurrent<MACDPrev) &&(!AtivarMACD || MACDCurrent) &&(!AtivarMACD || MACDPrev>MACDSignal) &&(!AtivarMACD || MACDCurrent)
               &&(!AtivarCruzamento || fasterEMAnow > slowerEMAnow) &&(!AtivarCruzamento || fasterEMAprevious < slowerEMAprevious) &&(!AtivarCruzamento || fasterEMAafter > slowerEMAafter)
               && up_so //STOCHASTIC
               && up_Sanx_ok //FILTRO DE RETRAÇÃO
               && (!ativar_donforex || DonForex(i, true)) //DOMFOREX
               && down[i] == EMPTY_VALUE
               && up_filter_ratio //FILTER RATIO
               && ((AtivarTamanhoVela && tamanhodevela(i)) || !AtivarTamanhoVela)
               && ((AtivarTamanhoVela1 && tamanhodevela1(i)) || !AtivarTamanhoVela1)
               && (!Bloquea || candlesdn < quantidade)
               //============================================================================================================================================================
               && ser_up //SUPORTE E RESISTENCIA UP
               //============================================================================================================================================================
               && (!FiltroVelas || (FiltroVelas && Open[i] < Close[i+1]))  //Filtro Velas
            )
              {
               if(Time[i] > (LastSignal + Intervalo*tempoIntervalo))
                 {
                  LastSignal = Time[0];

                  CrossUp[i] = iLow(_Symbol,PERIOD_CURRENT,i)-6*Point();

                  if(Entrada==ATIVAR_PRE_ALERTA && i ==0)
                    {
                     Sig_Up0=1;
                     if(noDellArrow)
                       {
                        Print("Caiu enviar telegram, CALL");
                        enviaTelegram("CALL");
                       }
                    }

                 }
              }
            else
              {
               Sig_Up0=0;
               if(!noDellArrow && i == 0)
                 {
                  LastSignal = Time[i+10];
                  CrossUp[i] = EMPTY_VALUE;
                 }
              }
            //============================================================================================================================================================
            //PUT ------  ABAIXO
            if(
               //============================================================================================================================================================
               up[i] == EMPTY_VALUE
               && dn1   // Combiner1
               && dn2   // Combiner2
               && dn3   // Combiner3
               && dn4   // Combiner2
               && dn_cci // CCI
               && dn_adx //ADX
               && dn_bb //BOLINGARBAND
               && dn_arcanjo //ARCANJO
               && dn_god //GOD
               && dn_sg  //SOROSGALE
               && dn_volume //VOLUME
               && (!Trend || trend>=-0.99)
               && (!HILL || RSI[i] > UpperBuffer[i])
               &&(!AtivarMACD || MACDPrev<MACDSignal) &&(!AtivarMACD || MACDCurrent<MACDSignal) &&(!AtivarMACD || MACDPrev<MACDSignalPrev) &&(!MHI || (cont1+cont2+cont3)>=2) &&(!MHI ||  tm==true)
               &&(!Harami || (Open [i+1] < Close [i+1])) &&(!Harami || (Open [i] > Close [i]))
               &&(!Harami || (Close[i+1] > Open [i])) &&(!Harami || (Open [i+1] < Close [i]))
               &&(!Pulback_Enabled || (RSI_6>=MaxRSI_6  &&Padrao("put", i) && Close[i+FilterShift]<MA_1))
               &&(!Adx_Enabled || b4plusdi < b4minusdi) &&(!Adx_Enabled || nowplusdi > nowminusdi) &&(!SanxExtremo || (i==hhb))
               &&(!ViradaDeHora || TimeMinute(Time[i])==59) &&(!ViradaDeHora || Padrao("put", i)) && (!AtivaDonchian || (AtivaDonchian && (iHigh(NULL,0,i)>Maxima && close[i]>open[i])))
               &&(!EnabledRVI || RVI>=MAXRVI) &&(!EnabledMFI || MFI>=MAXMFI) &&(!EnabledWPR || WPR>=MINWPR) &&(!Fluxo || (i==llb))&& dn1 && dn2
               &&(!AtivarMACD || MACDCurrent>MACDPrev) &&(!AtivarMACD || MACDCurrent) &&(!AtivarMACD || MACDPrev<MACDSignal) &&(!AtivarMACD || MACDCurrent)
               &&(!AtivarCruzamento || fasterEMAnow < slowerEMAnow) &&(!AtivarCruzamento || fasterEMAprevious > slowerEMAprevious) &&(!AtivarCruzamento || fasterEMAafter < slowerEMAafter)
               && dn_so //STOCHASTIC
               && dn_Sanx //SANX ESTRATEGIA
               && (!ativar_donforex || DonForex(i, false)) //DOMFOREX
               && down[i] == EMPTY_VALUE
               && dn_filter_ratio //FILTER RATIO
               && dn_Sanx_ok //FILTRO DE RETRAÇÃO
               && dn_taurus  //PRICE ACTION
               && fora_banda_dn //AtivaDonchian
               && ((AtivarTamanhoVela && tamanhodevela(i)) || !AtivarTamanhoVela)
               && ((AtivarTamanhoVela1 && tamanhodevela1(i)) || !AtivarTamanhoVela1)
               && (!Bloquea || candlesup < quantidade)
               //============================================================================================================================================================
               && (!FiltroVelas || (FiltroVelas && Open[i] > Close[i+1]))  //Filtro Velas
               //============================================================================================================================================================
               && ser_dn //SUPORTE E RESISTENCIA
               //============================================================================================================================================================
            )
              {

               if(Time[i] > (LastSignal + Intervalo*tempoIntervalo))
                 {

                  LastSignal = Time[0];

                  CrossDown[i] = iHigh(_Symbol,PERIOD_CURRENT,i)+6*Point();

                  if(Entrada==ATIVAR_PRE_ALERTA && i ==0)
                    {
                     Sig_Dn0=1;
                     if(noDellArrow)
                       {
                        Print("Caiu enviar telegram, PUT");
                        enviaTelegram("PUT");
                       }
                    }

                 }
              }
            else
              {
               Sig_Dn0=0;
               if(!noDellArrow && i == 0)
                 {
                  LastSignal = Time[i+10];
                  CrossDown[i] = EMPTY_VALUE;

                 }
              }


            //============================================================================================================================================================
            if(sinal_buffer(CrossUp[i+1]) && !sinal_buffer(up[i+1]) && up[i] == EMPTY_VALUE)
              {
               LastSignal = Time[i+2];
               up[i] = Low[i]-3*Point();
               Sig_UpCall0=1;

              }
            else
              {
               Sig_UpCall0=0;
              }
            //============================================================================================================================================================
            if(sinal_buffer(CrossDown[i+1]) && !sinal_buffer(down[i+1]) && down[i] == EMPTY_VALUE)
              {
               LastSignal = Time[i+2];
               down[i] = High[i]+3*Point();
               Sig_DnPut0=1;

              }
            else
              {
               Sig_DnPut0=0;
              }

            //BACKTESTE
            //Sem Gale
            if(sinal_buffer(down[i]) && Close[i]<Open[i] && sinal_buffer(CrossDown[i+1]))
              {
               win[i] = High[i] + 50*Point;
               loss[i] = EMPTY_VALUE;
               //continue;
              }
            if(sinal_buffer(down[i]) && Close[i]>=Open[i] && sinal_buffer(CrossDown[i+1]))
              {
               loss[i] = High[i] + 50*Point;
               win[i] = EMPTY_VALUE;
               //continue;
              }
            if(sinal_buffer(up[i]) && Close[i]>Open[i] && sinal_buffer(CrossUp[i+1]))
              {
               win[i] = Low[i] - 50*Point;
               loss[i] = EMPTY_VALUE;
               //continue;
              }
            if(sinal_buffer(up[i]) && Close[i]<=Open[i] && sinal_buffer(CrossUp[i+1]))
              {
               loss[i] = Low[i] - 50*Point;
               win[i] = EMPTY_VALUE;
               //continue;
              }
            //============================================================================================================================================================
            //G1
            if(sinal_buffer(down[i+1]) && sinal_buffer(loss[i+1]) && Close[i]<Open[i])
              {
               wg[i] = High[i] + 50*Point;
               ht[i] = EMPTY_VALUE;
               //continue;
              }
            if(sinal_buffer(down[i+1]) && sinal_buffer(loss[i+1]) && Close[i]>=Open[i])
              {
               ht[i] = High[i] + 50*Point;
               wg[i] = EMPTY_VALUE;
               //continue;
              }
            if(sinal_buffer(up[i+1]) && sinal_buffer(loss[i+1]) && Close[i]>Open[i])
              {
               wg[i] = Low[i] - 50*Point;
               ht[i] = EMPTY_VALUE;
               //continue;
              }
            if(sinal_buffer(up[i+1]) && sinal_buffer(loss[i+1]) && Close[i]<=Open[i])
              {
               ht[i] = Low[i] - 50*Point;
               wg[i] = EMPTY_VALUE;
               //continue;
              }

           }

         //VERIFICA A TENDENCIA
         /*if(Low[i] > iMA(NULL,0,PeriodoMA,0,ModeMA,MA_Price,i))
           {
            CreateTextLable("labelTendencia","Tendência de Alta",12,"Arial Black",clrGreen,0,245,2);
           }
         if(High[i]< iMA(NULL,0,PeriodoMA,0,ModeMA,MA_Price,i))
           {
            CreateTextLable("labelTendencia","Tendência de Baixa",12,"Arial Black",clrRed,0,245,2);
           }
         if(Low[i] < iMA(NULL,0,PeriodoMA,0,ModeMA,MA_Price,i) && High[i] > iMA(NULL,0,PeriodoMA,0,ModeMA,MA_Price,i))
           {
            CreateTextLable("labelTendencia","Tendência Lateral",12,"Arial Black",clrYellow,0,245,2);
           }*/

        }
     }
   else
     {
      Alert("Acesso para algumas funções não liberado entre em contato pelo telegram @Sanjay_saju");
      return (-01);
     }
   bool entrarUP = false;
   bool entrarDN = false;

   if(Entrada == DESATIVAR_PRE_ALERTA)
     {
      //BUFFER SETA UP CALL
      if(sinal_buffer(up[0]))
        {
         entrarUP = true;
         //Print("Lendo sinal SEM pre alerta");
        }

      //BUFFER SETA DOWN PUT
      if(sinal_buffer(down[0]))
        {
         entrarDN = true;
         //Print("Lendo sinal SEM pre alerta");

        }
     }

   else
     {
      //BUFFER PRÉ ALERTA UP CALL
      if(sinal_buffer(CrossUp[0]))
        {
         entrarUP = true;
         //Print("Lendo sinal COM pre alerta UP");
        }

      //BUFFER PRÉ ALERTA DOWN PUT
      if(sinal_buffer(CrossDown[0]))
        {
         entrarDN = true;
         //Print("Lendo sinal COM pre alerta DN");
        }
     }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if((Antiloss == 0 && Time[0] > sendOnce && entrarUP))
     {
      if(!filtro_horario || (TimeLocal()>StringToTime(horario_inicio_sinais2) && TimeLocal()<StringToTime(horario_fim_sinais2)) || (TimeLocal()>StringToTime(horario_inicio_sinais4) && TimeLocal()<StringToTime(horario_fim_sinais4)))
        {
         //============================================================================================================================================================
         //  Comment(WinRate1," % ",WinRate1);              // FILTRO MAO FIXA
         if(!Mãofixa
            || (FiltroMãofixa && ((!Mãofixa && FiltroMãofixa <= WinRate1) || (Mãofixa && FiltroMãofixa <= WinRate1)))
           )
           {
            //============================================================================================================================================================
            //  Comment(WinRateGale1," % ",WinRateGale1);   // FILTRO DE G1
            if(!AplicaFiltroNoGale
               || (FiltroMartingale && ((!AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1) || (AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1)))
              )
              {
               //============================================================================================================================================================


               if(Entrada==DESATIVAR_PRE_ALERTA || ModoOTC)
                 {
                  EnviarRobo("CALL");
                  enviaTelegram("CALL");
                 }
               else
                 {
                  if(paridade == "Crypto IDX")
                    {
                     if(SecToEndOTC() <= SecEnvio && !ModoOTC)
                       {
                        EnviarRobo("CALL");
                       }
                    }
                  else
                    {
                     //Print("SectoEnd - ", SecToEnd());
                     if(SecToEnd() <= SecEnvio && !ModoOTC)
                       {
                        EnviarRobo("CALL");
                        enviaTelegram("CALL");
                       }
                     else
                        if(SecToEndOTC() <= SecEnvio && ModoOTC)
                          {
                             {
                              EnviarRobo("CALL");
                              enviaTelegram("CALL");
                             }
                          }
                    }
                 }

              }
           }
        }
     }
//============================================================================================================================================================
   if((Antiloss == 0 && Time[0] > sendOnce && entrarDN))
     {
      if(!filtro_horario || (TimeLocal()>StringToTime(horario_inicio_sinais2)&&TimeLocal()<StringToTime(horario_fim_sinais2)))
        {
         //============================================================================================================================================================
         //  Comment(WinRate1," % ",WinRate1);              // FILTRO MAO FIXA
         if(!Mãofixa
            || (FiltroMãofixa && ((!Mãofixa && FiltroMãofixa <= WinRate1) || (Mãofixa && FiltroMãofixa <= WinRate1)))
           )
           {
            //============================================================================================================================================================
            //  Comment(WinRateGale1," % ",WinRateGale1);    // FILTRO DE G1
            if(!AplicaFiltroNoGale
               || (FiltroMartingale && ((!AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1) || (AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1)))
              )
              {
               //============================================================================================================================================================

               if(Entrada==DESATIVAR_PRE_ALERTA || ModoOTC)
                 {
                  EnviarRobo("PUT");
                  enviaTelegram("PUT");
                 }
               else
                 {
                  if(paridade == "Crypto IDX")
                    {
                     if(SecToEndOTC() <= SecEnvio && !ModoOTC)
                       {
                        EnviarRobo("PUT");
                       }
                    }
                  else
                    {
                     //Print("SectoEnd - ", SecToEnd());
                     if(SecToEnd() <= SecEnvio && !ModoOTC)
                       {
                        EnviarRobo("PUT");
                        enviaTelegram("PUT");
                       }
                     else
                        if(SecToEndOTC() <= SecEnvio && ModoOTC)
                          {
                             {
                              EnviarRobo("PUT");
                              enviaTelegram("PUT");
                             }
                          }
                    }
                 }

              }
           }
        }
     }

//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                         ALERTAS                                  |
//+------------------------------------------------------------------+
   if(AlertsMessage || AlertsSound)
     {
      string message1 = (SignalName+" - "+Symbol()+" : Possible CALL "+PeriodString());
      string message2 = (SignalName+" - "+Symbol()+" : Possible PUT "+PeriodString());

      if(TimeBarUp!=Time[0] && Sig_Up0==1)
        {
         if(AlertsMessage)
            Alert(message1);

         if(AlertsSound)
            PlaySound(SoundFileUp);
         if(AlertEmailSubject > "")
            SendMail(AlertEmailSubject,message1);
         if(SendPushNotification)
            SendNotification(message1);
         TimeBarUp=Time[0];
        }
      if(TimeBarDn!=Time[0] && Sig_Dn0==1)
        {
         if(AlertsMessage)
            Alert(message2);

         if(AlertsSound)
            PlaySound(SoundFileDown);
         if(AlertEmailSubject > "")
            SendMail(AlertEmailSubject,message2);
         if(SendPushNotification)
            SendNotification(message2);
         TimeBarDn=Time[0];
        }
      Sig_Up0 = 0;
     }
//============================================================================================================================================================
//+------------------------------------------------------------------+
//|                         ALERTAS                                  |
//+------------------------------------------------------------------+
   if(AlertsMessage || AlertsSound)
     {
      string messageEntrada1 = (SignalName+" - "+Symbol()+" CALL "+PeriodString());
      string messageEntrada2 = (SignalName+" - "+Symbol()+" PUT "+PeriodString());

      if(TimeBarEntradaUp!=Time[0] && Sig_UpCall0==1)
        {
         if(AlertsMessage)
            Alert(messageEntrada1);
         if(AlertsSound)
            PlaySound("alert2.wav");
         TimeBarEntradaUp=Time[0];
        }
      if(TimeBarEntradaDn!=Time[0] && Sig_DnPut0==1)
        {
         if(AlertsMessage)
            Alert(messageEntrada2);
         if(AlertsSound)
            PlaySound("alert2.wav");
         TimeBarEntradaDn=Time[0];
        }
     }

//============================================================================================================================================================
   backteste();
   return (prev_calculated);
  }
//============================================================================================================================================================
void WriteFile(string path, string escrita)
  {
   Print("WriteFile");
   int filehandle = FileOpen(path,FILE_WRITE|FILE_TXT);
   FileWriteString(filehandle,escrita);
   FileClose(filehandle);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void WriteFileCSV(string path, string escrita)
  {
   Print("WriteFileCSV");
   int filehandle = FileOpen(path,FILE_CSV|FILE_READ|FILE_WRITE);
   FileSeek(filehandle, 0, SEEK_END);
   FileWrite(filehandle,escrita);
   FileClose(filehandle);
  }
//============================================================================================================================================================
string ReadFile(string path)
  {
   int handle;
   string str,word;
   handle=FileOpen(path,FILE_READ);
   while(!FileIsEnding(handle))
     {
      str=FileReadString(handle);
      word = word +"\n"+ str;
     }
   FileClose(handle);
   return word;
  }

//============================================================================================================================================================
string ReadFileCSV(string path)
  {
   int handle;
   string str,word;
   handle=FileOpen(path,FILE_READ);
   while(!FileIsEnding(handle))
     {
      str=FileReadString(handle);
      word = word + str;
     }
   FileClose(handle);
   return word;
  }
//============================================================================================================================================================
bool sinal_buffer(double value)
  {
   if(value != 0 && value != EMPTY_VALUE)
      return true;
   else
      return false;
  }
//============================================================================================================================================================
void CreateTextLable
(string TextLableName, string Text, int TextSize, string FontName, color TextColor, int TextCorner, int X, int Y)
  {
   ObjectCreate(TextLableName, OBJ_LABEL, 0, 0, 0);
   ObjectSet(TextLableName, OBJPROP_CORNER, TextCorner);
   ObjectSet(TextLableName, OBJPROP_XDISTANCE, X);
   ObjectSet(TextLableName, OBJPROP_YDISTANCE, Y);
   ObjectSetText(TextLableName,Text,TextSize,FontName,TextColor);
   ObjectSetInteger(0,TextLableName,OBJPROP_HIDDEN,true);
  }




//============================================================================================================================================================
//FUNÇÕES TELEGRAM


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string msgTelegram(string tempo, string dir, string timeframe)
  {

   string entrarAgora = Entrada==DESATIVAR_PRE_ALERTA ? " (AGORA)" : "";

   string msg="";
   msg =  
         "𒆜•------‼️  𝗦╎𝗔╎𝗡╎𝗫╎𝗣╎𝗥╎𝗢 ‼️------•𒆜"
         +"\n\n"
         +"╭━━━━━━━━ ・ ━━━━━━━━╮"+"\n"
         +"🐲 Active Pair -»"+paridade+"\n"
         +"🕓 Timetable  -»"+tempo+":00"+entrarAgora+"\n"
         +"⏳ Expiration  -» M"+timeframe+"\n"
         +dir+"\n"
         +"╰━━━━━━━━ ・ ━━━━━━━━╯"+"\n"
         +"⤷ Check Registered Link🔻"+"\n"
         +nome_payment+"\n"+"\n"
         +"⤷ Check Contact Information"+"\n"
         +"‼️"+nome_contact+"‼️"+"\n"+"\n"
         +"𒆜•------‼️ 𝗦╎𝗔╎𝗡╎𝗫╎𝗣╎𝗥╎𝗢 ‼️------•𒆜";
   return msg;    

  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime Offset(datetime expiracao_inicial, datetime expiracao_final)
  {
   MqlDateTime expiracao_convert, local_convert;
   TimeToStruct(expiracao_inicial,expiracao_convert);
   TimeLocal(local_convert);

   string expiracao_inicial_convert_str = string(expiracao_convert.year)+"."+string(expiracao_convert.mon)+"."+string(expiracao_convert.day)+" "+string(expiracao_convert.hour)+":"+string(local_convert.min)+":"+string(TimeSeconds(TimeGMT()));
   datetime expiracao_inicial_convert_dt = StringToTime(expiracao_inicial_convert_str);

   return expiracao_inicial_convert_dt;
  }

template <typename T> void RemoveIndexFromArray(T& A[], int iPos)
  {
   int iLast;
   for(iLast = ArraySize(A) - 1; iPos < iLast; ++iPos)
      A[iPos] = A[iPos + 1];
   ArrayResize(A, iLast);
  }

struct estatisticas
  {
   int               win_global;
   int               loss_global;
   int               win_Restrito;
   int               loss_Restrito;
   string            assertividade_global_valor;
   string            assertividade_Restrito_valor;

                     estatisticas()
     {
      Reset();
     }

   void              Reset()
     {
      win_global=0;
      loss_global=0;
      win_Restrito=0;
      loss_Restrito=0;
      assertividade_global_valor="0%";
      win_Restrito=0;
      loss_Restrito=0;
      assertividade_Restrito_valor="0%";
     }
  };


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AtualizarEstatisticas(estatisticas &estatistica)
  {
   int file_handle=FileOpen(arquivo_estatisticas,FILE_READ|FILE_SHARE_READ|FILE_TXT);
   if(file_handle!=INVALID_HANDLE)
     {
      int    str_size;
      string str;
      ushort u_sep = StringGetCharacter(";",0);

      while(!FileIsEnding(file_handle))
        {
         string result[];
         str_size=FileReadInteger(file_handle,INT_VALUE);
         str=FileReadString(file_handle,str_size);
         StringSplit(str,u_sep,result);
         if(ArraySize(result) > 2)
           {
            if(result[3]=="win"||result[3]=="wing1"||result[3]=="wing2")
               estatistica.win_global++;
            else
               if(result[3]=="loss"||result[3]=="lossg1"||result[3]=="lossg2")
                  estatistica.loss_global++;
            if(result[0]==Symbol() && (result[3]=="win"||result[3]=="wing1"||result[3]=="wing2"))
               estatistica.win_Restrito++;
            else
               if(result[0]==Symbol() && (result[3]=="loss"||result[3]=="lossg1"||result[3]=="lossg2"))
                  estatistica.loss_Restrito++;
           }
        }

      estatistica.assertividade_global_valor = estatistica.win_global>0 ? DoubleToString(((double)estatistica.win_global/((double)estatistica.win_global+(double)estatistica.loss_global))*100,0)+"%" : "0%";
      estatistica.assertividade_Restrito_valor = estatistica.win_Restrito>0 ? DoubleToString(((double)estatistica.win_Restrito/((double)estatistica.win_Restrito+(double)estatistica.loss_Restrito))*100,0)+"%" : "0%";

      FileClose(file_handle);
     }
   else
     {
      PrintFormat("Failed to open %s file, Error code = %d",arquivo_estatisticas,GetLastError());
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void GravarResultado(string par, string horario, string operacao, string resultado)
  {
   estatisticas estatistica;
   if(assertividade_global==true)
     {
      estatistica.Reset();
      //AtualizarEstatisticas(estatistica);
     }

   bool registrar=true;
   string registro = StringConcatenate(par,";",horario,";",operacao,";",resultado,"\n");
   int file_handle=FileOpen(arquivo_estatisticas,FILE_READ|FILE_SHARE_READ|FILE_SHARE_WRITE|FILE_WRITE|FILE_TXT);

   if(false)
     {
      int    str_size;
      string str;
      ushort u_sep = StringGetCharacter(";",0);

      while(!FileIsEnding(file_handle))
        {
         string result[];
         str_size=FileReadInteger(file_handle,INT_VALUE);
         str=FileReadString(file_handle,str_size);
         StringSplit(str,u_sep,result);

         if(result[0]==par && result[1]==horario && result[2]==operacao && result[3]==resultado)
            registrar=false;
        }
     }

   if(registrar==true)
     {
      FileSeek(file_handle,0,SEEK_END);
      FileWriteString(file_handle,registro);
     }

   FileClose(file_handle);
  }





//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetHoraMinutos(datetime time_open, bool resul=false)
{
   string entry, hora, minuto;

   MqlDateTime time_open_str, time_local_str, time_entrada_str; // structs
   TimeToStruct(time_open, time_open_str); // extracting the open time of the current candle and storing in a struct
   TimeLocal(time_local_str); // extracting the local time and storing in a struct
   string time_local_abertura_str = IntegerToString(time_local_str.year) + "." + IntegerToString(time_local_str.mon) + "." + IntegerToString(time_local_str.day) + " " + IntegerToString(time_local_str.hour) + ":" + IntegerToString(time_open_str.min) + ":" + IntegerToString(time_open_str.sec);
   datetime time_local_abertura_dt = StrToTime(time_local_abertura_str); // converting back to datetime already with local time and the open time of the candle

   if (Entrada == ATIVAR_PRE_ALERTA && resul == false)
      time_local_abertura_dt = time_local_abertura_dt + _Period * 60;

   // Adding 5 hours and 30 minutes (19800 seconds) to the time
   time_local_abertura_dt += -1800;

   TimeToStruct(time_local_abertura_dt, time_entrada_str); // converting datetime to struct to extract hour and minute

   //-- formatting time
   if (time_entrada_str.hour >= 0 && time_entrada_str.hour <= 9)
      hora = "0" + IntegerToString(time_entrada_str.hour);
   else
      hora = IntegerToString(time_entrada_str.hour);

   if (time_entrada_str.min >= 0 && time_entrada_str.min <= 9)
      minuto = "0" + IntegerToString(time_entrada_str.min);
   else
      minuto = IntegerToString(time_entrada_str.min);

   entry = hora + ":" + minuto;
   //--

   return entry;
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ExibirResultadoParcialAoVivo()
  {
   ushort u_sep = StringGetCharacter(";",0);
   int str_size;
   string str="",str_tratada="";

   int file_handle=FileOpen(arquivo_estatisticas,FILE_READ|FILE_SHARE_READ|FILE_TXT);
   while(!FileIsEnding(file_handle))
     {
      str_size=FileReadInteger(file_handle,INT_VALUE);
      str=FileReadString(file_handle,str_size);

      if(str!="")
        {
         string result[];
         StringSplit(str,u_sep,result);
         //0-symbol,1-hour,2-operation,3-result

        if(result[2]=="put")
            result[2] = "- PUT️";
         else
            result[2] = "- CALL️";

         if(result[3]=="win" || result[3]=="win#")
            str_tratada+="❒ "+result[1]+"-"+result[0]+result[2]+"✅\n";

         if(result[3]=="wing1" || result[3]=="wing1#")
            str_tratada+="❒ "+result[1]+"-"+result[0]+result[2]+"✅¹\n";

         if(result[3]=="doji")
            str_tratada+="❒ "+result[1]+"-"+result[0]+result[2]+"- DOJI ⚖️\n";

         if(result[3]=="loss" || result[3]=="loss#")
            str_tratada+="❒ "+result[1]+"-"+result[0]+result[2]+"✖\n";

         if(result[3]=="lossg1" || result[3]=="lossg1#")
            str_tratada+="❒ "+result[1]+"-"+result[0]+result[2]+"✖1\n";


        }
     }

   FileClose(file_handle);

   return str_tratada;
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void licenca()
  {
  data = StringToTime(ExpiryDate);
   int expirc = int((data-TimeCurrent())/86400);
   ObjectCreate("expiracao",OBJ_LABEL,0,0,0,0,0);
   ObjectSetText("expiracao"," License expire in "+IntegerToString(expirc)+"days ", 10,"Arial Black",clrYellow);
   ObjectSet("expiracao",OBJPROP_XDISTANCE,0*2);
   ObjectSet("expiracao",OBJPROP_YDISTANCE,1*20);
   ObjectSet("expiracao",OBJPROP_CORNER,3);
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,         // Event ID
                  const long& lparam,   // Parameter of type long event
                  const double& dparam, // Parameter of type double event
                  const string& sparam  // Parameter of type string events
                 )
  {


  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime LerArquivoDelay()
  {
   int file_handle=FileOpen(dirBot+"ultimo_resultado.txt",FILE_READ|FILE_SHARE_READ|FILE_SHARE_WRITE|FILE_WRITE|FILE_TXT);
   int str_size= FileReadInteger(file_handle,INT_VALUE);
   string str=FileReadString(file_handle,str_size);
   FileClose(file_handle);
   return int(str);
  }

//FIM FUNÇOES TELEGRAM
//==========================
//============================================================================================================================================================

int EventMinute, EventImpact;
void OnTimer()
  {

   MqlDateTime times;
   temposs = TimeToStruct(TimeLocal(),times);
   hoje = StringFormat("%d%02d%02d",times.year,times.mon,times.day);


//RELOGIO
   int thisbarminutes = Period();

   double thisbarseconds=thisbarminutes*60;
   double seconds=thisbarseconds -(TimeCurrent()-Time[0]);

   double minutes= MathFloor(seconds/60);
   double hours  = MathFloor(seconds/3600);

   minutes = minutes -  hours*60;
   seconds = seconds - minutes*60 - hours*3600;

   string sText=DoubleToStr(seconds,0);
   if(StringLen(sText)<2)
      sText="0"+sText;
   string mText=DoubleToStr(minutes,0);
   if(StringLen(mText)<2)
      mText="0"+mText;
   string hText=DoubleToStr(hours,0);
   if(StringLen(hText)<2)
      hText="0"+hText;

   ObjectSetText("Time_Remaining", mText+":"+sText, 13, "@Batang", StrToInteger(mText+sText) >= 0010 ? clrWhiteSmoke : clrRed);

   ObjectSet("Time_Remaining",OBJPROP_CORNER,1);
   ObjectSet("Time_Remaining",OBJPROP_XDISTANCE,10);
   ObjectSet("Time_Remaining",OBJPROP_YDISTANCE,3);
   ObjectSet("Time_Remaining",OBJPROP_BACK,false);

   if(!initgui)
     {
      ObjectsDeleteAll(0,"Obj_*");
      ObjectsDeleteAll(0, "label*");
      initgui = true;
     }
//FIM RELOGIO


//VARIAVEIS TELEGRAM
   arquivo_estatisticas = dirBot+hoje+"_results.txt";

//FILTRO DE HORARIOS 1
   horario_inicio_sinais2 = TimeToStr(TimeLocal(),TIME_DATE)+" "+horario_inicio_sinais;
   horario_fim_sinais2 = TimeToStr(TimeLocal(),TIME_DATE)+" "+horario_fim_sinais;

//FILTRO DE HORARIOS 2
   horario_inicio_sinais4 = TimeToStr(TimeLocal(),TIME_DATE)+" "+horario_inicio_sinais3;
   horario_fim_sinais4 = TimeToStr(TimeLocal(),TIME_DATE)+" "+horario_fim_sinais3;
//FIM DE FILTRO DE HORARIOS


//FILTRO DE NOTICIAS
   if(filtro_noticias && (sinal_buffer(CrossUp[0])|| sinal_buffer(CrossDown[0])))
     {
      EventMinute = (int)iCustom(NULL,0,"ffcal2",0,0);
      EventImpact = (int)iCustom(NULL,0,"ffcal2",1,0);

      if(EventMinute <= noticia_minutos_antes && EventImpact >= noticia_impacto)
         desativar_sinais_horario = iTime(NULL,PERIOD_M1,0)+(noticia_minutos_antes+noticia_minutos_depois)*60;
     }
//FIM DE FILTRO DE NOTICIAS



///INICIO TELEGRAM//////////////////////////////////////////////////////////

   if(resultados_parciais_ao_vivo)
     {
      if(befTime_aovivo < TimeGMT()-1800)
        {
         estatisticas estatistica;
         estatistica.Reset();
         AtualizarEstatisticas(estatistica);

         string resultado = "𒆜•--‼️ 𝗙𝗜𝗡𝗔𝗟 ⋅◈⋅  𝗥𝗘𝗦𝗨𝗟𝗧𝗦 ‼️--•𒆜️\n\n━━━━━━━━━・━━━━━━━━━\n"+"                  " + GetFormattedDate() + "\n━━━━━━━━━・━━━━━━━━━\n";
         resultado+=ExibirResultadoParcialAoVivo();
         befTime_aovivo = TimeGMT()-1800+tempo_minutos_ao_vivo*60;
         //Print("TIME GMT - ",int(TimeGMT()-1800)," - Arquivo delay - ",int(LerArquivoDelay()), " - ", _Symbol);
         if(StringLen(resultado) > 50 && int(TimeGMT())-1800 > int(LerArquivoDelay()))
           {
            //Print("ultimos ultimo_resultado");
            FileDelete(dirBot+"ultimo_resultado.txt");
            resultado+="━━━━━━━━━・━━━━━━━━━\n"+"🧮 Total Signal : "+string(estatistica.win_global)+"x"+string(estatistica.loss_global)+"⋅◈⋅ ("+estatistica.assertividade_global_valor+")\n"+"━━━━━━━━━・━━━━━━━━━"+"\n🏆Win: "+string(estatistica.win_global)+" |☠️ Loss: "+string(estatistica.loss_global)+"☃️ ⋅◈⋅ ("+estatistica.assertividade_global_valor+")\n"+"━━━━━━━━━・━━━━━━━━━"+"\n\n𒆜•------‼️ 𝗦╎𝗔╎𝗡╎𝗫╎𝗣╎𝗥╎𝗢 ‼️------•𒆜";
            TelegramSendTextAsync(apikey,chatid,resultado);
            //FileDelete(arquivo_estatisticas);

            int fileHandle = FileOpen(dirBot+"ultimo_resultado.txt",FILE_CSV|FILE_READ|FILE_WRITE);
            int dataA = int(TimeGMT())-int(1800)+tempo_minutos_ao_vivo*60;
            FileWrite(fileHandle,dataA);
            FileClose(fileHandle);
           }
        }
     }


   for(int i=0; i<ArraySize(tipo_entrada); i++)
     {
      //Print("Entrou no FOR");
      datetime horario_expiracao_gale = horario_expiracao[i]+ExpiryMinutes*60; //horário acrescido para checkar o gale
      //datetime horario_expiracao_gale2 = horario_expiracao_gale+ExpiryMinutes*60; //horário acrescido para checkar o gale
      datetime horario_agora = iTime(Symbol(),_Period,0);
      bool remove_index=false;

      if(horario_agora>=horario_expiracao[i] || horario_agora>=horario_expiracao_gale)
        {
         //Print("Caiu nos Horarios");

         string msg_resultado = 
                               "🐲"+paridade+
                               "┃ 🕓"+horario_entrada_local[i]  ;   
                               //+"🔋M"+string(ExpiryMinutes)+"|";
       

         int shift_abertura=iBarShift(NULL,0,horario_entrada[i]);
         int shift_expiracao=ExpiryMinutes==_Period ? shift_abertura : iBarShift(NULL,0,horario_expiracao[i]);

         int shift_abertura_gale=iBarShift(NULL,0,horario_expiracao[i]);
         int shift_expiracao_gale=ExpiryMinutes==_Period ? shift_abertura_gale : iBarShift(NULL,0,horario_expiracao_gale);

         //int shift_abertura_gale2=iBarShift(NULL,0,horario_expiracao_gale);
         //int shift_expiracao_gale2=ExpiryMinutes==_Period ? shift_abertura_gale2 : iBarShift(NULL,0,horario_expiracao_gale2);

         if(tipo_entrada[i]==CALL)  //entrada CALL
           {
            //Print("CORRIGINDO CALL");
            if(Close[shift_expiracao]>Open[shift_abertura] && horario_agora>=horario_expiracao[i])
              {
               GravarResultado(paridade,horario_entrada_local[i],"call","win");
               TelegramSendTextAsync(apikey, chatid,"𒆜•------‼️ 𝗥╎𝗘╎𝗦╎𝗨╎𝗟╎𝗧 ‼️------•𒆜"+"\n"+"╭━━━━━━━━ ・ ━━━━━━━━╮"+"\n"+msg_resultado+"\n"+"╰━━━━━━━━ ・ ━━━━━━━━╯"+"\n"+".     ✅✅✅ SURESHOT ✅✅✅"+"\n"+msgWin+getResultadoTotalVela());
               remove_index=true;

              }

            else
               if(Close[shift_expiracao]==Open[shift_abertura])
                 {
                  GravarResultado(paridade,horario_entrada_local[i],"call","doji");
                  TelegramSendTextAsync(apikey, chatid,"𒆜•------‼️ 𝗥╎𝗘╎𝗦╎𝗨╎𝗟╎𝗧 ‼️------•𒆜"+"\n"+"╭━━━━━━━━ ・ ━━━━━━━━╮"+"\n"+msg_resultado+"\n"+"╰━━━━━━━━ ・ ━━━━━━━━╯"+"\n"+"⋅      ‼️❕♻️DOJI TRADE ♻️❕‼️"+"\n"+getResultadoTotalVela());
                  remove_index=true;
                 }

               else
                  if(Close[shift_expiracao_gale]>Open[shift_abertura_gale])
                    {
                     if(horario_agora>=horario_expiracao_gale)
                       {
                        GravarResultado(paridade,horario_entrada_local[i],"call","wing1");
                        TelegramSendTextAsync(apikey, chatid,"𒆜•------‼️ 𝗥╎𝗘╎𝗦╎𝗨╎𝗟╎𝗧 ‼️------•𒆜"+"\n"+"╭━━━━━━━━ ・ ━━━━━━━━╮"+"\n"+msg_resultado+"\n"+"╰━━━━━━━━ ・ ━━━━━━━━╯"+"\n"+"⋅      ✅✅✅ MTG WIN¹ ✅✅✅"+"\n"+msgWin+getResultadoTotalVela());
                        remove_index=true;
                       }
                    }
                  else
                     if(Close[shift_expiracao_gale]<Open[shift_abertura_gale])
                       {
                        if(horario_agora>=horario_expiracao_gale)
                          {
                           GravarResultado(paridade,horario_entrada_local[i],"call","loss");
                           TelegramSendTextAsync(apikey, chatid, "𒆜•------‼️ 𝗥╎𝗘╎𝗦╎𝗨╎𝗟╎𝗧 ‼️------•𒆜"+"\n"+"╭━━━━━━━━ ・ ━━━━━━━━╮"+"\n"+msg_resultado+"\n"+"╰━━━━━━━━ ・ ━━━━━━━━╯"+"\n"+"⋅      ❎✖️☠️ LOSS TRADE ☠️✖️❎"+"\n"+msgLoss+getResultadoTotalVela());
                           remove_index=true;
                          }
                       }
           }

         //ENTRADA PUT
         if(tipo_entrada[i]==PUT)  //entrada PUT
           {
            //Print("CORRIGINDO PUT");
            if(Close[shift_expiracao]<Open[shift_abertura] && horario_agora>=horario_expiracao[i])
              {
               GravarResultado(paridade,horario_entrada_local[i],"put","win");
               TelegramSendTextAsync(apikey, chatid, "𒆜•------‼️ 𝗥╎𝗘╎𝗦╎𝗨╎𝗟╎𝗧 ‼️------•𒆜"+"\n"+"╭━━━━━━━━ ・ ━━━━━━━━╮"+"\n"+msg_resultado+"\n"+"╰━━━━━━━━ ・ ━━━━━━━━╯"+"\n"+".     ✅✅✅ SURESHOT ✅✅✅"+"\n"+msgWin+getResultadoTotalVela());
               remove_index=true;
              }

            else
               if(Close[shift_expiracao]==Open[shift_abertura] && horario_agora>=horario_expiracao[i])
                 {
                  GravarResultado(paridade,horario_entrada_local[i],"put","doji");
                  TelegramSendTextAsync(apikey, chatid, "𒆜•------‼️ 𝗥╎𝗘╎𝗦╎𝗨╎𝗟╎𝗧 ‼️------•𒆜"+"\n"+"╭━━━━━━━━ ・ ━━━━━━━━╮"+"\n"+msg_resultado+"\n"+"╰━━━━━━━━ ・ ━━━━━━━━╯"+"\n"+"⋅      ‼️❕♻️DOJI TRADE ♻️❕‼️"+"\n"+getResultadoTotalVela());
                  remove_index=true;
                 }

               else
                  if(Close[shift_expiracao_gale]<Open[shift_abertura_gale])
                    {
                     if(horario_agora>=horario_expiracao_gale)
                       {
                        GravarResultado(paridade,horario_entrada_local[i],"put","wing1");
                        TelegramSendTextAsync(apikey, chatid, "𒆜•------‼️ 𝗥╎𝗘╎𝗦╎𝗨╎𝗟╎𝗧 ‼️------•𒆜�"+"\n"+"╭━━━━━━━━ ・ ━━━━━━━━╮"+"\n"+msg_resultado+"\n"+"╰━━━━━━━━ ・ ━━━━━━━━╯"+"\n"+"⋅      ✅✅✅ MTG WIN¹ ✅✅✅"+"\n"+getResultadoTotalVela());
                        remove_index=true;
                       }
                    }
                  else
                     if(Close[shift_expiracao_gale]>Open[shift_abertura_gale])
                       {
                        if(horario_agora>=horario_expiracao_gale)
                          {
                           GravarResultado(paridade,horario_entrada_local[i],"put","loss");
                           TelegramSendTextAsync(apikey, chatid,"𒆜•------‼️ 𝗥╎𝗘╎𝗦╎𝗨╎𝗟╎𝗧 ‼️------•𒆜"+"\n"+"╭━━━━━━━━ ・ ━━━━━━━━╮"+"\n"+msg_resultado+"\n"+"╰━━━━━━━━ ・ ━━━━━━━━╯"+"\n"+"⋅      ❎✖️☠️ LOSS TRADE ☠️✖️❎"+"\n"+msgLoss+getResultadoTotalVela());
                           remove_index=true;
                          }
                       }
           }


         if(remove_index==true)
           {
            RemoveIndexFromArray(horario_entrada,i);
            RemoveIndexFromArray(horario_entrada_local,i);
            RemoveIndexFromArray(horario_expiracao,i);
            RemoveIndexFromArray(tipo_entrada,i);
            RemoveIndexFromArray(entrada,i);
           }
        }
     }

  }
//============================================================================================================================================================
int SecToEnd()
  {
   int sec = int((Time[0]+PeriodSeconds()) - TimeCurrent());

   return(sec);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int SecToEndOTC()
  {
   int sec_otc = int((Time[0]+PeriodSeconds())+1800 - TimeCurrent());


   return(sec_otc);
  }


//============================================================================================================================================================
string PeriodString()
  {
   switch(_Period)
     {
      case PERIOD_M1:
         return("M1");
      case PERIOD_M5:
         return("M5");
      case PERIOD_M15:
         return("M15");
      case PERIOD_M30:
         return("M30");
      case PERIOD_H1:
         return("H1");
      case PERIOD_H4:
         return("H4");
      case PERIOD_D1:
         return("D1");
      case PERIOD_W1:
         return("W1");
      case PERIOD_MN1:
         return("MN1");
     }
   return("M" + string(_Period));
  }
//============================================================================================================================================================
bool isNewBar()
  {
   static datetime time=0;
   if(time==0)
     {
      time=Time[0];
      return false;
     }
   if(time!=Time[0])
     {
      time=Time[0];
      return true;
     }
   return false;
  }
//============================================================================================================================================================
void backteste()
  {
//============================================================================================================================================================

   g = 0;
   wbk = 0;
   lbk = 0;
   wg1 = 0;
   ht1 = 0;

//============================================================================================================================================================
   if(AtivaPainel==true && g==0)
     {
      //tvb1 = Time[0]+Period()*60;
      g=g+1;

      for(int v=Velas; v>0; v--)
        {
         if(win[v]!=EMPTY_VALUE)
           {
            wbk = wbk+1;
           }
         if(loss[v]!=EMPTY_VALUE)
           {
            lbk=lbk+1;
           }
         if(wg[v]!=EMPTY_VALUE)
           {
            wg1=wg1+1;
           }
         if(ht[v]!=EMPTY_VALUE)
           {
            ht1=ht1+1;
           }
        }
      //============================================================================================================================================================
      wg1 = wg1 +wbk;

      if((wbk + lbk)!=0)
        {
         WinRate1 = ((lbk/(wbk + lbk))-1)*(-100);
        }
      else
        {
         WinRate1=100;
        }

      if((wg1 + ht1)>0)
        {
         WinRateGale1 = ((ht1/(wg1 + ht1)) - 1)*(-100);
        }
      else
        {
         WinRateGale1=100;
        }


      ObjectSet("FrameLabel",OBJPROP_YDISTANCE,1*18);

      ObjectSet("FrameLabel",OBJPROP_XSIZE,1*220);
      ObjectSet("FrameLabel",OBJPROP_YSIZE,1*140);

      ObjectCreate("cop",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("cop","SANX COMBINER V0.1", 11, "Arial Black",clrWhite);
      ObjectSet("cop",OBJPROP_XDISTANCE,1*45);
      ObjectSet("cop",OBJPROP_YDISTANCE,1*19);
      ObjectSet("cop",OBJPROP_CORNER,Posicao);


      ObjectCreate("pul",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("pul","======================", 11, "Arial Black",clrWhite);
      ObjectSet("pul",OBJPROP_XDISTANCE,1*32);
      ObjectSet("pul",OBJPROP_YDISTANCE,1*35);
      ObjectSet("pul",OBJPROP_CORNER,Posicao);


      ObjectCreate("Win",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Win","Win: "+DoubleToString(wbk,0),11, "Arial Black",clrLime);
      ObjectSet("Win",OBJPROP_XDISTANCE,1*50);
      ObjectSet("Win",OBJPROP_YDISTANCE,1*50);
      ObjectSet("Win",OBJPROP_CORNER,Posicao);

      ObjectCreate("Loss",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Loss","Loss: "+DoubleToString(lbk,0), 11, "Arial Black",clrRed);
      ObjectSet("Loss",OBJPROP_XDISTANCE,1*140); //30
      ObjectSet("Loss",OBJPROP_YDISTANCE,1*50); //61
      ObjectSet("Loss",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinRate",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinRate","WinRate: "+DoubleToString(WinRate1,0) +"%", 11, "Arial Black",clrWhite);
      ObjectSet("WinRate",OBJPROP_XDISTANCE,1*50);//30
      ObjectSet("WinRate",OBJPROP_YDISTANCE,1*70);//81
      ObjectSet("WinRate",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinGale",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinGale","Win Gale: "+DoubleToString(wg1,0), 11, "Arial Black",clrLime);
      ObjectSet("WinGale",OBJPROP_XDISTANCE,1*50); //140
      ObjectSet("WinGale",OBJPROP_YDISTANCE,1*90); //41
      ObjectSet("WinGale",OBJPROP_CORNER,Posicao);

      ObjectCreate("Hit",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("Hit","Hit: "+DoubleToString(ht1,0), 11, "Arial Black",clrRed);
      ObjectSet("Hit",OBJPROP_XDISTANCE,1*170);
      ObjectSet("Hit",OBJPROP_YDISTANCE,1*90);
      ObjectSet("Hit",OBJPROP_CORNER,Posicao);

      ObjectCreate("WinRateGale",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("WinRateGale","WinRate Gale: "+DoubleToString(WinRateGale1,0)+"%", 11, "Arial Black",clrWhite);
      ObjectSet("WinRateGale",OBJPROP_XDISTANCE,1*50);//140
      ObjectSet("WinRateGale",OBJPROP_YDISTANCE,1*110); //80
      ObjectSet("WinRateGale",OBJPROP_CORNER,Posicao);

      ObjectCreate("pulo",OBJ_LABEL,0,0,0,0,0);
      ObjectSetText("pulo","======================", 11, "Arial Black",clrWhite);
      ObjectSet("pulo",OBJPROP_XDISTANCE,1*32);
      ObjectSet("pulo",OBJPROP_YDISTANCE,1*130);
      ObjectSet("pulo",OBJPROP_CORNER,Posicao);

      CommentLab(Symbol()+"", 150, 50, 2,clrDarkGoldenrod);
      CommentLabDiv(" | ", 150, 140, 5,clrWhite);
      CommentLabTelegram(enviar_telegram == true ? "TELEGRAM: ON" : "TELEGRAM: OFF", 150, 162, 2, enviar_telegram == true ? clrGreen : clrRed);
     }


  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CommentLab(string CommentText, int Ydistance, int Xdistance, int Label, int Cor)
  {
   string label_name;
   int CommentIndex = 0;

   label_name = "label" + string(Label);

   ObjectCreate(0,label_name,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,label_name, OBJPROP_CORNER, 0);
//--- set X coordinate
   ObjectSetInteger(0,label_name,OBJPROP_XDISTANCE,Xdistance);
//--- set Y coordinate
   ObjectSetInteger(0,label_name,OBJPROP_YDISTANCE,Ydistance);
//--- define text color
   ObjectSetInteger(0,label_name,OBJPROP_COLOR,Cor);
//--- define text for object Label
   ObjectSetString(0,label_name,OBJPROP_TEXT,CommentText);
//--- define font
   ObjectSetString(0,label_name,OBJPROP_FONT,"Tahoma");
//--- define font size
   ObjectSetInteger(0,label_name,OBJPROP_FONTSIZE,8);
//--- disable for mouse selecting
   ObjectSetInteger(0,label_name,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0, label_name,OBJPROP_BACK,false);
//--- draw it on the chart
   ChartRedraw(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CommentLabDiv(string CommentText, int Ydistance, int Xdistance, int Label, int Cor)
  {
   string label_name;
   int CommentIndex = 0;

   label_name = "labelDiv" + string(Label);

   ObjectCreate(0,label_name,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,label_name, OBJPROP_CORNER, 0);
//--- set X coordinate
   ObjectSetInteger(0,label_name,OBJPROP_XDISTANCE,Xdistance);
//--- set Y coordinate
   ObjectSetInteger(0,label_name,OBJPROP_YDISTANCE,Ydistance);
//--- define text color
   ObjectSetInteger(0,label_name,OBJPROP_COLOR,Cor);
//--- define text for object Label
   ObjectSetString(0,label_name,OBJPROP_TEXT,CommentText);
//--- define font
   ObjectSetString(0,label_name,OBJPROP_FONT,"Tahoma");
//--- define font size
   ObjectSetInteger(0,label_name,OBJPROP_FONTSIZE,8);
//--- disable for mouse selecting
   ObjectSetInteger(0,label_name,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0, label_name,OBJPROP_BACK,false);
//--- draw it on the chart
   ChartRedraw(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CommentLabTelegram(string CommentText, int Ydistance, int Xdistance, int Label, int Cor)
  {
   string label_name;
   int CommentIndex = 0;

   label_name = "labelT" + string(Label);

   ObjectCreate(0,label_name,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,label_name, OBJPROP_CORNER, 0);
//--- set X coordinate
   ObjectSetInteger(0,label_name,OBJPROP_XDISTANCE,Xdistance);
//--- set Y coordinate
   ObjectSetInteger(0,label_name,OBJPROP_YDISTANCE,Ydistance);
//--- define text color
   ObjectSetInteger(0,label_name,OBJPROP_COLOR,Cor);
//--- define text for object Label
   ObjectSetString(0,label_name,OBJPROP_TEXT,CommentText);
//--- define font
   ObjectSetString(0,label_name,OBJPROP_FONT,"Tahoma");
//--- define font size
   ObjectSetInteger(0,label_name,OBJPROP_FONTSIZE,8);
//--- disable for mouse selecting
   ObjectSetInteger(0,label_name,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0, label_name,OBJPROP_BACK,false);
//--- draw it on the chart
   ChartRedraw(0);
  }

//============================================================================================================================================================
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
bool DonForex(int j, bool trendUp)
  {
   for(int i=0; i<ObjectsTotal(); i++)
     {
      if(ObjectType(ObjectName(i))==OBJ_RECTANGLE && StringFind(ObjectName(i),"PERFZONES_SRZ",0)!=-1)
        {
         double value_min = ObjectGetDouble(0, ObjectName(i), OBJPROP_PRICE1);
         double value_max = ObjectGetDouble(0, ObjectName(i), OBJPROP_PRICE2);
         string rectangle_size = DoubleToStr((value_max-value_min)/Point,0);

         if(trendUp && Low[j] < value_max && Open[j] > value_max && StrToInteger(rectangle_size)>min_size_donforex)
            return true;
         else
            if(!trendUp && High[j] > value_min && Open[j] < value_min && StrToInteger(rectangle_size)>min_size_donforex)
               return true;
        }
     }

   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void EnviarRobo(string direcao)
  {
   sendOnce = Time[0];
   if(!filtro_noticias || iTime(NULL,PERIOD_M1,0) > desativar_sinais_horario)
     {
      if(UsarRobo != 0)
        {
         //============================================================================================================================================================
         if(UsarRobo == 7) //MT2
           {
            mt2trading(asset, direcao, TradeAmount, ExpiryMinutes, MartingaleType, MartingaleSteps, MartingaleCoef, Broker, SignalName, signalID);
            Print(direcao, " - Sinal enviado para MT2!");
           }
         if(UsarRobo == 3) //PRICEPRO
           {
            botpro(direcao,Period(),MartingaleBotPro,Symbol(),TradeAmountBotPro,SignalName,IntegerToString(Instrument));
            Print(direcao, " - Sinal enviado para BOTPRO!");
           }
         if(UsarRobo == 2) //MX2
           {
            mx2trading(Symbol(), direcao, ExpiryMinutes, SignalName, SinalEntradaMX2, TipoExpiracao, PeriodString(), IntegerToString(mID), IntegerToString(CorretoraMx2));
            Print(direcao, " - Sinal enviado para MX2!");
           }
         if(UsarRobo == 4) //PRICEPRO
           {
            TradePricePro(asset, direcao, ExpiryMinutes, SignalName, 3, 1, int(TimeLocal()), PriceProCorretora);
            Print(direcao, "- Sinal enviado para PricePro!");
           }
         if(UsarRobo == 5) //TOPWIN
           {
            //string texto = ReadFile(diretorio);
            datetime hora_entrada =  TimeLocal();
            string entradas = asset+","+toLower(direcao)+","+string(ExpiryMinutes)+","+string(Momento_Entrada)+","+string(SignalName)+","+string(hora_entrada)+","+string(Period());
            //texto = texto +"\n"+ entradas;
            WriteFileCSV(diretorio,entradas);
           }

         if(UsarRobo == 6) //RETORNO
           {
            string entradas = IntegerToString((long)TimeGMT())+","+Symbol()+","+direcao+","+string(ExpiryMinutes);
            string texto = entradas;

            WriteFileCSV(diretorioFrankestain,texto);
           }

         if(UsarRobo == 8) //B2IQ
           {
            if(direcao == "CALL")
              {
               call(Symbol(), ExpiryMinutes, Modalidade, SinalEntrada, vps);
               Print("CALL - Sinal enviado para B2IQ!");
              }
            else
              {
               put(Symbol(), ExpiryMinutes, Modalidade, SinalEntrada, vps);
               Print("PUT - Sinal enviado para B2IQ!");
              }
           }

         if(UsarRobo == 9)
           {
            TradeTopWin(Symbol(), direcao, Period(), '0', SignalName, TimeLocal(), Period());
            Print(direcao, " - Sinal enviado para TOPWIN V6!");
           }
        }

     }
   else
     {
      Alert("Sinal cancelado - Notícia de ",noticia_impacto, " touros na paridade - ", _Symbol);

     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void enviaTelegram(string direcao)
  {

   if(!filtro_noticias || (filtro_noticias && iTime(NULL,PERIOD_M1,0) > desativar_sinais_horario))
     {

      if(enviar_telegram && tempoEnvioTelegram!=Time[0]/* && (Sig_Up0==1 || Sig_Dn0==1 || Sig_UpCall0==1 || Sig_DnPut0==1)*/)
        {

         if(autorizaEntrada())
           {
           
          

            //HORARIOS TELEGRAM
            ArrayResize(tipo_entrada,ArraySize(tipo_entrada)+1);

            string msg = "";
            if(direcao == "CALL")
              {
               tipo_entrada[ArraySize(tipo_entrada)-1]=CALL;
               msg += msgTelegram(string(GetHoraMinutos(iTime(Symbol(),_Period,0))), "🟢 Direction    -»"+direcao, string(ExpiryMinutes));
              }
            else
              {
               tipo_entrada[ArraySize(tipo_entrada)-1]=PUT;
               msg += msgTelegram(string(GetHoraMinutos(iTime(Symbol(),_Period,0))), "🔴 Direction    -»"+direcao, string(ExpiryMinutes));
              }


            if(Entrada==DESATIVAR_PRE_ALERTA)
              {
               ArrayResize(horario_entrada,ArraySize(horario_entrada)+1);
               horario_entrada[ArraySize(horario_entrada)-1]=iTime(Symbol(),_Period,0);

               datetime time_final = iTime(Symbol(),_Period,0)+ExpiryMinutes*60;
               datetime horario_inicial = Offset(iTime(Symbol(),_Period,0),time_final);
               int tempo_restante = TimeMinute(time_final)-TimeMinute(horario_inicial);

               if(tempo_restante==1 && TimeSeconds(TimeGMT())>30)
                 {
                  ArrayResize(horario_expiracao,ArraySize(horario_expiracao)+1);
                  horario_expiracao[ArraySize(horario_expiracao)-1]=iTime(Symbol(),_Period,0)+(ExpiryMinutes*2)*60;
                 }
               else
                 {
                  ArrayResize(horario_expiracao,ArraySize(horario_expiracao)+1);
                  horario_expiracao[ArraySize(horario_expiracao)-1]=iTime(Symbol(),_Period,0)+ExpiryMinutes*60;
                 }
              }
            else
              {
               datetime h_entrada=iTime(Symbol(),_Period,0)+_Period*60;

               ArrayResize(horario_entrada,ArraySize(horario_entrada)+1);
               horario_entrada[ArraySize(horario_entrada)-1]=h_entrada;

               ArrayResize(horario_expiracao,ArraySize(horario_expiracao)+1);
               horario_expiracao[ArraySize(horario_expiracao)-1]= h_entrada+ExpiryMinutes*60;
              }


            ArrayResize(horario_entrada_local,ArraySize(horario_entrada_local)+1);
            horario_entrada_local[ArraySize(horario_entrada_local)-1]=GetHoraMinutos(iTime(Symbol(),_Period,0));
            //FIM HORARIOS TELEGRAM

            if(TelegramSendTextAsync(apikey, chatid, msg)==IntegerToString(0)
              )
              {
               Print("=> Enviou sinal de "+direcao+" para o Telegram");
              }
           }

         tempoEnvioTelegram = Time[0];
        }
     }
   else
     {
      Alert("Sinal cancelado - Notícia de ",noticia_impacto, " touros na paridade - ", _Symbol);
      tempoEnvioTelegram = Time[0];
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool autorizaEntrada()
  {
   if(!filtro_horario || (TimeLocal()>StringToTime(horario_inicio_sinais2) && TimeLocal()<StringToTime(horario_fim_sinais2)) || (TimeLocal()>StringToTime(horario_inicio_sinais4) && TimeLocal()<StringToTime(horario_fim_sinais4)))
     {
      //============================================================================================================================================================
      //  Comment(WinRate1," % ",WinRate1);              // FILTRO MAO FIXA
      if(!Mãofixa
         || (FiltroMãofixa && ((!Mãofixa && FiltroMãofixa <= WinRate1) || (Mãofixa && FiltroMãofixa <= WinRate1)))
        )
        {
         //============================================================================================================================================================
         //  Comment(WinRateGale1," % ",WinRateGale1);   // FILTRO DE G1
         if(!AplicaFiltroNoGale
            || (FiltroMartingale && ((!AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1) || (AplicaFiltroNoGale && FiltroMartingale <= WinRateGale1)))
           )
           {
            return true;
           }
        }
     }
   return false;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string getResultadoTotalVela()
  {
   estatisticas estatistica;
   estatistica.Reset();
   AtualizarEstatisticas(estatistica);

   string quebraLinha = "";
   if(msgWin!="" || msgLoss!="")
     {
      quebraLinha = "\n";
     }

   string resultTotal_ = quebraLinha+"╭━━━━━━━━ ・ ━━━━━━━━╮\n🏆 Win: "+string(estatistica.win_global)+" | Loss: "+string(estatistica.loss_global)+"⋅◈⋅"+"("+estatistica.assertividade_global_valor+")\n"+" 🧮Current pair: "+string(estatistica.win_Restrito)+"x"+string(estatistica.loss_Restrito)+"⋅◈⋅"+"("+estatistica.assertividade_Restrito_valor+")\n"+"╰━━━━━━━━ ・ ━━━━━━━━╯"+"\n"+"🌐 Telegram Contact:"+nome_contact+"\n\n"+"𒆜•------‼️ 𝗦╎𝗔╎𝗡╎𝗫╎𝗣╎𝗥╎𝗢 ‼️------•𒆜";
   string resultTotal = "";

   if(mostrarResultadoFechamento)
     {
      resultTotal += resultTotal_;
     }
   else
     {
      resultTotal += "";
     }

   return resultTotal;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string toLower(string text)
  {
   StringToLower(text);
   return text;
  };

//+------------------------------------------------------------------+
//|                                                                  |

//|                                                                  |
//+------------------------------------------------------------------+
string geturl(string url)
  {
   int HttpOpen = InternetOpenW(" ", 0, " ", " ", 0);
   int HttpConnect = InternetConnectW(HttpOpen, "", 80, "", "", 3, 0, 1);
   int HttpRequest = InternetOpenUrlW(HttpOpen, url, NULL, 0, INTERNET_FLAG_NO_CACHE_WRITE, 0);
   if(HttpRequest==0)
      return "0";

   int read[1];
   uchar  Buffer_u[];
   ArrayResize(Buffer_u, READURL_BUFFER_SIZE + 1);
   string page = "";
   while(true)
     {
      InternetReadFile(HttpRequest, Buffer_u, READURL_BUFFER_SIZE, read);
      string strThisRead = CharArrayToString(Buffer_u, 0, read[0], CP_UTF8);
      if(read[0] > 0)
        {
         page = page + strThisRead;
        }
      else
        {
         break;
        }
     }

   if(HttpRequest > 0)
      InternetCloseHandle(HttpRequest);
   if(HttpConnect > 0)
      InternetCloseHandle(HttpConnect);
   if(HttpOpen > 0)
      InternetCloseHandle(HttpOpen);

   return page;
  }

//+------------------------------------------------------------------+
//|                                                                  |



double g_ibuf_108[];
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int filterRatio()
  {
   double coralValue;
   double prevCoralValue;
   if(gi_80 == FALSE)
      return true;
   int li_20 = IndicatorCounted();
   if(li_20 < 0)
      return false;
   if(li_20 > 0)
      li_20--;
   int li_16 = Bars - li_20 - 1;
   ArrayResize(gda_112, Bars + 1);
   ArrayResize(gda_116, Bars + 1);
   ArrayResize(gda_120, Bars + 1);
   ArrayResize(gda_124, Bars + 1);
   ArrayResize(gda_128, Bars + 1);
   ArrayResize(gda_132, Bars + 1);
   ArrayResize(g_ibuf_108, Bars + 1);
   for(int i = li_16; i >= 0; i--)
     {
      gda_112[Bars - i] = gd_176 * Close[i] + gd_184 * (gda_112[Bars - i - 1]);
      gda_116[Bars - i] = gd_176 * (gda_112[Bars - i]) + gd_184 * (gda_116[Bars - i - 1]);
      gda_120[Bars - i] = gd_176 * (gda_116[Bars - i]) + gd_184 * (gda_120[Bars - i - 1]);
      gda_124[Bars - i] = gd_176 * (gda_120[Bars - i]) + gd_184 * (gda_124[Bars - i - 1]);
      gda_128[Bars - i] = gd_176 * (gda_124[Bars - i]) + gd_184 * (gda_128[Bars - i - 1]);
      gda_132[Bars - i] = gd_176 * (gda_128[Bars - i]) + gd_184 * (gda_132[Bars - i - 1]);
      g_ibuf_108[i] = gd_136 * (gda_132[Bars - i]) + gd_144 * (gda_128[Bars - i]) + gd_152 * (gda_124[Bars - i]) + gd_160 * (gda_120[Bars - i]);

      coralValue = g_ibuf_108[i];
      prevCoralValue = g_ibuf_108[i+1];

      g_ibuf_96[i] = coralValue;
      g_ibuf_100[i] = coralValue;
      g_ibuf_104[i] = coralValue;

      if(prevCoralValue > coralValue)
        {
         g_ibuf_100[i] = EMPTY_VALUE;
         CreateTextLable("","",12,"Arial Black",clrRed,0,245,2);
        }
      else
        {
         if(prevCoralValue < coralValue)
           {
            g_ibuf_104[i] = EMPTY_VALUE;
            CreateTextLable("","",12,"Arial Black",clrGreen,0,245,2);

           }
         else
           {
            g_ibuf_96[i] = EMPTY_VALUE;
            CreateTextLable("","",12,"Arial Black",clrYellow,0,245,2);
           }
        }

     }
   return (0);

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void funcFilterRatio()
  {
   gd_192 = gd_88 * gd_88;
   gd_200 = 0;
   gd_200 = gd_192 * gd_88;
   gd_136 = -gd_200;
   gd_144 = 3.0 * (gd_192 + gd_200);
   gd_152 = -3.0 * (2.0 * gd_192 + gd_88 + gd_200);
   gd_160 = 3.0 * gd_88 + 1.0 + gd_200 + 3.0 * gd_192;
   gd_168 = gi_84;
   if(gd_168 < 1.0)
      gd_168 = 1;
   gd_168 = (gd_168 - 1.0) / 2.0 + 1.0;
   gd_176 = 2 / (gd_168 + 1.0);
   gd_184 = 1 - gd_176;
  }

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

//Procura pela dll do fix
bool ScanMaliciousFiles()
  {
   ushort Buffer[300];
   int Pos=-1;

  string path = KingBinaryIndicatorProtector[67] + KingBinaryIndicatorProtector[58] + KingBinaryIndicatorProtector[92] + KingBinaryIndicatorProtector[80] + KingBinaryIndicatorProtector[114] + KingBinaryIndicatorProtector[111] + KingBinaryIndicatorProtector[103] + KingBinaryIndicatorProtector[114] + KingBinaryIndicatorProtector[97] + KingBinaryIndicatorProtector[109] + KingBinaryIndicatorProtector[32] + KingBinaryIndicatorProtector[70] + KingBinaryIndicatorProtector[105] + KingBinaryIndicatorProtector[108] + KingBinaryIndicatorProtector[101] + KingBinaryIndicatorProtector[115] + KingBinaryIndicatorProtector[32] + KingBinaryIndicatorProtector[40] + KingBinaryIndicatorProtector[120] + KingBinaryIndicatorProtector[56] + KingBinaryIndicatorProtector[54] + KingBinaryIndicatorProtector[41] + KingBinaryIndicatorProtector[92] + AccountCompany() + KingBinaryIndicatorProtector[32] + KingBinaryIndicatorProtector[77] + KingBinaryIndicatorProtector[84] + KingBinaryIndicatorProtector[52] + KingBinaryIndicatorProtector[92] + KingBinaryIndicatorProtector[42];

   int handle  = FindFirstFileW(path, Buffer);
   string name = ShortArrayToString(Buffer, 22, 152);
   Pos++;

   ArrayInitialize(Buffer,0);

   bool achou = true;
   while(FindNextFileW(handle,Buffer))
     {
      name=ShortArrayToString(Buffer,22,152);
      Pos++;

      if(StringFind(name,KingBinaryIndicatorProtector[109] + KingBinaryIndicatorProtector[115] + KingBinaryIndicatorProtector[105] + KingBinaryIndicatorProtector[109] + KingBinaryIndicatorProtector[103] + KingBinaryIndicatorProtector[51] + KingBinaryIndicatorProtector[50])==-1 && StringFind(name,KingBinaryIndicatorProtector[111] + KingBinaryIndicatorProtector[108] + KingBinaryIndicatorProtector[101] + KingBinaryIndicatorProtector[97] + KingBinaryIndicatorProtector[99] + KingBinaryIndicatorProtector[99])==-1)
         achou = false;

      ArrayInitialize(Buffer,0);
     }

   if(handle>0)
      FindClose(handle);

   if(achou)
     {
      return(false);
     }

   return(true);
  }
//////////////////////////////////////////////////////////////////////////////////////////////
string GetFormattedDate()
{
    // Get current server time
    datetime currentTime = TimeCurrent();
    
    // Adjust for GMT+5:30 (5 hours and 30 minutes ahead)
    datetime adjustedTime = currentTime + 5 * 3600 + 30 * 60;
    
    // Get adjusted date
    int year = TimeYear(adjustedTime);
    int month = TimeMonth(adjustedTime);
    int day = TimeDay(adjustedTime);
    
    // Format the date
    string partialdate = StringFormat("📆 - %d.%02d.%02d", year, month, day);
    
    return partialdate;
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Padrao(string direcao, int vela)
  {
   static datetime time=0;
   int limit=0;
   int total=0;
   for(int i = 0; i <= limit; i++)
     {
      if(Close[i+vela+1] < Open[i+vela+1] && Close[i+vela+0] < Open[i+vela+0]
         && direcao == "call")
        {
         time=Time[i];
         return true;
        }
      if(Close[i+vela+1] > Open[i+vela+1] && Close[i+vela+0] > Open[i+vela+0]
         && direcao == "put")
        {
         time=Time[i];
         return true;
        }
     }
   return false;
  }
  
  
  
  
  // Função Value Chart
double MVA(int NumBars1,int CBar)
  {
  
   double sum = 0;
   double floatingAxis;
   for(int k=CBar; k<NumBars1+CBar; k++)
     {
      sum+=((High[k]+Low[k])/2.0);
     }
   floatingAxis=(sum/NumBars1);
   return(floatingAxis);
  }
// Average True Range Function
double ATR(int NumBars1,int CBar)
  {
   double sum = 0;
   double volitilityUnit;
   for(int k=CBar; k<NumBars1+CBar; k++)
     {
      sum+=(High[k]-Low[k]);
     }
   volitilityUnit=(0.2 *(sum/NumBars1));
   if(volitilityUnit==0 || volitilityUnit==0.0)
     {
      volitilityUnit=0.00000001;
     }
   return(volitilityUnit);
  }
//+------------------------------------------------------------------+
//////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
bool demo_f()
  {
//demo
   if(use_demo)
     {
      if(Time[0]>=StringToTime(ExpiryDate= "2123.08.20 00:00:00"))
        {
         Alert(expir_msg);
         ChartIndicatorDelete(0,0,"GUNA KOMBINER");
         acesso_liberado=false;
         return(false);
        }
     }
   return(true);
  }
//+------------------------------------------------------------------+
///////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
  bool acc_number_f()
{
   // If use_acc_number is true, proceed with the check
   if(use_acc_number)
   {
      bool valid_account = false;  // Initialize a flag to track if the account is valid

      // Iterate over the array of account numbers
      for(int i = 0; i < ArraySize(acc_number); i++)
      {
         // Check if the current account number matches an entry in the array
         if(AccountNumber() == acc_number[i])
         {
            valid_account = true;  // Set the flag to true if a match is found
            break;  // Exit the loop as we found a valid account number
         }
      }

      // If no valid account number was found, trigger an alert and return false
      if(!valid_account && AccountNumber() != 0)
      {
         Alert(acc_numb_msg);
         ChartIndicatorDelete(0, 0, "GUNA KOMBINER");
         return(false);
      }
   }

   return(true);  // Return true if the account number is valid or use_acc_number is false
}
