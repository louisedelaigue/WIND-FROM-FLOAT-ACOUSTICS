## Subsurface acoustics from biogeochemical floats as a pathway to scalable autonomous observations of global surface wind

#### *L. Delaigue<sup>1</sup>\, P. Cauchy<sup>2</sup>, D. Cazau<sup>3</sup>, J. Bonnel<sup>4</sup>, R. Bozzano<sup>5</sup>, S. Pensieri<sup>5</sup>, A. Gros-Martial<sup>6</sup>, E. Leymarie<sup>1</sup> and H. Claustre<sup>1</sup>*

<details>
<summary><strong>Author Affiliations</strong></summary>
  
<sup>1</sup>Sorbonne Université, CNRS, Laboratoire d'Océanographie de Villefranche, LOV, 06230 Villefranche-sur-Mer, France
  
<sup>2</sup>Institut des sciences de la mer (ISMER), Université du Québec à Rimouski (UQAR), Rimouski, Canada

<sup>3</sup>ENSTA, Lab-STICC, UMR CNRS 6285, Brest, France

<sup>4</sup>Marine Physical Laboratory, Scripps Institution of Oceanography, University of California San Diego, La Jolla, CA, 92093, USA

<sup>5</sup>Institute for the Study of Anthropic Impact and Sustainability in the Marine Environment (IAS), Consiglio Nazionale delle Ricerche (CNR), Genoa, Italy

<sup>6</sup>Centre d’Études Biologiques de Chizé, CNRS, Villiers-en-bois, France



</details>



*Corresponding author: Louise Delaigue ([louise.delaigue@imev-mer.fr](mailto:louise.delaigue@imev-mer.fr))*

> [!IMPORTANT]  
> This study is currently under review for publication in Ocean Science.

<img src="figs/trajectory.png" width="600" height="400" />

### Abstract
Wind forcing plays a pivotal role in driving upper-ocean physical and biogeochemical processes, yet direct wind observations remain sparse in many regions of the global ocean. While passive acoustic techniques have been used to estimate wind speed from moored and mobile platforms, their application to profiling floats has been demonstrated only in limited cases and remains largely unexplored. Here, we report on the first deployment of a Biogeochemical-Argo (BGC-Argo) float equipped with a passive acoustic sensor, aimed at detecting wind-driven surface signals from depth. The float was deployed in the northwestern Mediterranean Sea near the DYFAMED meteorological buoy from February to April 2025, operating at parking depths of 500–1000 m. We demonstrate that wind speed can be successfully retrieved from subsurface ambient noise using established acoustic algorithms, with float-derived estimates showing good agreement with collocated surface observations from the DYFAMED buoy. To evaluate the potential for broader application, we simulate a remote deployment scenario by refitting the acoustic model of Nystuen et al. (2015) using ERA5 reanalysis as a proxy for surface wind. Refitting the model to ERA5 data demonstrates that the float–acoustic–wind relationship is generalizable in moderate conditions, but high-wind regimes remain systematically biased—especially above 10 m s-1. Finally, we apply a residual learning framework to correct these estimates using a limited subset of DYFAMED wind data, simulating conditions where only brief surface observations—such as those from a ship during float deployment—are available. The corrected wind time series achieved a 37% reduction in RMSE and improved the coefficient of determination (R2) from 0.85 to 0.91, demonstrating the effectiveness of combining reanalysis with sparse in situ fitting. This framework enables the retrieval of fine-scale wind variability not captured by reanalysis alone, supporting a scalable strategy for float-based wind monitoring in data-sparse ocean regions—with important implications for quantifying air–sea exchanges, improving biogeochemical flux estimates, and advancing global climate observations.


### Analysis
This repository contains the raw data and scripts used to generate the results presented in the manuscript. The Jupyter Notebook includes the main processing, analysis, visualizations and statistical outputs. The MATLAB code used for the depth-dependent acoustic correction is based on the method from Cauchy et al. (2018), kindly provided by the lead author and modified to suit the needs of this study.

### License
This project is licensed under the GNU General Public License v3.0 – see the LICENSE file for details.


