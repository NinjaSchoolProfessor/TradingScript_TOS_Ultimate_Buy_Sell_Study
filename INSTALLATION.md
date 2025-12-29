# Installation Checklist
## Get Up and Running in 5 Minutes

---

## ✅ Step-by-Step Installation

### 1. Install Main Study (REQUIRED)
- [ ] Open ThinkOrSwim
- [ ] Go to **Charts** → **Studies** → **Edit Studies**
- [ ] Click **Create** (bottom left)
- [ ] Copy ALL code from `Ultimate_BuySell_Confirmation.ts`
- [ ] Paste into the script window
- [ ] Name it: **"Ultimate Buy/Sell"**
- [ ] Click **OK**
- [ ] Click **Apply**

**Result**: You should see colored bars on your chart and labels in the top right

---

### 2. Install Lower Study (RECOMMENDED)
- [ ] Click below your main chart where it says "Add Study"
- [ ] Click **Create** (or **Edit Studies** → **Create**)
- [ ] Copy ALL code from `Ultimate_BuySell_ConvictionScore.ts`
- [ ] Paste into the script window
- [ ] Name it: **"Conviction Score"**
- [ ] Click **OK**
- [ ] Click **Apply**

**Result**: You should see a line graph showing score 0-100 with colored zones

---

### 3. Configure Settings
- [ ] Click the **gear icon** next to "Ultimate Buy/Sell" study name
- [ ] Set your **Timeframe** (match your chart: 1m, 5m, 15m, 1d, 1w)
- [ ] Adjust **Signal Threshold** (default: 65)
  - Higher = fewer, stronger signals
  - Lower = more signals, less selective
- [ ] Adjust **Sell Threshold** (default: 35)
  - Lower = earlier exit warnings
  - Higher = hold longer
- [ ] Enable/Disable visual options:
  - [ ] showBubbles (BUY/SELL markers)
  - [ ] showLabels (signal status)
  - [ ] showScoreLabel (conviction number)
  - [ ] paintBars (colored price bars)
- [ ] Click **OK**

---

### 4. Verify It's Working

**Check for these elements:**
- [ ] Price bars are colored (green, red, or gray)
- [ ] Top right shows "BULLISH SIGNAL" or "NEUTRAL" or "BEARISH SIGNAL"
- [ ] Top right shows "Conviction: XX/100"
- [ ] Lower study shows line moving between 0-100

**If you see these, it's working! ✅**

---

### 5. Customize (Optional)

- [ ] Adjust indicator toggles in settings:
  - Enable/disable SuperTrend
  - Enable/disable VWAP
  - Enable/disable RSI
  - Enable/disable StochRSI
  - Enable/disable EMACross
  - Enable/disable ATR
  - Enable/disable Volume

- [ ] Fine-tune thresholds:
  - Try 70/30 for conservative signals
  - Try 60/40 for aggressive signals

---

## 🎯 Quick Start Trading Guide

### Your First Trade
1. **Wait** for a clean break: Score goes from <50 to 65+ (or >50 to <35)
2. **Check** the lower study: Is it a strong move or weak wobble?
3. **Confirm** volume: Is volume elevated?
4. **Enter** on the signal
5. **Exit** when score drops below 50 (or earlier at 40 if aggressive)

### Day 1 Checklist
- [ ] Paper trade only
- [ ] Take 1-2 high-conviction signals (70+)
- [ ] Record entry/exit scores
- [ ] Note what worked/didn't work
- [ ] Review documentation

---

## 🐛 Troubleshooting

### "I don't see any colors"
→ Make sure "paintBars" is set to **yes** in settings

### "No bubbles appearing"
→ Make sure "showBubbles" is set to **yes**
→ Lower your signal threshold (try 60)

### "Lower study not showing"
→ Make sure you added it as a **separate** study below the chart
→ Check that your settings match between upper and lower studies

### "Signals seem delayed"
→ Lower your timeframe (1m is fastest)
→ Enable StochRSI for faster signals
→ Lower signal threshold to 60

### "Too many signals / noise"
→ Increase timeframe (15m or 1D)
→ Increase signal threshold to 70 or 75
→ Focus on SuperTrend + VWAP only

### "Getting different results than expected"
→ Verify your timeframe setting matches your chart
→ Make sure all inputs are the same in upper and lower studies
→ Check that you're using the latest version of the code

---

## 📚 Next Steps

### Within 1 Week
- [ ] Read the full DOCUMENTATION.md
- [ ] Print and keep QUICK_REFERENCE.md visible
- [ ] Paper trade 20+ signals
- [ ] Identify your optimal timeframe
- [ ] Find your preferred threshold settings

### Within 1 Month
- [ ] Go live with small position sizes
- [ ] Track win rate by score range
- [ ] Optimize for your trading style
- [ ] Read ADVANCED_CUSTOMIZATION.md
- [ ] Consider adding custom indicators

---

## 🎓 Essential Reading Order

1. **This file** (Installation Checklist) ← YOU ARE HERE
2. **QUICK_REFERENCE.md** (keep this handy always)
3. **DOCUMENTATION.md** (comprehensive guide)
4. **ADVANCED_CUSTOMIZATION.md** (when you're ready to tweak)

---

## ⚡ Quick Settings Presets

### Copy these exact settings into your study:

**Day Trader (5m chart)**
```
timeframe: 5m
signalThreshold: 65
sellThreshold: 35
All indicators: yes
paintBars: yes
showBubbles: yes
```

**Scalper (1m chart)**
```
timeframe: 1m
signalThreshold: 60
sellThreshold: 40
All indicators: yes
paintBars: yes
showBubbles: no (too busy)
```

**Swing Trader (15m chart)**
```
timeframe: 15m
signalThreshold: 70
sellThreshold: 30
All indicators: yes
paintBars: yes
showBubbles: yes
```

**Position Trader (1D chart)**
```
timeframe: 1d
signalThreshold: 75
sellThreshold: 25
All indicators: yes
paintBars: yes
showBubbles: yes
```

---

## ✅ Final Checklist

Before you start trading:
- [ ] Both studies installed and working
- [ ] Settings configured for your timeframe
- [ ] Quick reference printed/visible
- [ ] Paper trading account ready
- [ ] Stop loss strategy defined
- [ ] Position sizing calculated
- [ ] Trading journal prepared

---

## 🆘 Support

If you run into issues:
1. Double-check this installation guide
2. Verify code was copied completely (no missing lines)
3. Restart ThinkOrSwim
4. Check TOS is up to date
5. Try on a fresh chart

---

**You're ready to trade with conviction. Let's go.**

*Remember: The system measures conviction, not certainty. Trade accordingly.*
