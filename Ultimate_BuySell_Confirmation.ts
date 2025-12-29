# Ultimate Buy/Sell Confirmation Study
# A multi-indicator scoring system for ThinkOrSwim
# Created with precision and elegance

declare upper;

# ============================================
# INPUTS - Your Control Panel
# ============================================

# Timeframe Selection
input timeframe = {default "5m", "1m", "15m", "1d", "1w"};

# Indicator Toggles
input useSuperTrend = yes;
input useVWAP = yes;
input useRSI = yes;
input useStochRSI = yes;
input useEMACross = yes;
input useATR = yes;
input useVolume = yes;

# Signal Sensitivity
input signalThreshold = 65; # Score needed for BUY signal (0-100)
input sellThreshold = 35;   # Score below this triggers SELL signal

# Visual Options
input showBubbles = yes;
input showLabels = yes;
input showScoreLabel = yes;
input paintBars = yes;

# ============================================
# TIMEFRAME ADAPTIVE PARAMETERS
# ============================================

# SuperTrend Parameters
def st_length = if timeframe == timeframe."1m" then 7
                else if timeframe == timeframe."5m" then 10
                else if timeframe == timeframe."15m" then 12
                else if timeframe == timeframe."1d" then 14
                else 20; # 1w

def st_multiplier = if timeframe == timeframe."1m" then 2.0
                    else if timeframe == timeframe."5m" then 2.5
                    else if timeframe == timeframe."15m" then 3.0
                    else if timeframe == timeframe."1d" then 3.5
                    else 4.0; # 1w

# RSI Parameters
def rsi_length = if timeframe == timeframe."1m" then 9
                 else if timeframe == timeframe."5m" then 14
                 else if timeframe == timeframe."15m" then 14
                 else if timeframe == timeframe."1d" then 14
                 else 21; # 1w

# StochRSI Parameters
def stoch_length = if timeframe == timeframe."1m" then 8
                   else if timeframe == timeframe."5m" then 14
                   else if timeframe == timeframe."15m" then 14
                   else if timeframe == timeframe."1d" then 21
                   else 21; # 1w

# EMA Parameters
def ema_fast = if timeframe == timeframe."1m" then 5
               else if timeframe == timeframe."5m" then 8
               else if timeframe == timeframe."15m" then 9
               else if timeframe == timeframe."1d" then 12
               else 13; # 1w

def ema_slow = if timeframe == timeframe."1m" then 13
               else if timeframe == timeframe."5m" then 21
               else if timeframe == timeframe."15m" then 21
               else if timeframe == timeframe."1d" then 26
               else 34; # 1w

# ATR Parameters
def atr_length = if timeframe == timeframe."1m" then 7
                 else if timeframe == timeframe."5m" then 14
                 else if timeframe == timeframe."15m" then 14
                 else if timeframe == timeframe."1d" then 14
                 else 20; # 1w

# Volume Lookback
def vol_lookback = if timeframe == timeframe."1m" then 20
                   else if timeframe == timeframe."5m" then 30
                   else if timeframe == timeframe."15m" then 40
                   else if timeframe == timeframe."1d" then 50
                   else 60; # 1w

# ============================================
# INDICATOR 1: SUPERTREND (20% Weight)
# ============================================

def atr_st = ATR(length = st_length);
def upper_band = hl2 + (st_multiplier * atr_st);
def lower_band = hl2 - (st_multiplier * atr_st);

def supertrend_up = if close[1] > supertrend_up[1] then Max(lower_band, supertrend_up[1]) else lower_band;
def supertrend_down = if close[1] < supertrend_down[1] then Min(upper_band, supertrend_down[1]) else upper_band;
def supertrend_trend = if close > supertrend_down[1] then 1 else if close < supertrend_up[1] then -1 else supertrend_trend[1];

def st_score = if useSuperTrend then
               (if supertrend_trend == 1 then 20 else 0)
               else 0;

# ============================================
# INDICATOR 2: VWAP + Standard Deviation (15% Weight)
# ============================================

def vwap_value = VWAP();
def vwap_std = StDev(close, 20);
def upper_vwap = vwap_value + vwap_std;
def lower_vwap = vwap_value - vwap_std;

# Score based on position relative to VWAP
def vwap_score = if useVWAP then
                 (if close > upper_vwap then 15
                  else if close > vwap_value then 10
                  else if close > lower_vwap then 5
                  else 0)
                 else 0;

# ============================================
# INDICATOR 3: RSI (15% Weight)
# ============================================

def rsi = RSI(price = close, length = rsi_length);

def rsi_score = if useRSI then
                (if rsi > 70 then 0        # Overbought - caution
                 else if rsi > 60 then 10  # Strong but not extreme
                 else if rsi > 50 then 15  # Bullish momentum
                 else if rsi > 40 then 10  # Neutral
                 else if rsi > 30 then 5   # Oversold - potential reversal
                 else 3)                    # Very oversold
                else 0;

# ============================================
# INDICATOR 4: STOCHASTIC RSI (10% Weight)
# ============================================

def rsi_for_stoch = RSI(price = close, length = stoch_length);
def stoch_k = 100 * (rsi_for_stoch - Lowest(rsi_for_stoch, stoch_length)) / 
              (Highest(rsi_for_stoch, stoch_length) - Lowest(rsi_for_stoch, stoch_length));
def stoch_d = Average(stoch_k, 3);

def stochrsi_score = if useStochRSI then
                     (if stoch_k < 20 and stoch_k > stoch_d then 10  # Oversold + turning up
                      else if stoch_k > 20 and stoch_k < 80 and stoch_k > stoch_d then 8
                      else if stoch_k > 80 then 0  # Overbought
                      else 3)
                     else 0;

# ============================================
# INDICATOR 5: EMA CROSSOVER (15% Weight)
# ============================================

def ema_f = ExpAverage(close, ema_fast);
def ema_s = ExpAverage(close, ema_slow);
def ema_cross = ema_f - ema_s;
def ema_cross_prev = ema_cross[1];

# Recent crossover detection
def bullish_cross = ema_f crosses above ema_s;
def bearish_cross = ema_f crosses below ema_s;
def bars_since_bull_cross = if bullish_cross then 0 else bars_since_bull_cross[1] + 1;
def bars_since_bear_cross = if bearish_cross then 0 else bars_since_bear_cross[1] + 1;

def ema_score = if useEMACross then
                (if ema_f > ema_s and bars_since_bull_cross < 5 then 15  # Fresh bullish cross
                 else if ema_f > ema_s then 12  # Sustained bullish
                 else if ema_f < ema_s and bars_since_bear_cross < 5 then 0  # Fresh bearish
                 else 5)  # Weak or transitioning
                else 0;

# ============================================
# INDICATOR 6: ATR VOLATILITY FILTER (10% Weight)
# ============================================

def atr_current = ATR(length = atr_length);
def atr_avg = Average(atr_current, atr_length);
def atr_ratio = atr_current / atr_avg;

# High volatility can mean opportunity OR risk
def atr_score = if useATR then
                (if atr_ratio > 1.5 then 5   # Very high volatility - caution
                 else if atr_ratio > 1.2 then 10  # Elevated - good for breakouts
                 else if atr_ratio > 0.8 then 8   # Normal
                 else 3)  # Low volatility - harder to profit
                else 0;

# ============================================
# INDICATOR 7: VOLUME ANALYSIS (15% Weight)
# ============================================

def vol_avg = Average(volume, vol_lookback);
def vol_ratio = volume / vol_avg;
def price_change = (close - close[1]) / close[1] * 100;

def volume_score = if useVolume then
                   (if vol_ratio > 2.0 and price_change > 0 then 15  # Strong bullish volume
                    else if vol_ratio > 1.5 and price_change > 0 then 12
                    else if vol_ratio > 1.0 and price_change > 0 then 10
                    else if vol_ratio > 1.0 then 5
                    else 3)  # Below average volume
                   else 0;

# ============================================
# AGGREGATE SCORING SYSTEM
# ============================================

def total_score = st_score + vwap_score + rsi_score + stochrsi_score + 
                  ema_score + atr_score + volume_score;

# Normalize to 0-100 scale
def max_possible_score = 20 + 15 + 15 + 10 + 15 + 10 + 15; # 100
def conviction_score = total_score; # Already out of 100

# Signal Generation
def buy_signal = conviction_score >= signalThreshold and conviction_score[1] < signalThreshold;
def sell_signal = conviction_score <= sellThreshold and conviction_score[1] > sellThreshold;
def is_bullish = conviction_score >= signalThreshold;
def is_bearish = conviction_score <= sellThreshold;

# ============================================
# VISUAL ELEMENTS
# ============================================

# Plot the score as a hidden line (can be made visible if desired)
plot ConvictionScore = conviction_score;
ConvictionScore.SetDefaultColor(Color.DARK_GRAY);
ConvictionScore.Hide();

# Paint bars based on conviction
AssignPriceColor(if !paintBars then Color.CURRENT
                 else if conviction_score >= 75 then Color.DARK_GREEN
                 else if conviction_score >= signalThreshold then Color.GREEN
                 else if conviction_score <= 25 then Color.DARK_RED
                 else if conviction_score <= sellThreshold then Color.RED
                 else Color.GRAY);

# Buy Signal Bubbles
AddChartBubble(showBubbles and buy_signal, low * 0.998, "BUY\n" + conviction_score, 
               Color.GREEN, no);

# Sell Signal Bubbles
AddChartBubble(showBubbles and sell_signal, high * 1.002, "SELL\n" + conviction_score, 
               Color.RED, yes);

# Signal Labels on right axis
AddLabel(showLabels, 
         if is_bullish then "BULLISH SIGNAL" 
         else if is_bearish then "BEARISH SIGNAL" 
         else "NEUTRAL",
         if is_bullish then Color.GREEN
         else if is_bearish then Color.RED
         else Color.GRAY);

# Score Display Label
AddLabel(showScoreLabel, "Conviction: " + conviction_score + "/100",
         if conviction_score >= 70 then Color.DARK_GREEN
         else if conviction_score >= 50 then Color.GREEN
         else if conviction_score >= 30 then Color.YELLOW
         else Color.RED);

# Component Breakdown Label (for debugging/tuning)
AddLabel(no, "ST:" + st_score + " V:" + vwap_score + " R:" + rsi_score + 
         " SR:" + stochrsi_score + " E:" + ema_score + " A:" + atr_score + 
         " Vol:" + volume_score, Color.GRAY);

# ============================================
# LOWER STUDY COMPANION (Optional)
# ============================================
# To see the score visually, add this as a SEPARATE lower study:
#
# declare lower;
# input scoreFromUpper = close; # You'll plot ConvictionScore from upper
# plot Score = scoreFromUpper;
# plot BuyZone = 65;
# plot SellZone = 35;
# plot MidLine = 50;
# Score.SetDefaultColor(Color.CYAN);
# BuyZone.SetDefaultColor(Color.GREEN);
# SellZone.SetDefaultColor(Color.RED);
# MidLine.SetDefaultColor(Color.GRAY);
