ANCOVA test for `autoeficacia.pos`\~`autoeficacia.pre`+`condicao`
================
Geiser C. Challco <geiser@alumni.usp.br>

- <a href="#initial-variables-and-data"
  id="toc-initial-variables-and-data">Initial Variables and Data</a>
  - <a href="#descriptive-statistics-of-initial-data"
    id="toc-descriptive-statistics-of-initial-data">Descriptive statistics
    of initial data</a>
- <a href="#checking-of-assumptions"
  id="toc-checking-of-assumptions">Checking of Assumptions</a>
  - <a href="#assumption-symmetry-and-treatment-of-outliers"
    id="toc-assumption-symmetry-and-treatment-of-outliers">Assumption:
    Symmetry and treatment of outliers</a>
  - <a href="#assumption-normality-distribution-of-data"
    id="toc-assumption-normality-distribution-of-data">Assumption: Normality
    distribution of data</a>
  - <a
    href="#assumption-linearity-of-dependent-variables-and-covariate-variable"
    id="toc-assumption-linearity-of-dependent-variables-and-covariate-variable">Assumption:
    Linearity of dependent variables and covariate variable</a>
  - <a href="#assumption-homogeneity-of-data-distribution"
    id="toc-assumption-homogeneity-of-data-distribution">Assumption:
    Homogeneity of data distribution</a>
- <a
  href="#saving-the-data-with-normal-distribution-used-for-performing-ancova-test"
  id="toc-saving-the-data-with-normal-distribution-used-for-performing-ancova-test">Saving
  the Data with Normal Distribution Used for Performing ANCOVA test</a>
- <a href="#computation-of-ancova-test-and-pairwise-comparison"
  id="toc-computation-of-ancova-test-and-pairwise-comparison">Computation
  of ANCOVA test and Pairwise Comparison</a>
  - <a href="#ancova-test" id="toc-ancova-test">ANCOVA test</a>
  - <a href="#pairwise-comparison" id="toc-pairwise-comparison">Pairwise
    comparison</a>
  - <a href="#descriptive-statistic-of-estimated-marginal-means"
    id="toc-descriptive-statistic-of-estimated-marginal-means">Descriptive
    Statistic of Estimated Marginal Means</a>
  - <a href="#ancova-plots-for-the-dependent-variable-autoeficaciapos"
    id="toc-ancova-plots-for-the-dependent-variable-autoeficaciapos">Ancova
    plots for the dependent variable “autoeficacia.pos”</a>
  - <a href="#textual-report" id="toc-textual-report">Textual Report</a>
- <a href="#tips-and-references" id="toc-tips-and-references">Tips and
  References</a>

## Initial Variables and Data

- R-script file: [../code/ancova.R](../code/ancova.R)
- Initial table file:
  [../data/initial-table.csv](../data/initial-table.csv)
- Data for autoeficacia.pos
  [../data/table-for-autoeficacia.pos.csv](../data/table-for-autoeficacia.pos.csv)
- Table without outliers and normal distribution of data:
  [../data/table-with-normal-distribution.csv](../data/table-with-normal-distribution.csv)
- Other data files: [../data/](../data/)
- Files related to the presented results: [../results/](../results/)

### Descriptive statistics of initial data

| condicao | variable         |   n |  mean | median |   min | max |    sd |    se |    ci |   iqr | symmetry | skewness | kurtosis |
|:---------|:-----------------|----:|------:|-------:|------:|----:|------:|------:|------:|------:|:---------|---------:|---------:|
| inBoost  | autoeficacia.pos |  55 | 6.758 |  6.833 | 3.667 |   8 | 0.938 | 0.126 | 0.254 | 1.167 | NO       |   -1.012 |    1.251 |
| inThreat | autoeficacia.pos |  49 | 6.065 |  6.333 | 2.500 |   8 | 1.370 | 0.196 | 0.394 | 1.333 | NO       |   -0.804 |    0.242 |
| neutro   | autoeficacia.pos |  38 | 6.118 |  6.417 | 1.000 |   8 | 1.571 | 0.255 | 0.516 | 1.958 | NO       |   -0.991 |    1.028 |
| NA       | autoeficacia.pos | 142 | 6.347 |  6.500 | 1.000 |   8 | 1.316 | 0.110 | 0.218 | 1.333 | NO       |   -1.149 |    1.625 |

![](ancova_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

    ## [1] "p55"  "p119" "p46"  "p47"  "p64"  "p73"  "p140"

## Checking of Assumptions

### Assumption: Symmetry and treatment of outliers

#### Applying transformation for skewness data when normality is not achieved

Applying transformation in “autoeficacia.pos” to reduce skewness

``` r
density.plot.by.residual(rdat[["autoeficacia.pos"]],"autoeficacia.pos",between,c(),covar)
```

![](ancova_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

``` r
rdat[["autoeficacia.pos"]][["std.autoeficacia.pos"]] <- -1*sqrt(max(dat[["autoeficacia.pos"]][["autoeficacia.pos"]]+1) - dat[["autoeficacia.pos"]][["autoeficacia.pos"]])

density.plot.by.residual(rdat[["autoeficacia.pos"]],"std.autoeficacia.pos",between,c(),covar)
```

![](ancova_files/figure-gfm/unnamed-chunk-6-2.png)<!-- -->

#### Dealing with outliers (performing treatment of outliers)

``` r
rdat[["autoeficacia.pos"]] <- winzorize(rdat[["autoeficacia.pos"]],"autoeficacia.pos", c("condicao"),covar, skewness=skewness)
```

### Assumption: Normality distribution of data

#### Removing data that affect normality (extreme values)

``` r
non.normal <- list(

)
sdat <- removeFromDataTable(rdat, non.normal, wid)
```

#### Result of normality test in the residual model

|                  | var              |   n | skewness | kurtosis | symmetry | statistic | method     |     p | p.signif | normality |
|:-----------------|:-----------------|----:|---------:|---------:|:---------|----------:|:-----------|------:|:---------|:----------|
| autoeficacia.pos | autoeficacia.pos | 142 |   -0.477 |    0.241 | YES      |      6.38 | D’Agostino | 0.041 | ns       | QQ        |

#### Result of normality test in each group

This is an optional validation and only valid for groups with number
greater than 30 observations

| condicao | variable         |   n |   mean | median |    min | max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:-----------------|----:|-------:|-------:|-------:|----:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| inBoost  | autoeficacia.pos |  55 | -1.467 | -1.472 | -2.309 |  -1 | 0.303 | 0.041 | 0.082 | 0.408 | YES       | D’Agostino   |     2.551 | 0.279 | ns       |
| inThreat | autoeficacia.pos |  49 | -1.668 | -1.633 | -2.550 |  -1 | 0.394 | 0.056 | 0.113 | 0.399 | YES       | Shapiro-Wilk |     0.969 | 0.223 | ns       |
| neutro   | autoeficacia.pos |  38 | -1.638 | -1.605 | -2.828 |  -1 | 0.450 | 0.073 | 0.148 | 0.593 | YES       | Shapiro-Wilk |     0.957 | 0.153 | ns       |

**Observation**:

As sample sizes increase, parametric tests remain valid even with the
violation of normality \[[1](#references)\]. According to the central
limit theorem, the sampling distribution tends to be normal if the
sample is large, more than (`n > 30`) observations. Therefore, we
performed parametric tests with large samples as described as follows:

- In cases with the sample size greater than 100 (`n > 100`), we adopted
  a significance level of `p < 0.01`

- For samples with `n > 50` observation, we adopted D’Agostino-Pearson
  test that offers better accuracy for larger samples
  \[[2](#references)\].

- For samples’ size between `n > 100` and `n <= 200`, we ignored the
  normality test, and our decision of validating normality was based
  only in the interpretation of QQ-plots and histograms because the
  Shapiro-Wilk and D’Agostino-Pearson tests tend to be too sensitive
  with values greater than 200 observation \[[3](#references)\].

- For samples with `n > 200` observation, we ignore the normality
  assumption based on the central theorem limit.

### Assumption: Linearity of dependent variables and covariate variable

``` r
ggscatter(sdat[["autoeficacia.pos"]], x=covar, y="autoeficacia.pos", facet.by=between, short.panel.labs = F) + 
 stat_smooth(method = "lm", span = 0.9)
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](ancova_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

### Assumption: Homogeneity of data distribution

|                    | var              | method         | formula            |   n | DFn.df1 | DFd.df2 | statistic |     p | p.signif |
|:-------------------|:-----------------|:---------------|:-------------------|----:|--------:|--------:|----------:|------:|:---------|
| autoeficacia.pos.1 | autoeficacia.pos | Levene’s test  | `.res`\~`condicao` | 142 |       2 |     139 |     1.833 | 0.164 | ns       |
| autoeficacia.pos.2 | autoeficacia.pos | Anova’s slopes | `.res`\~`condicao` | 142 |       2 |     136 |     0.928 | 0.398 | ns       |

## Saving the Data with Normal Distribution Used for Performing ANCOVA test

``` r
ndat <- sdat[[1]]
for (dv in names(sdat)[-1]) ndat <- merge(ndat, sdat[[dv]])
write.csv(ndat, paste0("../data/table-with-normal-distribution.csv"))
```

Descriptive statistics of data with normal distribution

|                    | condicao | variable         |   n |  mean | median |   min | max |    sd |    se |    ci |   iqr |
|:-------------------|:---------|:-----------------|----:|------:|-------:|------:|----:|------:|------:|------:|------:|
| autoeficacia.pos.1 | inBoost  | autoeficacia.pos |  55 | 6.810 |  6.833 | 5.183 |   8 | 0.803 | 0.108 | 0.217 | 1.167 |
| autoeficacia.pos.2 | inThreat | autoeficacia.pos |  49 | 6.127 |  6.333 | 3.683 |   8 | 1.226 | 0.175 | 0.352 | 1.333 |
| autoeficacia.pos.3 | neutro   | autoeficacia.pos |  38 | 6.203 |  6.417 | 3.683 |   8 | 1.356 | 0.220 | 0.446 | 1.958 |

![](ancova_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

## Computation of ANCOVA test and Pairwise Comparison

### ANCOVA test

| var              | Effect           | DFn | DFd |    SSn |     SSd |      F | p       |   ges | p.signif |
|:-----------------|:-----------------|----:|----:|-------:|--------:|-------:|:--------|------:|:---------|
| autoeficacia.pos | autoeficacia.pre |   1 | 138 | 68.184 | 106.856 | 88.057 | \<0.001 | 0.390 | \*\*\*\* |
| autoeficacia.pos | condicao         |   2 | 138 |  8.778 | 106.856 |  5.668 | 0.004   | 0.076 | \*\*     |

### Pairwise comparison

| var              | group1   | group2   | estimate | conf.low | conf.high |    se | statistic | p       | p.adj | p.adj.signif |
|:-----------------|:---------|:---------|---------:|---------:|----------:|------:|----------:|:--------|------:|:-------------|
| autoeficacia.pos | inBoost  | inThreat |    0.267 |   -0.086 |     0.620 | 0.178 |     1.497 | 0.137   | 0.410 | ns           |
| autoeficacia.pos | inBoost  | neutro   |    0.625 |    0.258 |     0.992 | 0.186 |     3.366 | \<0.001 | 0.003 | \*\*         |
| autoeficacia.pos | inThreat | neutro   |    0.358 |   -0.029 |     0.745 | 0.196 |     1.827 | 0.07    | 0.210 | ns           |

### Descriptive Statistic of Estimated Marginal Means

| var              | condicao |   n | M (pre) | SE (pre) | M (unadj) | SE (unadj) | M (adj) | SE (adj) |
|:-----------------|:---------|----:|--------:|---------:|----------:|-----------:|--------:|---------:|
| autoeficacia.pos | inBoost  |  55 |   6.815 |    0.108 |     6.810 |      0.108 |   6.671 |    0.120 |
| autoeficacia.pos | inThreat |  49 |   6.146 |    0.199 |     6.127 |      0.175 |   6.404 |    0.129 |
| autoeficacia.pos | neutro   |  38 |   6.844 |    0.186 |     6.203 |      0.220 |   6.047 |    0.144 |

| var              | condicao | autoeficacia.pre | emmean | se.emms |  df | conf.low | conf.high | method       |   n |  mean | median |   min | max |    sd |    se |    ci |   iqr | n.autoeficacia.pre | mean.autoeficacia.pre | median.autoeficacia.pre | min.autoeficacia.pre | max.autoeficacia.pre | sd.autoeficacia.pre | se.autoeficacia.pre | ci.autoeficacia.pre | iqr.autoeficacia.pre | sd.emms |
|:-----------------|:---------|-----------------:|-------:|--------:|----:|---------:|----------:|:-------------|----:|------:|-------:|------:|----:|------:|------:|------:|------:|-------------------:|----------------------:|------------------------:|---------------------:|---------------------:|--------------------:|--------------------:|--------------------:|---------------------:|--------:|
| autoeficacia.pos | inBoost  |            6.592 |  6.671 |   0.120 | 138 |    6.435 |     6.908 | Emmeans test |  55 | 6.810 |  6.833 | 5.183 |   8 | 0.803 | 0.108 | 0.217 | 1.167 |                 55 |                 6.815 |                   7.000 |                5.117 |                8.000 |               0.805 |               0.108 |               0.218 |                0.917 |   0.887 |
| autoeficacia.pos | inThreat |            6.592 |  6.404 |   0.129 | 138 |    6.149 |     6.660 | Emmeans test |  49 | 6.127 |  6.333 | 3.683 |   8 | 1.226 | 0.175 | 0.352 | 1.333 |                 49 |                 6.146 |                   6.500 |                3.667 |                7.933 |               1.394 |               0.199 |               0.401 |                2.333 |   0.904 |
| autoeficacia.pos | neutro   |            6.592 |  6.047 |   0.144 | 138 |    5.762 |     6.331 | Emmeans test |  38 | 6.203 |  6.417 | 3.683 |   8 | 1.356 | 0.220 | 0.446 | 1.958 |                 38 |                 6.844 |                   7.333 |                4.625 |                8.000 |               1.149 |               0.186 |               0.378 |                1.917 |   0.886 |

### Ancova plots for the dependent variable “autoeficacia.pos”

``` r
plots <- oneWayAncovaPlots(sdat[["autoeficacia.pos"]], "autoeficacia.pos", between
, aov[["autoeficacia.pos"]], pwc[["autoeficacia.pos"]], addParam = c("jitter"), font.label.size=14, step.increase=0.25, p.label="p.adj")
```

#### Plot for: `autoeficacia.pos` \~ `condicao`

``` r
plots[["condicao"]]
```

![](ancova_files/figure-gfm/unnamed-chunk-27-1.png)<!-- -->

### Textual Report

After controlling the linearity of covariance “autoeficacia.pre”, ANCOVA
tests with independent between-subjects variables “condicao” (inBoost,
inThreat, neutro) were performed to determine statistically significant
difference on the dependent varibles “autoeficacia.pos”. For the
dependent variable “autoeficacia.pos”, there was statistically
significant effects in the factor “autoeficacia.pre” with
F(1,138)=88.057, p\<0.001 and ges=0.39 (effect size) and in the factor
“condicao” with F(2,138)=5.668, p=0.004 and ges=0.076 (effect size).

Pairwise comparisons using the Estimated Marginal Means (EMMs) were
computed to find statistically significant diferences among the groups
defined by the independent variables, and with the p-values ajusted by
the method “bonferroni”. For the dependent variable “autoeficacia.pos”,
the mean in the condicao=“inBoost” (adj M=6.671 and SD=0.803) was
significantly different than the mean in the condicao=“neutro” (adj
M=6.047 and SD=1.356) with p-adj=0.003.

## Tips and References

- Use the site <https://www.tablesgenerator.com> to convert the HTML
  tables into Latex format

- \[2\]: Miot, H. A. (2017). Assessing normality of data in clinical and
  experimental trials. J Vasc Bras, 16(2), 88-91.

- \[3\]: Bárány, Imre; Vu, Van (2007). “Central limit theorems for
  Gaussian polytopes”. Annals of Probability. Institute of Mathematical
  Statistics. 35 (4): 1593–1621.