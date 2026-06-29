# ParkVisitorsByState_Multipanel.py
# Make multi-panel choropleth maps of visitor origins by state

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib as mpl
from matplotlib.patches import Polygon
from matplotlib.collections import PatchCollection
from mpl_toolkits.basemap import Basemap
from mpl_toolkits.axes_grid1.inset_locator import inset_axes

# --------------------------------------------------
# File paths
# --------------------------------------------------
csv_path = "../Data/ParkVisitorsByState.csv"
states_shp = "../Data/tl_2025_us_state"   # no ".shp" suffix
out_png = "../Figures/park_visitors_by_state_multipanel.png"
out_pdf = "../Figures/park_visitors_by_state_multipanel.pdf"

# --------------------------------------------------
# Load visitation data
# --------------------------------------------------
df = pd.read_csv(csv_path)
df["customerstate"] = df["customerstate"].astype(str).str.upper().str.strip()

# Optional: if your CSV uses lowercase column names or slightly different names,
# update these here
park_col = "parentlocation"
state_col = "customerstate"
share_col = "StateShare"

# --------------------------------------------------
# Park order and coordinates
# --------------------------------------------------
parks_order = [
    "Acadia National Park",
    "Arches National Park",
    "Glacier National Park",
    "Haleakala National Park",
    "Mount Rainier National Park",
    "Rocky Mountain National Park",
    "Yosemite National Park",
]

park_coords = {
    "Arches National Park": (-109.7505, 38.73172),
    "Yosemite National Park": (-119.8808, 37.85285),
    "Acadia National Park": (-68.46162, 44.31926),
    "Rocky Mountain National Park": (-105.8413, 40.35062),
    "Mount Rainier National Park": (-121.7149, 46.86011),
    "Glacier National Park": (-114.1755, 48.65968),
    "Haleakala National Park": (-156.1644, 20.7035),
}

# --------------------------------------------------
# Plot styling
# --------------------------------------------------
plt.rcParams.update({
    "font.family": "DejaVu Sans",
    "font.size": 10,
    "axes.titlesize": 12,
})

# Common color scale across all parks
vmin = 0.0
vmax = df[share_col].max()
cmap = plt.cm.Blues
norm = mpl.colors.Normalize(vmin=vmin, vmax=vmax)

# Exclude these from the main lower-48 map
exclude_main = {"AK", "HI", "PR", "GU", "MP", "AS", "VI"}

# --------------------------------------------------
# Helper: draw one park panel
# --------------------------------------------------
def draw_park_panel(ax, park_name):
    park_df = df[df[park_col] == park_name].copy()
    share_map = dict(zip(park_df[state_col], park_df[share_col]))

    # Main contiguous U.S. map
    m = Basemap(
        projection="aea",
        lat_1=29.5, lat_2=45.5, lon_0=-96,
        llcrnrlon=-128, llcrnrlat=17.0,
        urcrnrlon=-63,  urcrnrlat=48,
        resolution="l", ax=ax
    )

    # Read shapefile (no bounds drawn yet)
    m.readshapefile(states_shp, "states", drawbounds=False)

    # Background
    m.drawmapboundary(fill_color="white", linewidth=0.0)
    m.fillcontinents(color="#f7f4ec", lake_color="white", zorder=0)

    # Build filled polygons
    patches = []
    facecolors = []

    for info, shape in zip(m.states_info, m.states):
        st = info.get("STUSPS", "")

        if st in exclude_main:
            continue

        patches.append(Polygon(shape, closed=True))
        facecolors.append(cmap(norm(share_map.get(st, 0.0))))

    pc = PatchCollection(
        patches,
        facecolor=facecolors,
        edgecolor="white",
        linewidth=0.5,
        zorder=1.5
    )
    ax.add_collection(pc)

    # Redraw outlines on top
    m.drawcoastlines(color="#7f8c8d", linewidth=0.55, zorder=2.5)
    m.drawcountries(color="#95a5a6", linewidth=0.45, zorder=2.5)
    m.drawstates(color="white", linewidth=0.45, zorder=2.5)

    # Park marker
    lon, lat = park_coords[park_name]
    if park_name != "Haleakala National Park":
        x, y = m(lon, lat)
        ax.scatter(
            x, y,
            s=42, color="#be3a34",
            edgecolor="white", linewidth=0.9,
            zorder=3
        )

    # Title
    ax.set_title(park_name.replace(" National Park", ""), pad=6, weight="bold")
    ax.set_xticks([])
    ax.set_yticks([])
    for spine in ax.spines.values():
        spine.set_visible(False)

    # --------------------------------------------------
    # Hawaii inset
    # --------------------------------------------------
    ax_in = inset_axes(
        ax,
        width="22%",
        height="24%",
        loc="lower left",
        bbox_to_anchor=(0.03, 0.02, 1, 1),
        bbox_transform=ax.transAxes,
        borderpad=0
    )

    m_hi = Basemap(
        projection="merc",
        llcrnrlon=-161.7, llcrnrlat=18.4,
        urcrnrlon=-154.3, urcrnrlat=22.8,
        resolution="i", ax=ax_in
    )

    m_hi.readshapefile(states_shp, "states_hi", drawbounds=False)

    m_hi.drawmapboundary(fill_color="white", linewidth=0.8)
    m_hi.fillcontinents(color="#f7f4ec", lake_color="white", zorder=0)

    hi_patches = []
    hi_colors = []

    for info, shape in zip(m_hi.states_hi_info, m_hi.states_hi):
        st = info.get("STUSPS", "")
        if st != "HI":
            continue

        hi_patches.append(Polygon(shape, closed=True))
        hi_colors.append(cmap(norm(share_map.get("HI", 0.0))))

    hi_pc = PatchCollection(
        hi_patches,
        facecolor=hi_colors,
        edgecolor="white",
        linewidth=0.45,
        zorder=1.5
    )
    ax_in.add_collection(hi_pc)

    m_hi.drawcoastlines(color="#7f8c8d", linewidth=0.45, zorder=2.5)

    # Red marker only in the Haleakala panel
    if park_name == "Haleakala National Park":
        hx, hy = m_hi(lon, lat)
        ax_in.scatter(
            hx, hy,
            s=26, color="#be3a34",
            edgecolor="white", linewidth=0.8,
            zorder=3
        )

    ax_in.set_title("Hawaii inset", fontsize=7.5, pad=2)
    ax_in.set_xticks([])
    ax_in.set_yticks([])
    for spine in ax_in.spines.values():
        spine.set_edgecolor("#90a4ae")
        spine.set_linewidth(0.6)

# --------------------------------------------------
# Build figure
# --------------------------------------------------
fig, axes = plt.subplots(3, 3, figsize=(14, 10.5), facecolor="white")
axes = axes.flatten()

for i, park in enumerate(parks_order):
    draw_park_panel(axes[i], park)

# Turn off unused panels
for j in range(len(parks_order), 9):
    axes[j].axis("off")

# Shared colorbar
sm = mpl.cm.ScalarMappable(norm=norm, cmap=cmap)
sm.set_array([])

# [left, bottom, width, height]
cax = fig.add_axes([0.40, 0.15, 0.34, 0.025])
#cax = fig.add_axes([0.28, 0.08, 0.44, 0.025])

cbar = fig.colorbar(sm, cax=cax, orientation="horizontal")
cbar.set_label("Reservation Share", fontsize=12)
cbar.ax.tick_params(labelsize=10)
cbar.ax.xaxis.set_major_formatter(mpl.ticker.PercentFormatter(xmax=1))

# Main title
fig.suptitle(
    "National Park Reservation State Shares",
    fontsize=18,
    weight="bold",
    y=0.98
)

plt.subplots_adjust(
    left=0.03,
    right=0.90,
    top=0.93,
    bottom=0.04,
    wspace=0.08,
    hspace=0.16
)

# Save
fig.savefig(out_png, dpi=300, bbox_inches="tight")
fig.savefig(out_pdf, bbox_inches="tight")

plt.show()

print("Saved:")
print(out_png)
print(out_pdf)