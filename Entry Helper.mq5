//+------------------------------------------------------------------+
//|                                            Entry Helper.mq5 |
//|                                    Copyright 2025, Yousuf Mesalm. |
//|  www.yousufmesalm.com | WhatsApp +201006179048 | Upwork: https://www.upwork.com/freelancers/youssefmesalm |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, Yousuf Mesalm. www.yousufmesalm.com | WhatsApp +201006179048"
#property link      "https://www.yousufmesalm.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 2
#property indicator_plots   2

//---- plot
#property indicator_label1  "Price Equalibrium"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
#property indicator_label2  "Liquid Equalibrium"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrBlue
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
input ENUM_TIMEFRAMES TF=PERIOD_CURRENT;
int input rsiLengthInput = 50 ; // Price Equalibrium
input ENUM_APPLIED_PRICE rsiSourceInput = PRICE_CLOSE ; //Source
input ENUM_MA_METHOD maTypeInput = MODE_EMA; //MA Type
input int maLengthInput = 60; // Liquid Equalibrium

int RSIHandle=0,RSIMAHandle=0;
double RSIMA[],RSI[];
//+------------------------------------------------------------------+
//|  www.yousufmesalm.com | WhatsApp +201006179048 | Upwork: https://www.upwork.com/freelancers/youssefmesalm |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,RSI,INDICATOR_DATA);
   SetIndexBuffer(1,RSIMA,INDICATOR_DATA);

   RSIHandle=iRSI(Symbol(),TF,rsiLengthInput,rsiSourceInput);
   RSIMAHandle=iMA(Symbol(),TF,maLengthInput,0,MODE_SMA,RSIHandle);

   ArraySetAsSeries(RSI,true);
   ArraySetAsSeries(RSIMA,true);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|  www.yousufmesalm.com | WhatsApp +201006179048 | Upwork: https://www.upwork.com/freelancers/youssefmesalm |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---


   int limit=rates_total-prev_calculated;

//--- if it's the first call
   if(limit>1)
     {

      limit=rates_total-1;

     }

   for(int i=limit; i>WRONG_VALUE&& !IsStopped(); i--)
     {
      double RSItemp[1],RSIMATEMP[1];
      CopyBuffer(RSIHandle,0,i,1,RSItemp);
      CopyBuffer(RSIMAHandle,0,i,1,RSIMATEMP);
      RSI[i]=RSItemp[0];
      RSIMA[i]=RSIMATEMP[0];
     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
