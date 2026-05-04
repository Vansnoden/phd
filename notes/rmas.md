
# The biology and Anopheles stephensi

[Agboka et al 2026](https://doi.org/10.1016/j.ecolmodel.2025.111386) Temperature- and host-driven model of Phlebotomus papatasi outbreak potential under climate change in Sudan.

[Agboka et al 2025](https://doi.org/10.1111/ppl.70659) Dual Perspectives From Mechanistic and Correlative Approaches in Mapping the Distribution of the Lesser Mealworm Alphitobius diaperinus.

[Justin et al 2023](https://doi.org/10.1016/j.parint.2022.102715) provides information of the biology of *Anopheles stephensi* (Diptera: Culicidae) in Sri Lanka. The authors present the lifetable, biology and bionomics of the vector in thier local context. (Unfortunately not open access study)

[Meshesha et al 2020](https://doi.org/10.1186/s13071-020-3904-y) Geographical distribution of *Anopheles stephensi* in eastern Ethiopia.

[Farah et al 2021](https://doi.org/10.1016/j.pt.2021.03.009) Anopheles stephensi (Asian Malaria Mosquito).




# Multi-agent systems

The system alows you to overlay climantic and environmental variable
as data layers.

On top of this layers you can then overlay agent layers

inert agent layers for agents who do not move during simualtion eventhough
thier internal states can change.

living agent layer, for agents who move accross landscape during the simulation. With living agent being able to interact with other agents
(living / inert) as well as the environment.

living agent ae intented to represent mosquitoes and follow a life cycle.

Egg -> Larva -> Pupa -> Adult -> Egg

The biology of the insect itself independently of any environmental
condition allows transition between these conditions following the 
following formulae found in [Agboka et al 2026](https://doi.org/10.1016/j.ecolmodel.2025.111386).


## Matrix formulation and system dynamics ([Agboka et al 2026](https://doi.org/10.1016/j.ecolmodel.2025.111386))

$ n(t) = \left [\begin{array}{c} E(t) \\ L(t) \\ P(t) \\ A(t) \end{array} \right]$

where $E(t)$, $L(t)$, $P(t)$, and $A(t)$ represent the abundances of eggs, larvae, pupae, and adult insects, respectively, at time $t$.

The population dynamics follow the linear differential equation:

$ { dn \over dt } =  M(T, p_{blood} ) ∗ n(t)$

where $M(T, p_{blood} )$ is a Metzler matrix, a continuous-time population
projection matrix whose off-diagonal elements are non-negative and vary
with temperature $T$ and host-seeking probabiliy $p_{blood}$ .

Each entry in $M(T, p_{blood} )$ captures a stage-specific demographic
rate: egg development, larval progression, pupal transition, adult sur­vival, or fecundity moderated by blood-meal availability. For instance,
the top-right entry reflects adult fecundity scaled by $p_{blood}$ , while diag­onal entries represent negative rates like mortality. The Metzler struc­ture ensures biologically realistic transitions between life stages.

Rather than projecting full stage abundances over time, we linearize
the model around equilibrium and focus on the dominant eigenvalue of
$M(T, p_{blood} )$, the eigenvalue with the largest real part (also called the spectral abscissa). This dominant eigenvalue directly
represents the instantaneous intrinsic growth rate of the population,
avoiding assumptions about stage distributions.

The Metzler matrix is defined as:

$M(T) = \left[ \begin{array}{cccc}  
-d_{E}(T) & 0 & 0 & F(t).p_{blood} \\
S_{E}(T).d_{E}(T) & -d_{L}(T) & 0 & 0 \\
0 & S_{L}(T).d_{L}(T) & -d_{p}(T) & 0 \\
0 & 0 & S_{p}(T).d_{p}(T) & -\mu_{A}(T)
\end{array} \right]$

Where:

| Variable | Definition | Mathematical expression | Parameter values | Reference to data provenance |
|:---|:---|:---|:---|:---|
| $F(t)$ | Fecundity rate function (eggs per female per day) | $ae^{bT} - e^{bTmax - \left({Tmax - T} \over {c}\right)}$ | a = 0.378, b = 0.173, Tmax = 40.0, c = 2.97 | [Ivana Benkova et al 2007](https://doi.org/10.1093/jmedent/41.5.150) |
| $d_E(T)$ | Development rate function for the egg stage | $max(0, − 0.0009 T^{2} + 0.048 T − 0.345)$ | Quadratic coefficients | [Kasap OE et al 2005](https://europepmc.org/article/med/16599172) |
| $d_L(T)$ | Development rate function for larval stage | $max(0, − 0.0007 T^{2} + 0.039 T − 0.32)$ | Quadratic coefficients | [Kasap OE et al 2005](https://europepmc.org/article/med/16599172) |
| $d_P(T)$ | Development rate function for the pupal stage | $max(0, − 0.0005T^{2} + 0.026T − 0.2)$ | Quadratic coefficients | [Kasap OE et al 2005](https://europepmc.org/article/med/16599172) |
| $S_E(T)$ | Survival rate function for eggs | $1.01exp\left( - 0.5 \left({T - 24.5} \over {4.8}\right)^2\right)$ | $\mu = 24.5, \sigma = 4.8$ | [Kasap OE et al 2005](https://europepmc.org/article/med/16599172) |
| $S_L(T)$ | Survival rate function for larvae | $0.95exp\left( - 0.5 \left({T - 27} \over {3.5}\right)^2\right)$ | $\mu = 27, \sigma = 3.5$ | [Kasap OE et al 2005](https://europepmc.org/article/med/16599172) |
| $S_P(T)$ | Survival rate function for pupae | $0.93exp\left( - 0.5 \left({T - 26.8} \over {3.8}\right)^2\right)$ | $\mu = 26.8, \sigma = 3.8$ | [Kasap OE et al 2005](https://europepmc.org/article/med/16599172) |
| $\mu_A(T)$ | Mortality rate function for adults | $max(0, - 0.00065T^{2} + 0.0364T - 0.4882)$ | Quadratic coefficients | [Ivana Benkova et al 2007](https://doi.org/10.1093/jmedent/41.5.150) |



The dominant eigenvalue is then calculated using: 

$\lambda max = max\{Re(λ) : det(M − λI) = 0\}$

The dominant eigenvalue λmax is the eigenvalue of the system matrix
with the largest real part. An eigenvalue is a number that describes how
a system changes when it follows its inherent growth or decay patterns
(Stewart, 2001). In our context λmax represents the instantaneous
intrinsic growth rate of the P. papatasi population: if it is greater than
zero, the population tends to increase; if less than zero, the population
declines; and if equal to zero, the population remains stable.
To account for host carrying capacity K (host amplification effects in
vector persistence), we scaled the matrix using a saturating function of
livestock density (L):

$K = 1 + log (1 + L)$

Livestock provides a more reliable proxy for sustained host avail­ability than raw population density, as livestock presence generally in­dicates nearby humans. Applying a logarithmic transformation accounts for saturating host effects, preventing unrealistic suitability inflation in areas with very high livestock densities and reflecting known density-dependent vector ecology (Keesing et al., 2006; Kilpatrick et al., 2006). When scaled by the host carrying capacity K (reflecting blood meal availability) (Eq. (5)) λmax . K defines the environmental suitability index (SI). This index captures how temperature and host availability jointly influence the vector’s ability to persist and reproduce.

$SI = λmax . K$



### Code conversiont of the Metzler matrix model:

### Specie's specification details

##### Species Parameters in `simulation.yaml`

The `species` section defines temperature‑dependent coefficients for the Metzler matrix life‑cycle model.  
All temperatures in the equations are in **degrees Celsius**. The simulation automatically converts Kelvin (from climate data) to Celsius before applying these formulas.

| Parameter | Description | Mathematical expression | Unit | Typical value (*An. stephensi*) |
|-----------|-------------|------------------------|------|--------------------------------|
| `fecundity_a` | Amplitude factor for fecundity | `F(T) = a · exp(b·T) – exp(b·Tmax – ((Tmax – T)/c)²)` | eggs·female⁻¹·day⁻¹ | 0.378 |
| `fecundity_b` | Exponential coefficient for fecundity | – | °C⁻¹ | 0.173 |
| `fecundity_Tmax` | Temperature where fecundity reaches zero | – | °C | 40.0 |
| `fecundity_c` | Shape parameter for the descending limb | – | °C | 2.97 |
| `egg_dev_a` | Quadratic coefficient for egg development rate | `dE(T) = max(0, a·T² + b·T + c)` | day⁻¹·°C⁻² | -0.0009 |
| `egg_dev_b` | Linear coefficient for egg development rate | – | day⁻¹·°C⁻¹ | 0.048 |
| `egg_dev_c` | Intercept for egg development rate | – | day⁻¹ | -0.345 |
| `larva_dev_a` | Quadratic coefficient for larval development rate | same quadratic form | day⁻¹·°C⁻² | -0.0007 |
| `larva_dev_b` | Linear coefficient for larval development rate | – | day⁻¹·°C⁻¹ | 0.039 |
| `larva_dev_c` | Intercept for larval development rate | – | day⁻¹ | -0.32 |
| `pupa_dev_a` | Quadratic coefficient for pupal development rate | same quadratic form | day⁻¹·°C⁻² | -0.0005 |
| `pupa_dev_b` | Linear coefficient for pupal development rate | – | day⁻¹·°C⁻¹ | 0.026 |
| `pupa_dev_c` | Intercept for pupal development rate | – | day⁻¹ | -0.2 |
| `egg_survival_amp` | Maximum survival probability for eggs | `S_E(T) = amp · exp( –0.5 · ((T – μ)/σ)² )` | dimensionless | 1.01 |
| `egg_survival_mean` | Optimal temperature for egg survival | μ | °C | 24.5 |
| `egg_survival_sigma` | Temperature tolerance width for eggs | σ | °C | 4.8 |
| `larva_survival_amp` | Maximum larval survival probability | same Gaussian form | dimensionless | 0.95 |
| `larva_survival_mean` | Optimal temperature for larval survival | μ | °C | 27.0 |
| `larva_survival_sigma` | Temperature tolerance width for larvae | σ | °C | 3.5 |
| `pupa_survival_amp` | Maximum pupal survival probability | same Gaussian form | dimensionless | 0.93 |
| `pupa_survival_mean` | Optimal temperature for pupal survival | μ | °C | 26.8 |
| `pupa_survival_sigma` | Temperature tolerance width for pupae | σ | °C | 3.8 |
| `adult_mort_a` | Quadratic coefficient for adult mortality rate | `μ_A(T) = max(0, a·T² + b·T + c)` | day⁻¹·°C⁻² | -0.00065 |
| `adult_mort_b` | Linear coefficient for adult mortality rate | – | day⁻¹·°C⁻¹ | 0.0364 |
| `adult_mort_c` | Intercept for adult mortality rate | – | day⁻¹ | -0.4882 |

**Notes:**

- Development rates (`dE`, `dL`, `dP`) are in **1/day**. The probability of completing a stage in one tick is `1 – exp(–rate · dt)`, where `dt` is the tick duration in days (e.g., 0.25/24 = 0.0104167 days for a 15‑minute tick).
- Survival probabilities (`S_E`, `S_L`, `S_P`) are applied **once** when the stage is completed (i.e., a larva that finishes development survives with probability `S_L`).
- Adult mortality is applied every tick as a daily rate converted to a per‑tick probability: `p_die = 1 – exp(–μ_A · dt)`.
- Fecundity `F(T)` is in **eggs per female per day**. The actual number of eggs laid per tick is:



==========================================================================================

[Agboka et al 2025](https://doi.org/10.1111/ppl.70659) Dual Perspectives From Mechanistic and Correlative Approaches in Mapping the Distribution of the Lesser Mealworm Alphitobius diaperinus.

life stages: egg (E), larva (L), pupa (P) and adult (A)

The population dynamics of the insect are governed by the following system of differential equations
(Rossini, Contarini, et al. 2022; Rossini, Bruzzone, et al. 2022; Ndjomatchoua et al. 2024):

Equation 1.
$\left(\begin{array}{c} 
{dE \over dt}\\
{dL \over dt}\\
{dP \over dt}\\
{dA \over dt}
\end{array}\right) = 
\left(\begin{array}{cccc}
-(D_E + M_E) & 0 & 0 & F.S_r \\
D_E & -(D_L + M_L) & 0 & 0 \\
0 & D_L & - (D_P + M_P) & 0 \\
0 & 0 & D_P & -M_A 
\end{array}\right)
\left(\begin{array}{c}
E \\
L \\
P \\
A
\end{array}\right)
$

Where each symbol is described in the table bellow:

Table 1: Temperature-­dependent transition rates (development, mortality and fertility) included in Equation (1) were obtained from the current
literature for the case of Alphitobius diaperinus.

|Symbol|Biological meaning|Mathematical expression|Parameters|Data source|
|:---|:---|:---|:---|:----|
|$S_r$|Sex Ratio| - | 0.5 | Assumed|
|$D_E$|Egg developmental rate| $e^{\rho T - e^{\rho k - {k-T \over \Delta}}} + \lambda$ | $\begin{array}{c}\rho = 0.01107\\ k = 41.54210 \\ \Delta = 0.98086 \\ \lambda = − 1.14079 \end{array}$ | Rueda and Axtell (1996); Wilson and Miner (1969)|
|$D_L$|Larva developmental rate| $aT(T-T_{min})(T_{max}-T)^{1 \over m}$ | $\begin{array}{c} a = 3.285e − 05 \\T_{min} = 1.732e + 01\\ T_{max} = 4.088e + 01 \\m = 2.169e + 00\end{array}$ |  Rueda and Axtell (1996); Wilson and Miner (1969) |
|$D_P$|Pupa developmental rate| $e^{\rho T - e^{\rho k - {k-T \over \Delta}}} + \lambda$ | $\begin{array}{c}\rho = 0.0096287\\ k = 41.1843270 \\ \Delta = 0.9295908 \\ \lambda = − 1.1507102 \end{array}$ |  Rueda and Axtell (1996); Wilson and Miner (1969)|
|$M_E$|Egg mortality rate| $ e^{b_1 + b_2 T + b_3 T^2} $ | $\begin{array}{c}b_1 = 3.572876\\ b_2 = − 0.323474 \\ b_3 = 0.004941 \end{array}$ |  Rueda and Axtell (1996); Wilson and Miner (1969)|
|$M_L$|Larva mortality rate| $ e^{b_1 + b_2 T + b_3 T^2} $ | $\begin{array}{c}b_1 = 3.572876\\ b_2 = − 0.323474 \\ b_3 = 0.004941 \end{array}$ |  Rueda and Axtell (1996); Wilson and Miner (1969)|
|$M_P$|Pupa mortality rate| $ e^{b_1 + b_2 T + b_3 T^2} $ | $\begin{array}{c}b_1 = 5.882576\\ b_2 = − 0.578528 \\ b_3 = 0.009458 \end{array}$ |  Rueda and Axtell (1996); Wilson and Miner (1969)|
|$F$|Female Fecundity rate| $ e^{r_{max} + c(T_{opt} - T)^2} $ | $\begin{array}{c}r_{max} = 1.571304\\ T_{opt} = 32.908160 \\ c = − 0.007832 \end{array}$ | Wilson and Miner (1969)|
|$M_A$|Adult mortality rate| $ 1 \over 240 $ | $Days^{-1}$ | Sammarco et al. (2023)|

The effect of temperature on bio-­demographic parameters of the
lesser mealworm A. diaperinus, instead, has been investigated 
by several authors and summarised in Wilson and Miner (1969),
Rueda and Axtell (1996), Renault et al. (2004), and Muzio
et al. (2024). A complete list of the temperature-­
dependent
transition rates needed by the model (1) and the corresponding
parameters retrieved from the cited literature is provided in
Table 1.
Equation (1) is the starting point to compute the RI. The
RI derives from the condition for the stability of the system
det (−Ω) > 0 (Ndjomatchoua et al. 2024), where Ω is the 4 × 4
core matrix associated with the system (1). The resulting condi-
tion for stability can be written as:

Equation 2:
${{F S_r D_E D_L D_P}\over{(D_E + M_E)(D_L + M_L)(D_P + M_P)M_A}} < 1$

The left-­hand side of the Equation (2) is the risk index (RI):

$ RI = {{F S_r D_E D_L D_P}\over{(D_E + M_E)(D_L + M_L)(D_P + M_P)M_A}} $

Equation (3) indicates a lesser mealworm population increase
for RI > 1 and a decreasing trend otherwise.

Temperature values were retrieved from climatic research unit
(CRU) 4.8 (1901–2023) (Harris et al. 2020) and subsequently
processed into long-­term monthly averages. The computed RI
using R software (R Core Team 2024) was then applied to these
spatial temperature matrices to compute annual, quarterly and
trimestral risk maps, providing a time-­varying perspective on
the mealworm distribution dynamics.














