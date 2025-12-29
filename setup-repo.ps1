# ============================================
# Repository Setup Script (Windows PowerShell)
# Ultimate Buy/Sell Confirmation System
# ============================================

Write-Host "🚀 Setting up Ultimate Buy/Sell repository structure..." -ForegroundColor Cyan
Write-Host ""

# Create directory structure
Write-Host "📁 Creating directories..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path "src" | Out-Null
New-Item -ItemType Directory -Force -Path "docs\images" | Out-Null
New-Item -ItemType Directory -Force -Path "docs\examples" | Out-Null
New-Item -ItemType Directory -Force -Path "examples\basic-setup" | Out-Null
New-Item -ItemType Directory -Force -Path "examples\custom-indicators" | Out-Null
New-Item -ItemType Directory -Force -Path "examples\trading-strategies" | Out-Null
New-Item -ItemType Directory -Force -Path "templates\ISSUE_TEMPLATE" | Out-Null
New-Item -ItemType Directory -Force -Path "scripts" | Out-Null
New-Item -ItemType Directory -Force -Path ".github\workflows" | Out-Null

# Move source files
Write-Host "📦 Organizing source files..." -ForegroundColor Yellow
if (Test-Path "Ultimate_BuySell_Confirmation.ts") {
    Move-Item "Ultimate_BuySell_Confirmation.ts" "src\" -Force
    Write-Host "  ✓ Moved Ultimate_BuySell_Confirmation.ts to src\" -ForegroundColor Green
}

if (Test-Path "Ultimate_BuySell_ConvictionScore.ts") {
    Move-Item "Ultimate_BuySell_ConvictionScore.ts" "src\" -Force
    Write-Host "  ✓ Moved Ultimate_BuySell_ConvictionScore.ts to src\" -ForegroundColor Green
}

# Move documentation files
Write-Host "📚 Organizing documentation..." -ForegroundColor Yellow
$docFiles = @("INSTALLATION.md", "DOCUMENTATION.md", "QUICK_REFERENCE.md", "ADVANCED_CUSTOMIZATION.md", "DIRECTORY_STRUCTURE.md")

foreach ($file in $docFiles) {
    if (Test-Path $file) {
        Move-Item $file "docs\" -Force
        Write-Host "  ✓ Moved $file to docs\" -ForegroundColor Green
    }
}

# Create README in src directory
Write-Host "📝 Creating src\README.md..." -ForegroundColor Yellow
@"
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
"@ | Out-File -FilePath "src\README.md" -Encoding UTF8

# Create issue templates
Write-Host "📋 Creating issue templates..." -ForegroundColor Yellow

# Bug report template
@"
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
"@ | Out-File -FilePath "templates\ISSUE_TEMPLATE\bug_report.md" -Encoding UTF8

# Feature request template
@"
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
"@ | Out-File -FilePath "templates\ISSUE_TEMPLATE\feature_request.md" -Encoding UTF8

# Question template
@"
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
"@ | Out-File -FilePath "templates\ISSUE_TEMPLATE\question.md" -Encoding UTF8

# Pull request template
@"
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
"@ | Out-File -FilePath "templates\pull_request_template.md" -Encoding UTF8

# Create example basic setup
@"
# Basic Setup Example

This guide walks you through the absolute basics of getting the Ultimate Buy/Sell system running.

## Step 1: Install Main Study

1. Open ThinkOrSwim
2. Go to **Studies** → **Edit Studies** → **Create**
3. Copy the entire contents of ``src\Ultimate_BuySell_Confirmation.ts``
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
3. Copy contents of ``src\Ultimate_BuySell_ConvictionScore.ts``
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
"@ | Out-File -FilePath "examples\basic-setup\README.md" -Encoding UTF8

Write-Host ""
Write-Host "✅ Repository structure created successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "📁 Directory Structure:" -ForegroundColor Cyan
Write-Host "   ├── src\                (Source code)"
Write-Host "   ├── docs\               (Documentation)"
Write-Host "   ├── examples\           (Usage examples)"
Write-Host "   ├── templates\          (Issue/PR templates)"
Write-Host "   └── scripts\            (Utility scripts)"
Write-Host ""
Write-Host "🎯 Next Steps:" -ForegroundColor Yellow
Write-Host "   1. Review the directory structure with 'tree' or 'dir /s'"
Write-Host "   2. Add screenshots to docs\images\"
Write-Host "   3. Initialize git: git init"
Write-Host "   4. Add remote: git remote add origin <your-repo-url>"
Write-Host "   5. Make initial commit: git add . && git commit -m 'Initial commit'"
Write-Host "   6. Push to GitHub: git push -u origin main"
Write-Host ""
Write-Host "📚 Documentation:" -ForegroundColor Cyan
Write-Host "   - README.md - Main landing page"
Write-Host "   - docs\INSTALLATION.md - Setup guide"
Write-Host "   - docs\DOCUMENTATION.md - Complete guide"
Write-Host "   - docs\DIRECTORY_STRUCTURE.md - This structure explained"
Write-Host ""
Write-Host "🚀 Ready to push to GitHub!" -ForegroundColor Green
