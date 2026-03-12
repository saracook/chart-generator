# Carina Organization Charts

Automated chart generation for Carina cluster organization data. Creates professional visualizations (pie charts, bar charts, tables, and comparisons) with customizable colors and fonts.

## Features

- 📊 **Multiple chart types**: Pie, bar, table, combined, and comparison charts
- 🎨 **Customizable color palettes**: Stanford colors, colorblind-safe, high contrast, and more
- 🔤 **Custom fonts**: Uses Source Sans 3 for Stanford charts
- 📦 **Auto-archiving**: Automatically archives old charts to keep output folder clean
- 🎯 **Accessible**: WCAG-compliant color contrast and conditional labeling

## Project Structure

```
carina_charts/
├── charts/                          # Chart generation modules
│   ├── __init__.py
│   ├── pie.py                      # Pie chart with legend
│   ├── bar.py                      # Horizontal bar chart
│   ├── table.py                    # Professional table
│   ├── combined.py                 # Pie + table side-by-side
│   └── comparison.py               # PI vs User comparison
├── data/                           # Input data files (YOU PUT FILES HERE)
│   ├── pi_organization_totals.txt
│   └── user_organization_totals.txt
├── output/                         # Generated charts (CHARTS APPEAR HERE)
│   └── archive/                    # Old charts archived here
│       ├── archive_20260311_093000/
│       └── archive_20260311_101500/
├── config.py                       # Configuration (colors, fonts, paths)
├── utils.py                        # Utility functions
├── archive.py                      # Archiving utilities
├── main.py                         # Main script (RUN THIS)
├── requirements.txt                # Python dependencies
└── README.md                       # This file
```

## Installation

### 1. Clone or copy the project

```bash
cd /path/to/your/workspace
# Copy all files into a directory called carina_charts/
```

### 2. Create the required directories

```bash
cd carina_charts
mkdir -p data output output/archive
```

### 3. Install dependencies

Using conda (recommended on Carina):
```bash
conda create -n charts python=3.10 -y
conda activate charts
conda install matplotlib pandas -y
```

Or using pip:
```bash
pip install -r requirements.txt
```

### 4. Verify font installation (optional)

The script is configured to use Source Sans 3 from:
```
/projects/bprogers/main/saracook/.fonts/Source_Sans_3/SourceSans3-VariableFont_wght.ttf
```

To use a different font, edit `config.py` and change the `FONT_PATH` variable.

Test the font:
```bash
python test_font.py
```

## Usage

### Prepare Your Data

1. **Place your data files** in the `data/` directory:
   - `pi_organization_totals.txt` - PI organization counts
   - `user_organization_totals.txt` - User organization counts

2. **Data file format** (space-separated, count first):
   ```
   474 School of Medicine
   68 School of Engineering
   56 School of Humanities and Sciences
   14 Office of Senior Vice President for Finance and A
   10 Graduate School of Business
   ```

### Basic Usage

Activate your conda environment:
```bash
conda activate charts
```

Create all charts (default):
```bash
python main.py
```

This will:
- Archive any existing charts in `output/`
- Generate pie, bar, table, combined, and comparison charts
- Save new charts to `output/`
- Print a summary to the console

### Common Options

**Create only pie charts:**
```bash
python main.py --type pie
```

**Use Stanford colors:**
```bash
python main.py --colors stanford
```

**Process only PI data:**
```bash
python main.py --process pi
```

**Process only User data:**
```bash
python main.py --process user
```

**Create combined chart (pie + table):**
```bash
python main.py --type combined
```

**Skip archiving old charts:**
```bash
python main.py --no-archive
```

**Custom output prefix:**
```bash
python main.py --output-prefix carina_stats
```

**Adjust minimum percentage label on pie charts:**
```bash
python main.py --min-pct-label 3.0
```

**Increase legend font size:**
```bash
python main.py --legend-fontsize 14
```

### Advanced Usage

**Use custom data file locations:**
```bash
python main.py \
    --pi-file /path/to/pi_data.txt \
    --user-file /path/to/user_data.txt
```

**Combine multiple options:**
```bash
python main.py \
    --colors colorblind \
    --type combined \
    --min-pct-label 2.5 \
    --legend-fontsize 14 \
    --output-prefix presentation
```

**Use a different font:**
```bash
python main.py --font-path /path/to/your/font.ttf
```

## Available Chart Types

| Type | Flag | Description |
|------|------|-------------|
| **Pie** | `--type pie` | Pie chart with external legend |
| **Bar** | `--type bar` | Horizontal bar chart with values |
| **Table** | `--type table` | Professional styled table |
| **Combined** | `--type combined` | Pie chart + table side-by-side |
| **Comparison** | `--type comparison` | PI vs User side-by-side bars |
| **All** | `--type all` | Generate all chart types (default) |

## Available Color Palettes

| Palette | Flag | Description |
|---------|------|-------------|
| **Stanford** | `--colors stanford` | Stanford University brand colors |
| **Colorblind** | `--colors colorblind` | Colorblind-friendly palette |
| **Viridis** | `--colors viridis` | Perceptually uniform colors |
| **High Contrast** | `--colors high_contrast` | Maximum contrast (default) |

## Output Files

Charts are saved to `output/` with timestamps:

```
output/
├── carina_org_pi_pie_20260311_123045.png
├── carina_org_pi_bar_20260311_123045.png
├── carina_org_pi_table_20260311_123045.png
├── carina_org_pi_combined_20260311_123045.png
├── carina_org_user_pie_20260311_123045.png
├── carina_org_user_bar_20260311_123045.png
├── carina_org_user_table_20260311_123045.png
├── carina_org_user_combined_20260311_123045.png
└── carina_org_comparison_20260311_123045.png
```

All files with the same timestamp were generated in the same run.

## Archive Management

**List all archives:**
```bash
python main.py --list-archives
```

**Change number of archives to keep:**
```bash
python main.py --keep-archives 5
```

**Archive directory structure:**
```
output/archive/
├── archive_20260311_093000/
│   ├── carina_org_pi_pie_20260311_092000.png
│   └── ...
└── archive_20260311_101500/
    ├── carina_org_pi_pie_20260311_100000.png
    └── ...
```

By default, the 10 most recent archives are kept. Older archives are automatically deleted.

## Downloading Charts from Carina

### Option 1: Using scp (from your local machine)
```bash
scp username@carina.stanford.edu:/path/to/carina_charts/output/*.png .
```

### Option 2: Using Open OnDemand File Browser
1. Navigate to https://carina.stanford.edu
2. Go to Files → Home Directory
3. Navigate to your `carina_charts/output/` folder
4. Select charts and click "Download"

### Option 3: Download specific chart
```bash
scp username@carina.stanford.edu:/path/to/carina_charts/output/carina_org_pi_combined_20260311_123045.png ~/Desktop/
```

## Customization

### Change Font

Edit `config.py`:
```python
FONT_PATH = '/your/path/to/font.ttf'
```

Or use command-line argument:
```bash
python main.py --font-path /path/to/font.ttf
```

### Add New Color Palette

Edit `config.py` and add to `COLOR_PALETTES`:
```python
MY_CUSTOM_PALETTE = [
    '#FF5733',  # Color 1
    '#33FF57',  # Color 2
    '#3357FF',  # Color 3
    # ... add more colors
]

COLOR_PALETTES = {
    'stanford': STANFORD_COLORS,
    'colorblind': COLORBLIND_SAFE,
    'viridis': VIRIDIS_PALETTE,
    'high_contrast': HIGH_CONTRAST,
    'custom': MY_CUSTOM_PALETTE,  # Add this
}
```

Then use:
```bash
python main.py --colors custom
```

### Adjust Chart Sizes

Edit the individual chart modules in `charts/` directory. For example, in `charts/pie.py`:
```python
fig, ax = plt.subplots(figsize=(16, 10), dpi=100)  # Change figsize here
```

## Troubleshooting

**"ERROR: PI file not found"**
- Check that your data files are in the `data/` directory
- Verify filenames match exactly: `pi_organization_totals.txt` and `user_organization_totals.txt`

**"Warning: Font file not found"**
- Font will fall back to default sans-serif
- Update `FONT_PATH` in `config.py` to point to your font file
- Or use `--font-path` argument

**"ModuleNotFoundError: No module named 'matplotlib'"**
- Install dependencies: `conda install matplotlib pandas`
- Or: `pip install -r requirements.txt`

**Charts look wrong/overlapping text**
- Try a different color palette: `--colors colorblind`
- Increase minimum label percentage: `--min-pct-label 3.0`
- Adjust legend font size: `--legend-fontsize 10`

**Permission denied when archiving**
- Check that you have write permissions in the `output/` directory
- Use `--no-archive` flag to skip archiving

## Examples

**Quick presentation charts with Stanford colors:**
```bash
python main.py --colors stanford --type combined
```

**Generate all charts for PI data only:**
```bash
python main.py --process pi
```

**Colorblind-safe comparison chart:**
```bash
python main.py --type comparison --colors colorblind
```

**Custom settings for publication:**
```bash
python main.py \
    --colors viridis \
    --min-pct-label 1.5 \
    --legend-fontsize 14 \
    --output-prefix figure
```

## Support

For questions or issues:
- Check that all input files are properly formatted
- Review the console output for specific error messages
- Verify all dependencies are installed
- Contact: saracook@stanford.edu

## License

Internal use for Stanford Research Computing.

---

**Quick Start Checklist:**
- [ ] Install dependencies (`conda install matplotlib pandas`)
- [ ] Create `data/` directory
- [ ] Place data files in `data/`
- [ ] Run `python main.py`
- [ ] Check `output/` for generated charts
- [ ] Download charts via scp or Open OnDemand
