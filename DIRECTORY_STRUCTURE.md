# Repository Directory Structure

This document describes the recommended directory structure for the Ultimate Buy/Sell Confirmation System repository.

---

## 📁 Recommended Structure

```
tos-ultimate-buysell/
├── README.md                           # Main landing page (you are here)
├── LICENSE                             # MIT License with trading disclaimers
├── CHANGELOG.md                        # Version history
├── CONTRIBUTING.md                     # Contribution guidelines
├── .gitignore                          # Git ignore rules
│
├── src/                                # Source code directory
│   ├── Ultimate_BuySell_Confirmation.ts      # Main upper study
│   ├── Ultimate_BuySell_ConvictionScore.ts   # Lower study for visualization
│   └── README.md                             # Source code notes
│
├── docs/                               # Documentation directory
│   ├── INSTALLATION.md                 # Setup guide
│   ├── DOCUMENTATION.md                # Comprehensive guide
│   ├── QUICK_REFERENCE.md              # One-page cheat sheet
│   ├── ADVANCED_CUSTOMIZATION.md       # Developer guide
│   │
│   ├── images/                         # Screenshots and diagrams
│   │   ├── chart-example.png
│   │   ├── lower-study.png
│   │   ├── signal-example.png
│   │   └── settings-panel.png
│   │
│   └── examples/                       # Example configurations
│       ├── scalper-config.md
│       ├── daytrader-config.md
│       └── swingtrader-config.md
│
├── examples/                           # Usage examples
│   ├── basic-setup/
│   │   └── README.md
│   ├── custom-indicators/
│   │   ├── macd-integration.ts
│   │   ├── bollinger-bands.ts
│   │   └── README.md
│   └── trading-strategies/
│       ├── trend-following.md
│       ├── mean-reversion.md
│       └── breakout-trading.md
│
├── templates/                          # Issue/PR templates
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   ├── feature_request.md
│   │   └── question.md
│   └── pull_request_template.md
│
├── scripts/                            # Utility scripts (future)
│   ├── validate-script.py              # Validate ThinkScript syntax
│   ├── export-signals.py               # Export signal history
│   └── README.md
│
└── .github/                            # GitHub-specific files
    ├── workflows/                      # GitHub Actions (future)
    │   └── validate.yml
    ├── FUNDING.yml                     # Sponsorship info (optional)
    └── CODEOWNERS                      # Code owners (optional)
```

---

## 📋 Directory Purposes

### Root Files
| File | Purpose |
|------|---------|
| **README.md** | Main landing page with overview, features, quick start |
| **LICENSE** | MIT License with trading disclaimers |
| **CHANGELOG.md** | Version history and release notes |
| **CONTRIBUTING.md** | How to contribute to the project |
| **.gitignore** | Files to exclude from version control |

### `src/` - Source Code
Contains the actual ThinkScript files that users will import into ThinkOrSwim.

**Files:**
- `Ultimate_BuySell_Confirmation.ts` - Main study (upper chart)
- `Ultimate_BuySell_ConvictionScore.ts` - Companion study (lower chart)
- `README.md` - Notes on code structure and development

**Purpose:** Keep source code separate from documentation for clarity.

### `docs/` - Documentation
All user-facing documentation and guides.

**Main docs:**
- `INSTALLATION.md` - Step-by-step setup
- `DOCUMENTATION.md` - Complete system guide
- `QUICK_REFERENCE.md` - Cheat sheet for traders
- `ADVANCED_CUSTOMIZATION.md` - For developers

**Subdirectories:**
- `images/` - Screenshots, diagrams, visual aids
- `examples/` - Configuration examples for different trading styles

### `examples/` - Usage Examples
Practical examples showing how to use and extend the system.

**Subdirectories:**
- `basic-setup/` - Simple getting started examples
- `custom-indicators/` - How to add new indicators
- `trading-strategies/` - Strategy-specific configurations

### `templates/` - GitHub Templates
Templates for issues and pull requests to maintain quality.

**Issue templates:**
- Bug reports
- Feature requests
- Questions

**PR template:**
- Standardized pull request format

### `scripts/` - Utility Scripts
Helper scripts for development and analysis (future enhancement).

**Potential scripts:**
- ThinkScript syntax validator
- Signal history exporter
- Performance analyzer
- Configuration generator

### `.github/` - GitHub Configuration
GitHub-specific configuration files.

**Contents:**
- `workflows/` - GitHub Actions for CI/CD
- `FUNDING.yml` - Sponsorship configuration
- `CODEOWNERS` - Automatic PR reviewers

---

## 🚀 Setting Up This Structure

### Quick Setup

```bash
# Create the directory structure
mkdir -p src docs/images docs/examples examples/{basic-setup,custom-indicators,trading-strategies} templates/ISSUE_TEMPLATE scripts .github/workflows

# Move files to proper locations
mv Ultimate_BuySell_Confirmation.ts src/
mv Ultimate_BuySell_ConvictionScore.ts src/
mv INSTALLATION.md DOCUMENTATION.md QUICK_REFERENCE.md ADVANCED_CUSTOMIZATION.md docs/

# Verify structure
tree -L 2
```

### Manual Setup (Windows)

```powershell
# Create directories
New-Item -ItemType Directory -Force -Path src, docs\images, docs\examples, examples\basic-setup, examples\custom-indicators, examples\trading-strategies, templates\ISSUE_TEMPLATE, scripts, .github\workflows

# Move files
Move-Item Ultimate_BuySell_Confirmation.ts src\
Move-Item Ultimate_BuySell_ConvictionScore.ts src\
Move-Item INSTALLATION.md, DOCUMENTATION.md, QUICK_REFERENCE.md, ADVANCED_CUSTOMIZATION.md docs\
```

---

## 📝 File Organization Best Practices

### Naming Conventions
- **Documentation**: `UPPERCASE.md` (e.g., `README.md`, `CHANGELOG.md`)
- **Source code**: `PascalCase.ts` (e.g., `Ultimate_BuySell_Confirmation.ts`)
- **Examples**: `lowercase-hyphen.md` (e.g., `scalper-config.md`)
- **Images**: `lowercase-hyphen.png` (e.g., `chart-example.png`)

### File Size Limits
- **Documentation**: Keep under 200 KB (GitHub renders nicely)
- **Images**: Compress to under 500 KB each
- **Source code**: No strict limit, but keep modular

### Version Control
- Commit logically related changes together
- Write clear commit messages
- Tag releases with version numbers
- Keep main branch stable

---

## 🖼️ Adding Screenshots

### Recommended Screenshots

1. **chart-example.png**
   - Full chart view showing the system in action
   - Buy/sell bubbles visible
   - Colored bars showing conviction

2. **lower-study.png**
   - Lower study showing conviction score
   - Threshold lines
   - Cloud visualization

3. **signal-example.png**
   - Close-up of a buy signal
   - Component scores visible
   - Clear entry point

4. **settings-panel.png**
   - Study settings dialog
   - All configuration options visible
   - Example values shown

### Screenshot Guidelines
- Use a clean chart background
- Show realistic market data
- Highlight key elements
- Compress images (use PNG or JPEG)
- Max size: 500 KB per image

---

## 📦 Distribution Options

### Option 1: Direct Download
Users download individual files from `src/` directory.

**Pros:** Simple, no extra steps  
**Cons:** Users must manage multiple files

### Option 2: Release Packages
Create .zip releases with all files organized.

**Pros:** One-click download, organized  
**Cons:** Requires GitHub releases

### Option 3: Installation Script
Provide a script that fetches and organizes files.

**Pros:** Automated setup  
**Cons:** Requires scripting knowledge

**Recommendation:** Use Option 2 (GitHub Releases) for major versions.

---

## 🔄 Maintenance

### Regular Updates
- Update CHANGELOG.md with every release
- Keep README.md current with latest features
- Archive old versions in releases
- Respond to issues within 2-3 days

### Documentation
- Review docs quarterly for accuracy
- Update screenshots when UI changes
- Add new examples as use cases emerge
- Fix typos and broken links promptly

### Code
- Test on latest TOS version
- Maintain backwards compatibility when possible
- Deprecate features before removing
- Keep code comments current

---

## 🌟 Recommended Additions (Future)

### Phase 1 (v1.1)
- [ ] Add `docs/images/` with screenshots
- [ ] Create issue templates
- [ ] Add example configurations
- [ ] Write basic setup guide

### Phase 2 (v1.2)
- [ ] Add validation scripts
- [ ] Create GitHub Actions workflow
- [ ] Add wiki for FAQs
- [ ] Community examples

### Phase 3 (v2.0)
- [ ] Web-based configuration tool
- [ ] Signal backtesting framework
- [ ] Performance analytics
- [ ] Mobile companion

---

## 📞 Questions?

If you have questions about the repository structure:
- Open a [Discussion](https://github.com/yourusername/tos-ultimate-buysell/discussions)
- Check [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines
- Review [README.md](README.md) for project overview

---

<div align="center">

**Well-organized code is maintainable code**

[Back to README](../README.md)

</div>
