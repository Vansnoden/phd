# Scientific Evaluation of the MONADSIM Framework for *Anopheles stephensi* in Dire Dawa, Ethiopia

This step‑by‑step protocol provides a rigorous framework to evaluate the simulation’s biological fidelity, predictive power, and utility for public health decision‑making.

---

## Step 1: Data Compilation & Pre‑processing

### 1.1 Field data collection (if available)
- **Mosquito abundance** – weekly or bi‑weekly adult/larval counts from multiple sentinel sites (e.g., CDC light traps, larval dipping).  
- **Species identification** – confirm *An. stephensi* via morphology or PCR.  
- **Environmental covariates** – in‑situ temperature (hourly), rainfall (daily), land use, building density, population density (from census or remote sensing).  
- **Water tank survey** – GPS coordinates, volume, presence/absence of larvae, water temperature.

### 1.2 Remote sensing / public data
- **ERA5‑Land** hourly temperature, precipitation (NetCDF).  
- **High‑resolution elevation** (e.g., SRTM 30m).  
- **Population density** (WorldPop).  
- **Building footprints** (OpenStreetMap or satellite‑derived).

### 1.3 Data alignment
- Resample all raster layers to a common grid (e.g., 0.001° ≈ 100 m).  
- Align time series to simulation tick (15‑minute) resolution via interpolation.

---

## Step 2: Parameterisation & Calibration

### 2.1 Life‑cycle parameters (Metzler matrix)
- **Use literature values** for *An. stephensi* (already implemented).  
- **If local data exist** (e.g., development times in laboratory at different temperatures), refine coefficients using Bayesian inference or least‑squares fitting.

### 2.2 Behavioural rule parameters
- **Movement step** – calibrate using mark‑release‑recapture data (typical dispersal ~500 m/week).  
- **Resting behaviour** – use indoor resting density surveys.  
- **Host‑seeking** – adjust `population` threshold in `feed` rule to match observed biting rates.

### 2.3 Initial conditions
- **Water tank locations** – use a field survey or randomly generate according to building/population density (as currently done).  
- **Initial mosquito stage distribution** – assume equilibrium age structure derived from temperature at start date.

### 2.4 Calibration procedure
- Run simulation for the period of field data (e.g., 3–6 months).  
- Use **Approximate Bayesian Computation (ABC)** or **grid search** to adjust:  
  - Hatching probability multiplier (if not using full Metzler).  
  - Tank creation/drying rates.  
  - Adult mortality baseline.  
- Objective: minimise root‑mean‑square error (RMSE) between simulated and observed adult abundance.

---

## Step 3: Internal Validation (Structural & Face)

### 3.1 Life‑cycle consistency
- Track individual mosquitoes through stages. Verify that mean stage durations at given temperature match literature values.  
- Compute **stage transition probabilities** from simulation and compare with Metzler matrix predictions (chi‑square test).

### 3.2 Spatial consistency
- **Spatial autocorrelation** – simulated adult mosquitoes should cluster near water tanks (measured by Moran’s I).  
- **Proximity metric** – average distance of adult to nearest tank should be less than flight range (e.g., <500 m).  
- Compare with field data if available.

### 3.3 Energy and resting logic
- Ensure that mosquitoes that never rest die from exhaustion (emergent property).  
- Verify that resting individuals have higher survival than active ones.

---

## Step 4: Quantitative Validation (External)

### 4.1 Temporal validation
- **Metric**: Pearson/Spearman correlation between weekly simulated adult abundance and field trap counts.  
- **Acceptable threshold**: r > 0.6 for practical use.  
- **Additional metrics**: RMSE, normalised RMSE, bias (mean simulated – mean observed).

### 4.2 Spatial validation (if geo‑referenced trap data exist)
- **Hotspot agreement** – overlay simulated adult density with trap locations; calculate area under ROC curve (AUC) for presence/absence above a threshold.  
- **Spatial cross‑correlation** – use Mantel test or matrix correlation.

### 4.3 Event validation
- **Peak timing** – compare predicted week of maximum adult abundance with observed peak.  
- **Outbreak detection** – define outbreak threshold (e.g., >50 adults per trap night); compute sensitivity and specificity of simulation.

### 4.4 Hindcasting
- Run simulation for a past period not used in calibration (e.g., another year). Compare with independent data.

---

## Step 5: Sensitivity & Uncertainty Analysis

### 5.1 One‑at‑a‑time (OAT) sensitivity
- Vary each species parameter ±20% and measure change in:  
  - Peak adult abundance.  
  - Time to peak.  
  - Total mosquito‑days.  
- Identify most influential parameters (likely fecundity and adult mortality).

### 5.2 Global sensitivity (e.g., Sobol indices)
- Use Latin Hypercube sampling (n=1000) of all parameters simultaneously.  
- Compute first‑order and total‑order Sobol indices for each output metric.

### 5.3 Uncertainty propagation
- Run 100 ensemble simulations with parameter sets drawn from literature uncertainty ranges (e.g., ± standard deviation).  
- Report prediction intervals (5th–95th percentiles) for adult abundance.

---

## Step 6: Scenario Analysis & Surveillance Utility

### 6.1 What‑if scenarios (policy relevant)
- **Intervention**: simulate indoor residual spraying (IRS) or larviciding – reduce adult survival or tank larval survival by a certain percentage.  
- **Climate change**: shift temperature by +2°C, change precipitation patterns.  
- **Urbanisation**: increase building/population density.

### 6.2 Risk mapping
- Use simulation output to produce **high‑resolution (100 m) risk maps** of adult mosquito abundance and tank occupancy.  
- Validate against independent household survey of mosquito presence.

### 6.3 Early warning thresholds
- Identify meteorological triggers (e.g., 3 consecutive days of temperature >25°C and rainfall >10 mm) that precede a simulated outbreak by 2 weeks.  
- Propose a **decision support tool**: when conditions are met, issue surveillance alert.

---

## Step 7: Reproducibility & Reporting

### 7.1 Code & data archive
- Package simulation code, YAML configuration, input rasters, and analysis notebooks in a public repository (e.g., Zenodo, GitHub).  
- Include a Dockerfile or Conda environment for exact reproducibility.

### 7.2 Reporting standards (TRACE & ODD protocols)
- Follow **TRACE** (Transparent and Comprehensive Ecological Modelling) documentation.  
- Provide an **ODD** (Overview, Design concepts, Details) protocol for the model.

### 7.3 Benchmarking
- Compare simulation output with a simpler model (e.g., temperature‑driven degree‑day model without spatial component) to demonstrate added value of agent‑based, spatial approach.

---

## Step 8: Publication & Communication

### 8.1 Target journals
- *Ecological Modelling*, *PLOS Neglected Tropical Diseases*, *Malaria Journal*, *Environmental Modelling & Software*.

### 8.2 Key figures for publication
- **Fig 1**: Study area map with tank locations and mosquito trap sites.  
- **Fig 2**: Time series of simulated vs observed adult abundance (with uncertainty bands).  
- **Fig 3**: Spatial risk map of adult mosquitoes at peak transmission season.  
- **Fig 4**: Sensitivity tornado plot (most influential parameters).  
- **Fig 5**: Scenario comparison (e.g., baseline vs IRS vs climate change).

### 8.3 Policy brief
- Translate findings into actionable recommendations for Dire Dawa vector control:  
  - When and where to concentrate larviciding.  
  - Which meteorological indices predict high risk.

---

## Summary Checklist

| Step | Task | Output |
|------|------|--------|
| 1 | Compile field & remote data | Aligned datasets |
| 2 | Calibrate parameters | Calibrated model |
| 3 | Internal validation | Stage durations, spatial clustering |
| 4 | External validation | Correlation with field data |
| 5 | Sensitivity analysis | Sobol indices, prediction intervals |
| 6 | Scenario analysis | Policy recommendations, risk maps |
| 7 | Reproducibility | Public archive, ODD + TRACE |
| 8 | Dissemination | Manuscript, policy brief |

This evaluation framework ensures that MONADSIM is not only biologically plausible but also operationally useful for vector surveillance in resource‑limited settings.


A Metzler matrix is a matrix where all the off-diagonal elements are equal to or greater than 0.

Matrix do things to vectors. matrix scale vector: eighenvector (saw eighen value ealier). 
eighenvalue = value by which a matrix scales a vector.
Also checkout Markov Matrix.
Matrix - Equilibrium
