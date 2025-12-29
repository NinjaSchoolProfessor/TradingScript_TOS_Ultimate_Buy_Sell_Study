#!/bin/bash

# ============================================
# Repository Setup Script
# Ultimate Buy/Sell Confirmation System
# ============================================

echo "🚀 Setting up Ultimate Buy/Sell repository structure..."
echo ""

# Create directory structure
echo "📁 Creating directories..."
mkdir -p src
mkdir -p docs/{images,examples}
mkdir -p examples/{basic-setup,custom-indicators,trading-strategies}
mkdir -p templates/ISSUE_TEMPLATE
mkdir -p scripts
mkdir -p .github/workflows

# Move source files
echo "📦 Organizing source files..."
if [ -f "Ultimate_BuySell_Confirmation.ts" ]; then
    mv Ultimate_BuySell_Confirmation.ts src/
    echo "  ✓ Moved Ultimate_BuySell_Confirmation.ts to src/"
fi

if [ -f "Ultimate_BuySell_ConvictionScore.ts" ]; then
    mv Ultimate_BuySell_ConvictionScore.ts src/
    echo "  ✓ Moved Ultimate_BuySell_ConvictionScore.ts to src/"
fi

# Move documentation files
echo "📚 Organizing documentation..."
if [ -f "INSTALLATION.md" ]; then
    mv INSTALLATION.md docs/
    echo "  ✓ Moved INSTALLATION.md to docs/"
fi

if [ -f "DOCUMENTATION.md" ]; then
    mv DOCUMENTATION.md docs/
    echo "  ✓ Moved DOCUMENTATION.md to docs/"
fi

if [ -f "QUICK_REFERENCE.md" ]; then
    mv QUICK_REFERENCE.md docs/
    echo "  ✓ Moved QUICK_REFERENCE.md to docs/"
fi

if [ -f "ADVANCED_CUSTOMIZATION.md" ]; then
    mv ADVANCED_CUSTOMIZATION.md docs/
    echo "  ✓ Moved ADVANCED_CUSTOMIZATION.md to docs/"
fi

if [ -f "DIRECTORY_STRUCTURE.md" ]; then
    mv DIRECTORY_STRUCTURE.md docs/
    echo "  ✓ Moved DIRECTORY_STRUCTURE.md to docs/"
fi

# Create README in src directory
echo "📝 Creating src/README.md..."
cat > src/README.md << 'EOF'
# Source Code

This directory contains the ThinkScript source code for the Ultimate Buy/Sell Confirmation System.

## Files

### Ultimate_BuySell_Confirmation.ts
The main upper study that displays on your chart. This contains:
- 7-indicator conviction scoring engine
- Visual signals (bubbles, labels, colored bars)
- Adaptive timeframe logic
- Complete customization options

**Installation:** Copy/paste this entire file into ThinkOrSwim's script editor.

### Ultimate_BuySell_ConvictionScore.ts
The companion lower study that visualizes the conviction score.

**Installation:** Add this as a separate lower study below your main chart.

## Development Notes

### Code Structure
- Indicators are modular and self-contained
- Each section is clearly commented
- Scoring logic is transparent and adjustable
- Parameters adapt automatically to selected timeframe

### Modifying Indicators
See [ADVANCED_CUSTOMIZATION.md](../docs/ADVANCED_CUSTOMIZATION.md) for:
- Adjusting indicator weights
- Adding new indicators
- Creating custom profiles
- Performance optimization

### Testing
Always test changes:
1. On paper trading account first
2. Across multiple timeframes (1m, 5m, 15m, 1D)
3. On different instruments (stocks, futures, options)
4. Under various market conditions

## Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines on:
- Reporting bugs
- Suggesting features  
- Submitting code changes
- Code style standards

## Questions?

- Review the [main documentation](../docs/DOCUMENTATION.md)
- Check [GitHub Issues](https://github.com/yourusername/tos-ultimate-buysell/issues)
- Ask in [Discussions](https://github.com/yourusername/tos-ultimate-buysell/discussions)
EOF

# Create issue templates
echo "📋 Creating issue templates..."

# Bug report template
cat > templates/ISSUE_TEMPLATE/bug_report.md << 'EOF'
---
name: Bug Report
about: Report a bug or unexpected behavior
title: '[BUG] '
labels: bug
assignees: ''
---

## Bug Description
A clear and concise description of the bug.

## Steps to Reproduce
1. Set timeframe to '...'
2. Enable indicators '...'
3. Observe '...'
4. See error

## Expected Behavior
What you expected to happen.

## Actual Behavior
What actually happened.

## Screenshots
If applicable, add screenshots to help explain the problem.

## Environment
- **TOS Version:** [e.g., 1.970.37]
- **Operating System:** [e.g., Windows 11, macOS 14.0]
- **Study Version:** [e.g., 1.0.0]
- **Timeframe:** [e.g., 5m]
- **Instrument:** [e.g., SPY]

## Additional Context
Any other relevant information.
EOF

# Feature request template
cat > templates/ISSUE_TEMPLATE/feature_request.md << 'EOF'
---
name: Feature Request
about: Suggest a new feature or enhancement
title: '[FEATURE] '
labels: enhancement
assignees: ''
---

## Feature Description
A clear and concise description of the feature you'd like to see.

## Problem It Solves
What problem does this feature address?

## Proposed Solution
Describe how you envision this feature working.

## Alternatives Considered
Other approaches you've thought about.

## Implementation Ideas
If you have technical suggestions, share them here.

## Additional Context
Any other relevant information, mockups, or examples.
EOF

# Question template
cat > templates/ISSUE_TEMPLATE/question.md << 'EOF'
---
name: Question
about: Ask a question about the system
title: '[QUESTION] '
labels: question
assignees: ''
---

## Your Question
Ask your question clearly and concisely.

## What You've Tried
- [ ] Read the documentation
- [ ] Searched existing issues
- [ ] Tested with default settings

## Context
Provide any relevant context (timeframe, instrument, settings, etc.)

## Additional Information
Any other details that might help answer your question.
EOF

# Pull request template
cat > templates/pull_request_template.md << 'EOF'
## Description
Brief description of the changes in this PR.

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] Code refactoring

## Testing
- [ ] Tested on 1m timeframe
- [ ] Tested on 5m timeframe
- [ ] Tested on 15m timeframe
- [ ] Tested on 1D timeframe
- [ ] Tested on multiple instruments
- [ ] Edge cases considered
- [ ] No unintended side effects

## Screenshots (if applicable)
Add screenshots showing the changes.

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No breaking changes (or documented if unavoidable)
- [ ] All tests pass

## Additional Notes
Any other information relevant to this PR.
EOF

# Create example basic setup
cat > examples/basic-setup/README.md << 'EOF'
# Basic Setup Example

This guide walks you through the absolute basics of getting the Ultimate Buy/Sell system running.

## Step 1: Install Main Study

1. Open ThinkOrSwim
2. Go to **Studies** → **Edit Studies** → **Create**
3. Copy the entire contents of `src/Ultimate_BuySell_Confirmation.ts`
4. Paste into the script editor
5. Name it: "Ultimate Buy/Sell"
6. Click **OK** and **Apply**

## Step 2: Configure for 5-Minute Day Trading

In the study settings:
- **timeframe:** 5m
- **signalThreshold:** 65
- **sellThreshold:** 35
- **All indicators:** yes
- **paintBars:** yes
- **showBubbles:** yes
- **showLabels:** yes

## Step 3: Add Lower Study (Optional)

1. Below your chart, click **Add Study**
2. Click **Create**
3. Copy contents of `src/Ultimate_BuySell_ConvictionScore.ts`
4. Paste into script editor
5. Name it: "Conviction Score"
6. Match settings to your main study
7. Click **OK**

## Step 4: Take Your First Signal

**Wait for:**
- Conviction score crosses above 65
- Volume is elevated (1.5x+ average)
- Price bars turn green
- Green "BUY" bubble appears

**Exit when:**
- Score drops below 40-50 (adjust to your risk tolerance)
- Red "SELL" bubble appears
- Your stop loss is hit

## Common Beginner Mistakes

❌ Taking signals below 65 (low conviction)  
❌ Ignoring volume confirmation  
❌ Not using stop losses  
❌ Overtrading (taking every signal)  
❌ Fighting the higher timeframe trend

## Next Steps

- Read [QUICK_REFERENCE.md](../../docs/QUICK_REFERENCE.md)
- Paper trade for 1-2 weeks
- Track your results
- Optimize for your style
EOF

echo ""
echo "✅ Repository structure created successfully!"
echo ""
echo "📁 Directory Structure:"
echo "   ├── src/                (Source code)"
echo "   ├── docs/               (Documentation)"
echo "   ├── examples/           (Usage examples)"
echo "   ├── templates/          (Issue/PR templates)"
echo "   └── scripts/            (Utility scripts)"
echo ""
echo "🎯 Next Steps:"
echo "   1. Review the directory structure with 'tree' or 'ls -R'"
echo "   2. Add screenshots to docs/images/"
echo "   3. Initialize git: git init"
echo "   4. Add remote: git remote add origin <your-repo-url>"
echo "   5. Make initial commit: git add . && git commit -m 'Initial commit'"
echo "   6. Push to GitHub: git push -u origin main"
echo ""
echo "📚 Documentation:"
echo "   - README.md - Main landing page"
echo "   - docs/INSTALLATION.md - Setup guide"
echo "   - docs/DOCUMENTATION.md - Complete guide"
echo "   - docs/DIRECTORY_STRUCTURE.md - This structure explained"
echo ""
echo "🚀 Ready to push to GitHub!"
