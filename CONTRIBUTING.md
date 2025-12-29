# Contributing to Ultimate Buy/Sell Confirmation System

First off, thank you for considering contributing to this project! 🎉

This project is built by traders, for traders. Whether you're fixing a typo, reporting a bug, or adding a major feature, your contribution is valued.

---

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Features](#suggesting-features)
  - [Improving Documentation](#improving-documentation)
  - [Contributing Code](#contributing-code)
- [Development Setup](#development-setup)
- [Style Guidelines](#style-guidelines)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)

---

## 📜 Code of Conduct

This project adheres to a simple code of conduct:

- **Be respectful**: Treat everyone with respect and kindness
- **Be constructive**: Provide helpful feedback and suggestions
- **Be collaborative**: Work together toward common goals
- **Be patient**: Remember that everyone was a beginner once

Unacceptable behavior includes harassment, trolling, or any form of discrimination.

---

## 🤝 How Can I Contribute?

### Reporting Bugs

Found a bug? Help us fix it!

**Before submitting:**
1. Check if it's already reported in [Issues](https://github.com/yourusername/tos-ultimate-buysell/issues)
2. Make sure you're using the latest version
3. Test if the issue persists with default settings

**When reporting, include:**
- **Clear title**: "SuperTrend score incorrect on 1m timeframe"
- **Steps to reproduce**:
  ```
  1. Set timeframe to 1m
  2. Enable only SuperTrend indicator
  3. Observe score calculation
  ```
- **Expected behavior**: "Score should be 20 when above trend line"
- **Actual behavior**: "Score shows as 0"
- **Screenshots**: If applicable
- **Environment**:
  - TOS version: [e.g., 1.970.37]
  - Operating System: [e.g., Windows 11, macOS 14.0]
  - Study version: [e.g., 1.0.0]

**Use the bug report template** when creating an issue.

---

### Suggesting Features

Have an idea to improve the system?

**Before suggesting:**
1. Check if it's already requested in [Issues](https://github.com/yourusername/tos-ultimate-buysell/issues?q=label%3Aenhancement)
2. Consider if it aligns with the project's goals
3. Think about how it would benefit other users

**When suggesting, include:**
- **Clear title**: "Add Bollinger Bands indicator"
- **Problem it solves**: "BB can help identify volatility squeezes"
- **Proposed solution**: Describe how it would work
- **Alternatives considered**: Other approaches you thought about
- **Implementation ideas**: If you have technical suggestions

**Use the feature request template** when creating an issue.

---

### Improving Documentation

Documentation is just as important as code!

**Ways to help:**
- Fix typos or grammatical errors
- Clarify confusing sections
- Add missing examples
- Improve formatting
- Translate documentation (future)
- Create video tutorials or guides

**Process:**
1. Edit the relevant `.md` file
2. Submit a pull request
3. Explain what you changed and why

Even small improvements are appreciated!

---

### Contributing Code

Want to add features or fix bugs? Awesome!

**Types of contributions we're looking for:**
- Bug fixes
- New indicator integrations
- Performance improvements
- New timeframe support
- Enhanced visual elements
- Additional customization options

**Not sure where to start?**
- Look for issues labeled `good first issue`
- Check issues labeled `help wanted`
- Ask in [Discussions](https://github.com/yourusername/tos-ultimate-buysell/discussions)

---

## 🛠️ Development Setup

### Prerequisites
- ThinkOrSwim platform (desktop or web)
- A test trading account (paper trading recommended)
- Git installed on your machine
- Text editor (VS Code, Sublime, etc.)

### Getting Started

1. **Fork the repository**
   ```bash
   # Click "Fork" button on GitHub
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR-USERNAME/tos-ultimate-buysell.git
   cd tos-ultimate-buysell
   ```

3. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

4. **Make your changes**
   - Edit the relevant files in `src/` or `docs/`
   - Test your changes in ThinkOrSwim
   - Update documentation if needed

5. **Test thoroughly**
   - Test on multiple timeframes
   - Test with different instruments
   - Verify no unintended side effects
   - Check performance impact

6. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add Bollinger Bands indicator integration"
   ```

7. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

8. **Open a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Fill out the PR template

---

## 📝 Style Guidelines

### ThinkScript Code

**Formatting:**
```thinkscript
# Use consistent spacing
def variable_name = calculation();

# Comment sections clearly
# ============================================
# INDICATOR NAME (XX% Weight)
# ============================================

# Use descriptive variable names
def ema_fast = ExpAverage(close, 8);  # Good
def e1 = ExpAverage(close, 8);        # Bad

# Keep lines under 100 characters when possible
```

**Structure:**
- Group related code in sections with clear headers
- Add comments explaining "why", not just "what"
- Use consistent naming conventions (snake_case for variables)
- Keep indicator logic modular and self-contained

**Example:**
```thinkscript
# ============================================
# INDICATOR 1: SUPERTREND (20% Weight)
# ============================================

# Calculate ATR for volatility-based bands
def atr_st = ATR(length = st_length);
def upper_band = hl2 + (st_multiplier * atr_st);
def lower_band = hl2 - (st_multiplier * atr_st);

# Determine trend direction
def supertrend_trend = if close > upper_band then 1 
                       else if close < lower_band then -1 
                       else supertrend_trend[1];

# Score based on trend alignment
def st_score = if useSuperTrend then
               (if supertrend_trend == 1 then 20 else 0)
               else 0;
```

### Documentation

**Markdown:**
- Use clear headings (H1 for title, H2 for sections, H3 for subsections)
- Include code examples in fenced blocks with language tags
- Keep paragraphs concise (3-4 sentences max)
- Use bullet points for lists
- Add visual separators (`---`) between major sections

**Tone:**
- Be direct and concise
- Use active voice
- Avoid jargon when possible
- Explain technical terms
- Write for traders, not just developers

---

## 💬 Commit Messages

Good commit messages help everyone understand the project history.

**Format:**
```
<type>: <subject>

<body (optional)>

<footer (optional)>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, no logic change)
- `refactor`: Code refactoring (no feature change)
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples:**

✅ Good:
```
feat: Add Bollinger Bands indicator with 10% weight

Integrates Bollinger Bands as an optional indicator to identify
volatility squeezes and mean reversion opportunities. Includes
timeframe-adaptive parameters and full documentation.

Closes #42
```

✅ Good:
```
fix: Correct RSI scoring logic for extreme values

RSI values above 70 now properly score 0 points instead of 
10 points to avoid entering overbought conditions.

Fixes #38
```

❌ Bad:
```
updated stuff
```

❌ Bad:
```
fix
```

---

## 🔄 Pull Request Process

### Before Submitting

- [ ] Code is tested in ThinkOrSwim
- [ ] Documentation is updated
- [ ] Changes are described clearly
- [ ] No unrelated changes included
- [ ] Code follows style guidelines
- [ ] Commit messages are clear

### PR Template

When you open a PR, fill out the template:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Code refactoring

## Testing
- Tested on timeframes: 1m, 5m, 15m
- Tested on instruments: SPY, AAPL, /ES
- Edge cases considered: Yes

## Screenshots (if applicable)
[Add screenshots showing before/after]

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] Tested thoroughly
- [ ] No breaking changes
```

### Review Process

1. **Automated checks** (if any) must pass
2. **Maintainer review**: A maintainer will review your PR
3. **Feedback**: Address any requested changes
4. **Approval**: Once approved, your PR will be merged
5. **Recognition**: You'll be added to contributors!

**Timeline:**
- Initial review: Within 2-3 days
- Merge: When approved and all checks pass

---

## 🎯 Contribution Ideas

Not sure what to work on? Here are some ideas:

### Beginner-Friendly
- Fix typos in documentation
- Improve code comments
- Add examples to docs
- Create trading strategy templates

### Intermediate
- Optimize calculation performance
- Add new indicator options
- Enhance visual elements
- Create preset configurations

### Advanced
- Multi-timeframe analysis
- Machine learning weight optimization
- Advanced alert conditions
- Backtesting framework

---

## 🙏 Recognition

All contributors will be:
- Listed in the project README
- Credited in release notes
- Granted contributor badge on GitHub

Significant contributions may lead to:
- Maintainer status
- Direct involvement in roadmap decisions
- Feature naming rights (if applicable)

---

## 📞 Questions?

- **General questions**: [Discussions](https://github.com/yourusername/tos-ultimate-buysell/discussions)
- **Specific issues**: [GitHub Issues](https://github.com/yourusername/tos-ultimate-buysell/issues)
- **Security concerns**: Email [security@example.com]

---

## 🌟 Thank You!

Your contribution, no matter how small, makes this project better for the entire trading community. We appreciate your time and effort!

**Happy coding, and happy trading!** 🚀

---

<div align="center">

**Made with ❤️ by traders, for traders**

[Back to README](README.md) | [View Documentation](docs/DOCUMENTATION.md) | [Report Bug](https://github.com/yourusername/tos-ultimate-buysell/issues/new?labels=bug)

</div>
