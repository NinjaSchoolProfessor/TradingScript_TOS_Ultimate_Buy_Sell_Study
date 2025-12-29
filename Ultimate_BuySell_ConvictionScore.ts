# Ultimate Buy/Sell - Conviction Score Visualizer
# LOWER STUDY - Shows the scoring system visually
# Add this as a separate lower study below your main chart

declare lower;

# ============================================
# INPUTS - Must match your upper study
# ============================================

input timeframe = {default "5m", "1m", "15m", "1d", "1w"};
input useSuperTrend = yes;
input useVWAP = yes;
input useRSI = yes;
input useStochRSI = yes;
input useEMACross = yes;
input useATR = yes;
input useVolume = yes;

# Signal Thresholds (for reference lines)
input signalThreshold = 65;
input sellThreshold = 35;

# Visual Options
input showComponentBars = yes;  # Show individual indicator contributions

# ============================================
# REPLICATE THE SCORING LOGIC
# (This is necessary since TOS doesn't allow cross-study data passing cleanly)
# ============================================

# Timeframe Adaptive Parameters (same as upper study)
def st_length = if timeframe == timeframe."1m" then 7
                else if timeframe == timeframe."5m" then 10
                else if timeframe == timeframe."15m" then 12
                else if timeframe == timeframe."1d" then 14
                else 20;

def st_multiplier = if timeframe == timeframe."1m" then 2.0
                    else if timeframe == timeframe."5m" then 2.5
                    else if timeframe == timeframe."15m" then 3.0
                    else if timeframe == timeframe."1d" then 3.5
                    else 4.0;

def rsi_length = if timeframe == timeframe."1m" then 9
                 else if timeframe == timeframe."5m" then 14
                 else if timeframe == timeframe."15m" then 14
                 else if timeframe == timeframe."1d" then 14
                 else 21;

def stoch_length = if timeframe == timeframe."1m" then 8
                   else if timeframe == timeframe."5m" then 14
                   else if timeframe == timeframe."15m" then 14
                   else if timeframe == timeframe."1d" then 21
                   else 21;

def ema_fast = if timeframe == timeframe."1m" then 5
               else if timeframe == timeframe."5m" then 8
               else if timeframe == timeframe."15m" then 9
               else if timeframe == timeframe."1d" then 12
               else 13;

def ema_slow = if timeframe == timeframe."1m" then 13
               else if timeframe == timeframe."5m" then 21
               else if timeframe == timeframe."15m" then 21
               else if timeframe == timeframe."1d" then 26
               else 34;

def atr_length = if timeframe == timeframe."1m" then 7
                 else if timeframe == timeframe."5m" then 14
                 else if timeframe == timeframe."15m" then 14
                 else if timeframe == timeframe."1d" then 14
                 else 20;

def vol_lookback = if timeframe == timeframe."1m" then 20
                   else if timeframe == timeframe."5m" then 30
                   else if timeframe == timeframe."15m" then 40
                   else if timeframe == timeframe."1d" then 50
                   else 60;

# SuperTrend
def atr_st = ATR(length = st_length);
def upper_band = hl2 + (st_multiplier * atr_st);
def lower_band = hl2 - (st_multiplier * atr_st);
def supertrend_up = if close[1] > supertrend_up[1] then Max(lower_band, supertrend_up[1]) else lower_band;
def supertrend_down = if close[1] < supertrend_down[1] then Min(upper_band, supertrend_down[1]) else upper_band;
def supertrend_trend = if close > supertrend_down[1] then 1 else if close < supertrend_up[1] then -1 else supertrend_trend[1];
def st_score = if useSuperTrend then (if supertrend_trend == 1 then 20 else 0) else 0;

# VWAP
def vwap_value = VWAP();
def vwap_std = StDev(close, 20);
def upper_vwap = vwap_value + vwap_std;
def lower_vwap = vwap_value - vwap_std;
def vwap_score = if useVWAP then
                 (if close > upper_vwap then 15
                  else if close > vwap_value then 10
                  else if close > lower_vwap then 5
                  else 0) else 0;

# RSI
def rsi = RSI(price = close, length = rsi_length);
def rsi_score = if useRSI then
                (if rsi > 70 then 0
                 else if rsi > 60 then 10
                 else if rsi > 50 then 15
                 else if rsi > 40 then 10
                 else if rsi > 30 then 5
                 else 3) else 0;

# StochRSI
def rsi_for_stoch = RSI(price = close, length = stoch_length);
def stoch_k = 100 * (rsi_for_stoch - Lowest(rsi_for_stoch, stoch_length)) / 
              (Highest(rsi_for_stoch, stoch_length) - Lowest(rsi_for_stoch, stoch_length));
def stoch_d = Average(stoch_k, 3);
def stochrsi_score = if useStochRSI then
                     (if stoch_k < 20 and stoch_k > stoch_d then 10
                      else if stoch_k > 20 and stoch_k < 80 and stoch_k > stoch_d then 8
                      else if stoch_k > 80 then 0
                      else 3) else 0;

# EMA Crossover
def ema_f = ExpAverage(close, ema_fast);
def ema_s = ExpAverage(close, ema_slow);
def bullish_cross = ema_f crosses above ema_s;
def bearish_cross = ema_f crosses below ema_s;
def bars_since_bull_cross = if bullish_cross then 0 else bars_since_bull_cross[1] + 1;
def bars_since_bear_cross = if bearish_cross then 0 else bars_since_bear_cross[1] + 1;
def ema_score = if useEMACross then
                (if ema_f > ema_s and bars_since_bull_cross < 5 then 15
                 else if ema_f > ema_s then 12
                 else if ema_f < ema_s and bars_since_bear_cross < 5 then 0
                 else 5) else 0;

# ATR
def atr_current = ATR(length = atr_length);
def atr_avg = Average(atr_current, atr_length);
def atr_ratio = atr_current / atr_avg;
def atr_score = if useATR then
                (if atr_ratio > 1.5 then 5
                 else if atr_ratio > 1.2 then 10
                 else if atr_ratio > 0.8 then 8
                 else 3) else 0;

# Volume
def vol_avg = Average(volume, vol_lookback);
def vol_ratio = volume / vol_avg;
def price_change = (close - close[1]) / close[1] * 100;
def volume_score = if useVolume then
                   (if vol_ratio > 2.0 and price_change > 0 then 15
                    else if vol_ratio > 1.5 and price_change > 0 then 12
                    else if vol_ratio > 1.0 and price_change > 0 then 10
                    else if vol_ratio > 1.0 then 5
                    else 3) else 0;

# Total Score
def conviction_score = st_score + vwap_score + rsi_score + stochrsi_score + 
                       ema_score + atr_score + volume_score;

# ============================================
# PLOTS
# ============================================

# Main conviction score line
plot ConvictionLine = conviction_score;
ConvictionLine.SetDefaultColor(Color.CYAN);
ConvictionLine.SetLineWeight(3);

# Threshold lines
plot BuyThreshold = signalThreshold;
BuyThreshold.SetDefaultColor(Color.GREEN);
BuyThreshold.SetStyle(Curve.SHORT_DASH);

plot SellThreshold = sellThreshold;
SellThreshold.SetDefaultColor(Color.RED);
SellThreshold.SetStyle(Curve.SHORT_DASH);

plot MidLine = 50;
MidLine.SetDefaultColor(Color.GRAY);
MidLine.SetStyle(Curve.POINTS);

# Optional: Individual component bars (stacked view)
plot ST_Bar = if showComponentBars then st_score else Double.NaN;
plot VWAP_Bar = if showComponentBars then ST_Bar + vwap_score else Double.NaN;
plot RSI_Bar = if showComponentBars then VWAP_Bar + rsi_score else Double.NaN;
plot StochRSI_Bar = if showComponentBars then RSI_Bar + stochrsi_score else Double.NaN;
plot EMA_Bar = if showComponentBars then StochRSI_Bar + ema_score else Double.NaN;
plot ATR_Bar = if showComponentBars then EMA_Bar + atr_score else Double.NaN;
plot Vol_Bar = if showComponentBars then ATR_Bar + volume_score else Double.NaN;

ST_Bar.SetDefaultColor(Color.DARK_GREEN);
ST_Bar.SetPaintingStrategy(PaintingStrategy.HISTOGRAM);
ST_Bar.SetLineWeight(1);
ST_Bar.HideTitle();
ST_Bar.HideBubble();

# Cloud showing conviction zones
AddCloud(ConvictionLine, signalThreshold, Color.DARK_GREEN, Color.CURRENT);
AddCloud(sellThreshold, ConvictionLine, Color.DARK_RED, Color.CURRENT);

# Labels showing current readings
AddLabel(yes, "Score: " + conviction_score, 
         if conviction_score >= signalThreshold then Color.GREEN
         else if conviction_score <= sellThreshold then Color.RED
         else Color.YELLOW);

AddLabel(yes, "Components: ST=" + st_score + " VP=" + vwap_score + " RSI=" + rsi_score + 
         " StRSI=" + stochrsi_score + " EMA=" + ema_score + " ATR=" + atr_score + " Vol=" + volume_score,
         Color.GRAY);
