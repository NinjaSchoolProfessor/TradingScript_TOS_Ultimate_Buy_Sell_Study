# Advanced Customization Guide
## For Power Users & System Tweakers

---

## 🎛️ Modifying Indicator Weights

### Current Weight Distribution
```thinkscript
SuperTrend:   20 points (20%)
VWAP:         15 points (15%)
RSI:          15 points (15%)
StochRSI:     10 points (10%)
EMA Cross:    15 points (15%)
ATR:          10 points (10%)
Volume:       15 points (15%)
─────────────────────────
Total:       100 points (100%)
```

### How to Adjust Weights

**Step 1**: Locate the scoring sections in the code

**Step 2**: Modify the maximum points for each indicator

**Example: Make SuperTrend More Important**
```thinkscript
# Original
def st_score = if useSuperTrend then
               (if supertrend_trend == 1 then 20 else 0)
               else 0;

# Modified (increase to 30)
def st_score = if useSuperTrend then
               (if supertrend_trend == 1 then 30 else 0)
               else 0;
```

**Step 3**: Adjust total possible score
```thinkscript
# Update this line
def max_possible_score = 30 + 15 + 15 + 10 + 15 + 10 + 15; # 110

# Then normalize
def conviction_score = (total_score / max_possible_score) * 100;
```

### Custom Weight Profiles

#### Trend-Following Profile
```thinkscript
SuperTrend:   30 points (emphasis on trend)
VWAP:         10 points
RSI:          10 points
StochRSI:      5 points
EMA Cross:    25 points (emphasis on trend)
ATR:          10 points
Volume:       10 points
Total:       100 points
```

#### Mean Reversion Profile
```thinkscript
SuperTrend:   10 points
VWAP:         20 points (emphasis on value)
RSI:          25 points (emphasis on extremes)
StochRSI:     20 points (emphasis on reversal)
EMA Cross:    10 points
ATR:          10 points
Volume:        5 points
Total:       100 points
```

#### Volume-Focused Profile (Breakout Trading)
```thinkscript
SuperTrend:   15 points
VWAP:         15 points
RSI:          10 points
StochRSI:      5 points
EMA Cross:    10 points
ATR:          15 points (volatility = opportunity)
Volume:       30 points (emphasis on volume)
Total:       100 points
```

---

## 🔧 Adding New Indicators

### Template for Adding Indicators

```thinkscript
# ============================================
# INDICATOR X: [NAME] ([WEIGHT]% Weight)
# ============================================

# Step 1: Calculate the indicator
def indicator_value = YourIndicatorCalculation();

# Step 2: Define timeframe-adaptive parameters (if needed)
def indicator_length = if timeframe == timeframe."1m" then 7
                       else if timeframe == timeframe."5m" then 10
                       else if timeframe == timeframe."15m" then 12
                       else if timeframe == timeframe."1d" then 14
                       else 20; # 1w

# Step 3: Create scoring logic
def indicator_score = if useIndicatorX then
                      (if [condition_for_max_score] then 15
                       else if [condition_for_medium_score] then 10
                       else if [condition_for_low_score] then 5
                       else 0)
                      else 0;

# Step 4: Add to aggregate score
def total_score = st_score + vwap_score + ... + indicator_score;

# Step 5: Update max possible score
def max_possible_score = 20 + 15 + ... + 15; # Include your new weight

# Step 6: Add to component label
AddLabel(no, "... + IX=" + indicator_score, Color.GRAY);
```

### Example: Adding MACD

```thinkscript
# ============================================
# INDICATOR 8: MACD (15% Weight)
# ============================================

input useMACD = yes;

# Calculate MACD
def macd_fast = 12;
def macd_slow = 26;
def macd_signal = 9;

def macd_value = ExpAverage(close, macd_fast) - ExpAverage(close, macd_slow);
def macd_avg = ExpAverage(macd_value, macd_signal);
def macd_diff = macd_value - macd_avg;

# Detect recent crossovers
def macd_bull_cross = macd_value crosses above macd_avg;
def macd_bear_cross = macd_value crosses below macd_avg;
def bars_since_macd_bull = if macd_bull_cross then 0 else bars_since_macd_bull[1] + 1;

# Scoring logic
def macd_score = if useMACD then
                 (if macd_value > macd_avg and bars_since_macd_bull < 5 then 15
                  else if macd_value > macd_avg then 12
                  else if macd_value < macd_avg and macd_diff < macd_diff[1] then 5
                  else 0)
                 else 0;

# Add to total (adjust other weights to maintain 100 total)
def total_score = st_score + vwap_score + rsi_score + stochrsi_score + 
                  ema_score + atr_score + volume_score + macd_score;
```

### Example: Adding Bollinger Bands

```thinkscript
# ============================================
# INDICATOR 9: BOLLINGER BANDS (10% Weight)
# ============================================

input useBollingerBands = yes;
input bb_length = 20;
input bb_std_dev = 2.0;

# Calculate Bollinger Bands
def bb_mid = SimpleMovingAvg(close, bb_length);
def bb_std = StDev(close, bb_length);
def bb_upper = bb_mid + (bb_std_dev * bb_std);
def bb_lower = bb_mid - (bb_std_dev * bb_std);
def bb_width = bb_upper - bb_lower;
def bb_avg_width = Average(bb_width, bb_length);

# Scoring logic
def bb_score = if useBollingerBands then
               (if close > bb_upper then 0  # Outside upper = overbought
                else if close > bb_mid then 10  # Above middle = bullish
                else if close > bb_lower then 5  # Above lower = recovering
                else if close < bb_lower and bb_width > bb_avg_width then 8  # Oversold squeeze
                else 3)
               else 0;
```

---

## 🎨 Customizing Visual Elements

### Modify Bar Coloring Thresholds

```thinkscript
# Original
AssignPriceColor(if !paintBars then Color.CURRENT
                 else if conviction_score >= 75 then Color.DARK_GREEN
                 else if conviction_score >= signalThreshold then Color.GREEN
                 else if conviction_score <= 25 then Color.DARK_RED
                 else if conviction_score <= sellThreshold then Color.RED
                 else Color.GRAY);

# Custom: More granular colors
AssignPriceColor(if !paintBars then Color.CURRENT
                 else if conviction_score >= 80 then Color.DARK_GREEN
                 else if conviction_score >= 70 then Color.GREEN
                 else if conviction_score >= 60 then Color.LIGHT_GREEN
                 else if conviction_score >= 55 then Color.YELLOW
                 else if conviction_score >= 45 then Color.GRAY
                 else if conviction_score >= 40 then Color.ORANGE
                 else if conviction_score >= 30 then Color.LIGHT_RED
                 else if conviction_score >= 20 then Color.RED
                 else Color.DARK_RED);
```

### Add Signal Strength to Bubbles

```thinkscript
# Original
AddChartBubble(showBubbles and buy_signal, low * 0.998, "BUY\n" + conviction_score, 
               Color.GREEN, no);

# Custom: Show strength descriptor
AddChartBubble(showBubbles and buy_signal, low * 0.998, 
               "BUY\n" + conviction_score + "\n" + 
               (if conviction_score >= 80 then "STRONG" 
                else if conviction_score >= 70 then "MEDIUM" 
                else "WEAK"),
               if conviction_score >= 75 then Color.DARK_GREEN else Color.GREEN, 
               no);
```

### Add Arrow Indicators

```thinkscript
# Add after bubble code
plot UpArrow = if buy_signal then low else Double.NaN;
UpArrow.SetPaintingStrategy(PaintingStrategy.ARROW_UP);
UpArrow.SetDefaultColor(Color.GREEN);
UpArrow.SetLineWeight(3);

plot DownArrow = if sell_signal then high else Double.NaN;
DownArrow.SetPaintingStrategy(PaintingStrategy.ARROW_DOWN);
DownArrow.SetDefaultColor(Color.RED);
DownArrow.SetLineWeight(3);
```

---

## 📊 Advanced Timeframe Customization

### Add New Timeframe Options

```thinkscript
# Modify the input line
input timeframe = {default "5m", "1m", "2m", "3m", "15m", "30m", "1h", "4h", "1d", "1w"};

# Add parameter mappings
def st_length = if timeframe == timeframe."1m" then 7
                else if timeframe == timeframe."2m" then 8
                else if timeframe == timeframe."3m" then 9
                else if timeframe == timeframe."5m" then 10
                else if timeframe == timeframe."15m" then 12
                else if timeframe == timeframe."30m" then 13
                else if timeframe == timeframe."1h" then 14
                else if timeframe == timeframe."4h" then 16
                else if timeframe == timeframe."1d" then 14
                else 20; # 1w
```

### Create "Auto" Timeframe Detection

```thinkscript
# Automatically detect chart timeframe
def chart_period = GetAggregationPeriod();

def st_length = if chart_period == AggregationPeriod.MIN then 7
                else if chart_period <= AggregationPeriod.FIVE_MIN then 10
                else if chart_period <= AggregationPeriod.FIFTEEN_MIN then 12
                else if chart_period <= AggregationPeriod.HOUR then 14
                else if chart_period <= AggregationPeriod.DAY then 14
                else 20;
```

---

## 🧪 Creating Adaptive Scoring

### Dynamic Threshold Based on Volatility

```thinkscript
# Instead of fixed thresholds, adjust based on ATR
def volatility_adjustment = if atr_ratio > 1.5 then 5 
                            else if atr_ratio > 1.2 then 0 
                            else -5;

def adjusted_buy_threshold = signalThreshold + volatility_adjustment;
def adjusted_sell_threshold = sellThreshold - volatility_adjustment;

# Use in signal generation
def buy_signal = conviction_score >= adjusted_buy_threshold and 
                 conviction_score[1] < adjusted_buy_threshold;
```

### Score Decay for Stale Signals

```thinkscript
# Reduce score as signal ages
def bars_since_signal = if buy_signal then 0 else bars_since_signal[1] + 1;
def decay_factor = if bars_since_signal < 5 then 1.0
                   else if bars_since_signal < 10 then 0.95
                   else if bars_since_signal < 20 then 0.90
                   else 0.85;

def adjusted_score = conviction_score * decay_factor;
```

---

## 🔬 Backtesting & Optimization

### Add Entry/Exit Markers for Analysis

```thinkscript
# Track entries and exits
def entry_price = if buy_signal then close else entry_price[1];
def exit_price = if sell_signal then close else exit_price[1];

# Calculate P&L (theoretical)
def position_pnl = if buy_signal then 0 
                   else if sell_signal then (exit_price - entry_price) / entry_price * 100
                   else position_pnl[1];

# Display in label
AddLabel(yes, "Last Trade P&L: " + AsPercent(position_pnl / 100),
         if position_pnl > 0 then Color.GREEN else Color.RED);
```

### Signal Quality Metrics

```thinkscript
# Track signal outcomes
def signal_count = if buy_signal then signal_count[1] + 1 else signal_count[1];
def win_count = if sell_signal and position_pnl > 0 then win_count[1] + 1 else win_count[1];
def win_rate = if signal_count > 0 then win_count / signal_count else 0;

AddLabel(yes, "Win Rate: " + AsPercent(win_rate), Color.CYAN);
```

---

## 🎯 Creating Instrument-Specific Profiles

### Example: Crypto-Optimized Version

```thinkscript
# Crypto tends to be more volatile and 24/7
input instrumentType = {default "Stocks", "Crypto", "Futures"};

# Adjust parameters based on instrument
def vol_multiplier = if instrumentType == instrumentType."Crypto" then 1.3
                     else if instrumentType == instrumentType."Futures" then 1.2
                     else 1.0;

def st_multiplier = if instrumentType == instrumentType."Crypto" then 3.5
                    else if instrumentType == instrumentType."Futures" then 3.0
                    else 2.5;

# Use in calculations
def atr_st = ATR(length = st_length) * vol_multiplier;
```

---

## 🛠️ Debugging Tools

### Enable Component Breakdown

```thinkscript
# Change the last label from "no" to "yes"
AddLabel(yes, "ST:" + st_score + " V:" + vwap_score + " R:" + rsi_score + 
         " SR:" + stochrsi_score + " E:" + ema_score + " A:" + atr_score + 
         " Vol:" + volume_score, Color.GRAY);
```

### Add Individual Indicator Plots

```thinkscript
# Plot each component (hidden by default)
plot ST_Component = st_score;
ST_Component.SetDefaultColor(Color.MAGENTA);
ST_Component.Hide();

plot VWAP_Component = vwap_score;
VWAP_Component.SetDefaultColor(Color.CYAN);
VWAP_Component.Hide();

# Make visible in study settings to debug
```

---

## 🎪 Multi-Signal Confluence System

### Require Multiple Consecutive Signals

```thinkscript
# Instead of single bar signal
def buy_signal = conviction_score >= signalThreshold and 
                 conviction_score[1] < signalThreshold;

# Require 2-3 bars of confirmation
def consecutive_bullish = conviction_score >= signalThreshold and
                          conviction_score[1] >= signalThreshold and
                          conviction_score[2] >= signalThreshold;

def confirmed_buy_signal = consecutive_bullish and 
                           conviction_score[3] < signalThreshold;
```

---

## 📱 Creating Alert Conditions

### Email/SMS Alerts (TOS Platform)

```thinkscript
# Add alert conditions
Alert(buy_signal, "BUY Signal Triggered - Score: " + conviction_score, 
      Alert.BAR, Sound.Chimes);

Alert(sell_signal, "SELL Signal Triggered - Score: " + conviction_score, 
      Alert.BAR, Sound.Bell);

# Extreme conviction alerts
Alert(conviction_score >= 80, "EXTREME BULLISH - Score 80+", 
      Alert.BAR, Sound.Ding);

Alert(conviction_score <= 20, "EXTREME BEARISH - Score 20-", 
      Alert.BAR, Sound.Ring);
```

---

## 🔥 Performance Optimization Tips

### 1. Reduce Calculation Load
```thinkscript
# Cache expensive calculations
def cached_vwap = if IsNaN(cached_vwap[1]) then VWAP() 
                  else if BarNumber() % 5 == 0 then VWAP() 
                  else cached_vwap[1];
```

### 2. Simplify for Lower Timeframes
```thinkscript
# Disable heavy indicators on 1m charts
input useStochRSI = if timeframe == timeframe."1m" then no else yes;
```

### 3. Limit Historical Lookback
```thinkscript
# Only calculate for recent bars
def enable_calculation = BarNumber() > 100;

def st_score = if enable_calculation and useSuperTrend then
               (if supertrend_trend == 1 then 20 else 0)
               else 0;
```

---

## 🎓 Examples of Complete Custom Builds

### Minimal Day Trader Version
```thinkscript
# Only use the fastest, most actionable indicators
input useSuperTrend = yes;      # 30 points
input useVWAP = yes;            # 25 points
input useStochRSI = yes;        # 25 points
input useVolume = yes;          # 20 points
input useRSI = no;
input useEMACross = no;
input useATR = no;

# Adjust signal threshold for faster entries
input signalThreshold = 60;
```

### Position Trader Version
```thinkscript
# Focus on trend and value, ignore fast oscillators
input useSuperTrend = yes;      # 35 points
input useVWAP = no;             # Daily VWAP not as relevant
input useRSI = yes;             # 20 points
input useStochRSI = no;
input useEMACross = yes;        # 30 points
input useATR = yes;             # 15 points
input useVolume = no;           # Weekly volume less important

# Higher threshold for quality
input signalThreshold = 75;
```

---

## 💡 Pro Customization Tips

1. **Test One Change at a Time**: Modify one thing, paper trade it, evaluate
2. **Document Your Changes**: Keep notes on what you changed and why
3. **Version Your Code**: Save different versions with dates
4. **Compare Against Baseline**: Always test against the default version
5. **Respect Market Conditions**: What works in trending markets may fail in choppy markets

---

## 🚀 Next-Level Ideas

### Multi-Timeframe Scoring
```thinkscript
# Get scores from multiple timeframes
def score_5m = /* your calculation */;
def score_15m = /* your calculation from 15m data */;
def score_1h = /* your calculation from 1h data */;

# Weight higher timeframes more
def multi_tf_score = (score_5m * 0.4) + (score_15m * 0.35) + (score_1h * 0.25);
```

### Machine Learning Integration
- Export signals to CSV
- Train ML model on historical signals
- Identify which indicator combinations predict best outcomes
- Re-weight indicators based on ML insights

### Sentiment Integration
- Add news sentiment API
- Social media buzz indicators
- Options flow data
- Insider trading signals

---

**Remember**: More complexity ≠ better results. Start simple, add only what adds value.

*"Perfection is achieved not when there is nothing left to add, but when there is nothing left to take away."*
