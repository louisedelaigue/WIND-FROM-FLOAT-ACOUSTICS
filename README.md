# Subsurface acoustics from biogeochemical floats as a pathway to scalable autonomous observations of global surface wind

> [!IMPORTANT]  
> This study is currently under review for publication in Ocean Science.

<img src="figs/Figure2a_with_uncertainty.png" width="600" height="400" />

#### This repository includes the raw data and scripts used to analyze and plot data for the study:

### **Subsurface acoustics from biogeochemical floats as a pathway to scalable autonomous observations of global surface wind**

#### *L. Delaigue<sup>1</sup>\, P. Cauchy<sup>2</sup>, D. Cazau<sup>3</sup>, R. Bozzano<sup>4</sup>, S. Pensieri<sup>4</sup>, A. Gros-Martial<sup>5</sup>, J. Bonnel<sup>6</sup>, E. Leymarie<sup>1</sup> and H. Claustre<sup>1</sup>*

<sup>1</sup>Sorbonne Université, CNRS, Laboratoire d'Océanographie de Villefranche, LOV, 06230 Villefranche-sur-Mer, France

<sup>2</sup>Institut des sciences de la mer (ISMER), Université du Québec à Rimouski (UQAR), Rimouski, Canada

<sup>3</sup>ENSTA, Lab-STICC, UMR CNRS 6285, Brest, France

<sup>4</sup>Institute for the Study of Anthropic Impact and Sustainability in the Marine Environment (IAS), Consiglio Nazionale delle Ricerche (CNR), Genoa, Italy

<sup>5</sup>Centre d’Études Biologiques de Chizé, CNRS, Villiers-en-bois, France

<sup>6</sup>Marine Physical Laboratory, Scripps Institution of Oceanography, University of California San Diego, La Jolla, CA, 92093, USA


*Corresponding author: Louise Delaigue ([louise.delaigue@imev-mer.fr](mailto:louise.delaigue@imev-mer.fr))*


## Abstract
Marine dissolved inorganic carbon (DIC) is a key component of the global carbon cycle. Over recent decades, DIC has increased due to rising anthropogenic CO<sub>2</sub>, but the contribution of the biological carbon pump (BCP) — which transfers carbon from the surface to the deep ocean — remains poorly quantified. Using the GOBAI-O<sub>2</sub> data product and machine learning algorithms, we reconstructed the global DIC distribution from 2004 to 2022 and decomposed it into DIC<sub>soft</sub> (BCP contribution), DIC<sub>carb</sub> (carbonate counter pump), and DIC<sub>anth</sub> (anthropogenic CO2). We found a significant DIC increase, with surface waters rising at ~1.0 ± 0.23 μmol kg<sup>-1</sup> yr<sup>-1</sup>, primarily driven by DIC<sub>anth</sub> (>90% of the increase). While DIC<sub>soft</sub> showed no significant globally integrated trend, strong regional patterns were observed. Vertical and horizontal shifts in the BCP altered carbon sequestration, with enhanced carbon storage at shallower depths (i.e., stored on shorter timescales) in some regions and intensified sequestration at greater depths (i.e., stored on longer timescales) in others. Although this redistribution maintained a near-neutral BCP global trend, locally, strong regional changes could disrupt deep-water ecosystems, carbon storage in the ocean interior, and the BCP’s long-term role in the Earth's climate regulation.


## Analysis
A detailed explanation of each script is available in the "Figures and numbers" Jupyter notebook of the repository, along with the resulting figures and statistics. Additionally, interactive plots in Plotly allow for a more detailed exploration of the numbers.

> [!NOTE]  
> This repository does not include the application of the CANYON-B and CONTENT algorithms on the GOBAI-O<sub>2</sub> product due to the large file sizes. However, these files can be made available upon request, along with the GCC-DIC file.
