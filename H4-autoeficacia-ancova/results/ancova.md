ANCOVA test for `autoeficacia.pos`
================
Geiser C. Challco <geiser@alumni.usp.br>

-   [Initial Variables and Data](#initial-variables-and-data)
    -   [Descriptive statistics of initial
        data](#descriptive-statistics-of-initial-data)
-   [Checking of Assumptions](#checking-of-assumptions)
    -   [Assumption: Symmetry and treatment of
        outliers](#assumption-symmetry-and-treatment-of-outliers)
    -   [Assumption: Normality distribution of
        data](#assumption-normality-distribution-of-data)
    -   [Assumption: Linearity of dependent variables and covariate
        variable](#assumption-linearity-of-dependent-variables-and-covariate-variable)
    -   [Assumption: Homogeneity of data
        distribution](#assumption-homogeneity-of-data-distribution)
-   [Saving the Data with Normal Distribution Used for Performing ANCOVA
    Test](#saving-the-data-with-normal-distribution-used-for-performing-ancova-test)
-   [Computation of ANCOVA Test and Pairwise
    Comparison](#computation-of-ancova-test-and-pairwise-comparison)
    -   [ANCOVA test](#ancova-test)
    -   [Pairwise comparison](#pairwise-comparison)
    -   [Estimated Marginal Means and ANCOVA
        Plots](#estimated-marginal-means-and-ancova-plots)
    -   [Ancova plots for the dependent variable
        “autoeficacia.pos”](#ancova-plots-for-the-dependent-variable-autoeficacia.pos)
    -   [Textual Report](#textual-report)
-   [Tips and References](#tips-and-references)

## Initial Variables and Data

-   R-script file: [../code/ancova.R](../code/ancova.R)
-   Initial table file:
    [../data/initial-table.csv](../data/initial-table.csv)
-   Data for autoeficacia.pos
    [../data/table-for-autoeficacia.pos.csv](../data/table-for-autoeficacia.pos.csv)

### Descriptive statistics of initial data

| stType   | gender    | variable         |   n |  mean | median |   min |   max |    sd |    se |    ci |   iqr | symmetry | skewness | kurtosis |
|:---------|:----------|:-----------------|----:|------:|-------:|------:|------:|------:|------:|------:|------:|:---------|---------:|---------:|
| default  | Feminino  | autoeficacia.pos |  15 | 5.633 |  5.833 | 1.000 | 8.000 | 1.918 | 0.495 | 1.062 | 2.083 | NO       |   -0.706 |   -0.057 |
| default  | Masculino | autoeficacia.pos |  23 | 6.435 |  6.833 | 3.500 | 8.000 | 1.243 | 0.259 | 0.537 | 1.417 | NO       |   -0.623 |   -0.624 |
| stFemale | Feminino  | autoeficacia.pos |  12 | 5.944 |  6.083 | 3.667 | 7.667 | 1.272 | 0.367 | 0.808 | 1.667 | YES      |   -0.327 |   -1.242 |
| stFemale | Masculino | autoeficacia.pos |  29 | 6.264 |  6.333 | 3.167 | 8.000 | 1.222 | 0.227 | 0.465 | 1.333 | NO       |   -0.527 |    0.212 |
| stMale   | Feminino  | autoeficacia.pos |  20 | 5.775 |  6.333 | 2.500 | 7.500 | 1.547 | 0.346 | 0.724 | 2.375 | NO       |   -0.793 |   -0.613 |
| stMale   | Masculino | autoeficacia.pos |  43 | 6.984 |  7.167 | 5.667 | 8.000 | 0.682 | 0.104 | 0.210 | 1.000 | YES      |   -0.128 |   -0.967 |
| NA       | NA        | autoeficacia.pos | 142 | 6.347 |  6.500 | 1.000 | 8.000 | 1.316 | 0.110 | 0.218 | 1.333 | NO       |   -1.149 |    1.625 |
| default  | Feminino  | autoeficacia.pre |  15 | 6.378 |  6.000 | 2.167 | 8.000 | 1.641 | 0.424 | 0.909 | 2.250 | NO       |   -0.894 |    0.237 |
| default  | Masculino | autoeficacia.pre |  23 | 6.949 |  7.333 | 2.500 | 8.000 | 1.323 | 0.276 | 0.572 | 1.167 | NO       |   -1.812 |    3.106 |
| stFemale | Feminino  | autoeficacia.pre |  12 | 6.514 |  7.000 | 3.167 | 8.000 | 1.491 | 0.431 | 0.948 | 0.792 | NO       |   -1.186 |   -0.068 |
| stFemale | Masculino | autoeficacia.pre |  29 | 6.391 |  6.833 | 3.833 | 8.000 | 1.370 | 0.254 | 0.521 | 2.000 | NO       |   -0.597 |   -1.162 |
| stMale   | Feminino  | autoeficacia.pre |  20 | 5.542 |  6.083 | 1.000 | 8.000 | 1.940 | 0.434 | 0.908 | 2.208 | NO       |   -1.056 |    0.166 |
| stMale   | Masculino | autoeficacia.pre |  43 | 6.826 |  7.000 | 5.000 | 8.000 | 0.776 | 0.118 | 0.239 | 0.917 | YES      |   -0.491 |   -0.537 |
| NA       | NA        | autoeficacia.pre | 142 | 6.502 |  7.000 | 1.000 | 8.000 | 1.404 | 0.118 | 0.233 | 1.667 | NO       |   -1.491 |    2.461 |

![](/home/rstudio/report/ancova/692c758e31a511ea/results/ancova_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

## Checking of Assumptions

### Assumption: Symmetry and treatment of outliers

#### Applying transformation for skewness data when normality is not achieved in any dependent variables or covariance

Applying transformation in “autoeficacia.pos” to reduce skewness

``` r
density_res_plot(rdat[["autoeficacia.pos"]],"autoeficacia.pos",between,c(),covar)
```

![](/home/rstudio/report/ancova/692c758e31a511ea/results/ancova_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

``` r
rdat[["autoeficacia.pos"]][["autoeficacia.pos"]] <- sqrt(max(dat[["autoeficacia.pos"]][["autoeficacia.pos"]]+1) - dat[["autoeficacia.pos"]][["autoeficacia.pos"]])
rdat[["autoeficacia.pos"]][["autoeficacia.pre"]] <- log10(max(dat[["autoeficacia.pos"]][["autoeficacia.pre"]]+1) - dat[["autoeficacia.pos"]][["autoeficacia.pre"]])
density_res_plot(rdat[["autoeficacia.pos"]],"autoeficacia.pos",between,c(),covar)
```

![](/home/rstudio/report/ancova/692c758e31a511ea/results/ancova_files/figure-gfm/unnamed-chunk-6-2.png)<!-- -->

#### Dealing with outliers (performing treatment of outliers)

``` r
rdat[["autoeficacia.pos"]] <- winzorize(rdat[["autoeficacia.pos"]],"autoeficacia.pos", c("stType","gender"),"autoeficacia.pre")
```

### Assumption: Normality distribution of data

#### Removing data that affect normality (extreme values)

``` r
non.normal <- list(
"autoeficacia.pos" = c("p37","p44","p50","p63","p69","p105","p04","p09","p10","p27","p28","p49","p79","p86","p88","p101","p110","p111","p121","p134","p142","p29","p48","p109","p120")
)
sdat <- remove_from_datatable(rdat, non.normal, wid)
```

    ## [1] "autoeficacia.pos"

#### Result of normality test in the residual model

|                  | var              |   n | skewness | kurtosis | symmetry | statistic | method     |     p | p.signif | normality |
|:-----------------|:-----------------|----:|---------:|---------:|:---------|----------:|:-----------|------:|:---------|:----------|
| autoeficacia.pos | autoeficacia.pos | 117 |     0.16 |    0.224 | YES      |     1.366 | D’Agostino | 0.505 | ns       | QQ        |

#### Result of normality test in each group

This is an optional validation and only performed for groups with number
greater than 30 observations

| stType   | gender    | variable         |   n |  mean | median |   min |   max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:----------|:-----------------|----:|------:|-------:|------:|------:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| default  | Feminino  | autoeficacia.pos |  15 | 1.723 |  1.780 | 1.000 | 2.306 | 0.458 | 0.118 | 0.254 | 0.588 | YES       | Shapiro-Wilk |     0.904 | 0.111 | ns       |
| default  | Masculino | autoeficacia.pos |  23 | 1.547 |  1.472 | 1.000 | 2.113 | 0.364 | 0.076 | 0.157 | 0.449 | YES       | Shapiro-Wilk |     0.932 | 0.119 | ns       |
| stFemale | Feminino  | autoeficacia.pos |  12 | 1.710 |  1.706 | 1.193 | 2.247 | 0.352 | 0.102 | 0.224 | 0.489 | YES       | Shapiro-Wilk |     0.960 | 0.783 | ns       |
| stFemale | Masculino | autoeficacia.pos |  27 | 1.644 |  1.633 | 1.000 | 2.200 | 0.325 | 0.062 | 0.128 | 0.290 | YES       | Shapiro-Wilk |     0.930 | 0.069 | ns       |
| stMale   | Feminino  | autoeficacia.pos |  14 | 1.886 |  1.933 | 1.472 | 2.306 | 0.318 | 0.085 | 0.183 | 0.543 | YES       | Shapiro-Wilk |     0.877 | 0.053 | ns       |
| stMale   | Masculino | autoeficacia.pos |  26 | 1.343 |  1.354 | 1.000 | 1.581 | 0.153 | 0.030 | 0.062 | 0.233 | YES       | Shapiro-Wilk |     0.924 | 0.056 | ns       |
| NA       | NA        | autoeficacia.pos | 117 | 1.604 |  1.581 | 1.000 | 2.306 | 0.362 | 0.033 | 0.066 | 0.517 | QQ        | D’Agostino   |     7.350 | 0.025 | ns       |

**Observation**:

As sample sizes increase, parametric tests remain valid even with the
violation of normality \[[1](#references)\]. According to the central
limit theorem, the sampling distribution tends to be normal if the
sample is large, more than (`n > 30`) observations. Therefore, we
performed parametric tests with large samples as described as follows:

-   In cases with the sample size greater than 100 (`n > 100`), we
    adopted a significance level of `p < 0.01`

-   For samples with `n > 50` observation, we adopted D’Agostino-Pearson
    test that offers better accuracy for larger samples
    \[[2](#references)\].

-   For samples’ size between `n > 100` and `n <= 200`, we ignored the
    normality test, and our decision of validating normality was based
    only in the interpretation of QQ-plots and histograms because the
    Shapiro-Wilk and D’Agostino-Pearson tests tend to be too sensitive
    with values greater than 200 observation \[[3](#references)\].

-   For samples with `n > 200` observation, we ignore the normality
    assumption based on the central theorem limit.

### Assumption: Linearity of dependent variables and covariate variable

-   Linearity test in “autoeficacia.pos”

``` r
ggscatter(sdat[["autoeficacia.pos"]], x=covar, y="autoeficacia.pos", facet.by=between, short.panel.labs = F) + 
stat_smooth(method = "loess", span = 0.9)
```

    ## `geom_smooth()` using formula 'y ~ x'

![](/home/rstudio/report/ancova/692c758e31a511ea/results/ancova_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

### Assumption: Homogeneity of data distribution

|                    | var              | method         | formula                      |   n | DFn.df1 | DFd.df2 | statistic |     p | p.signif |
|:-------------------|:-----------------|:---------------|:-----------------------------|----:|--------:|--------:|----------:|------:|:---------|
| autoeficacia.pos.1 | autoeficacia.pos | Levene’s test  | `.res` \~ `stType`\*`gender` | 117 |       5 |     111 |     2.855 | 0.018 | ns       |
| autoeficacia.pos.2 | autoeficacia.pos | Anova’s slopes | `.res` \~ `stType`\*`gender` | 117 |       5 |     105 |     1.163 | 0.332 | ns       |

## Saving the Data with Normal Distribution Used for Performing ANCOVA Test

Descriptive statistics of data with normal distribution

| stType   | gender    | variable         |   n |  mean | median |   min |   max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:----------|:-----------------|----:|------:|-------:|------:|------:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| default  | Feminino  | autoeficacia.pos |  15 | 1.723 |  1.780 | 1.000 | 2.306 | 0.458 | 0.118 | 0.254 | 0.588 | YES       | Shapiro-Wilk |     0.904 | 0.111 | ns       |
| default  | Masculino | autoeficacia.pos |  23 | 1.547 |  1.472 | 1.000 | 2.113 | 0.364 | 0.076 | 0.157 | 0.449 | YES       | Shapiro-Wilk |     0.932 | 0.119 | ns       |
| stFemale | Feminino  | autoeficacia.pos |  12 | 1.710 |  1.706 | 1.193 | 2.247 | 0.352 | 0.102 | 0.224 | 0.489 | YES       | Shapiro-Wilk |     0.960 | 0.783 | ns       |
| stFemale | Masculino | autoeficacia.pos |  27 | 1.644 |  1.633 | 1.000 | 2.200 | 0.325 | 0.062 | 0.128 | 0.290 | YES       | Shapiro-Wilk |     0.930 | 0.069 | ns       |
| stMale   | Feminino  | autoeficacia.pos |  14 | 1.886 |  1.933 | 1.472 | 2.306 | 0.318 | 0.085 | 0.183 | 0.543 | YES       | Shapiro-Wilk |     0.877 | 0.053 | ns       |
| stMale   | Masculino | autoeficacia.pos |  26 | 1.343 |  1.354 | 1.000 | 1.581 | 0.153 | 0.030 | 0.062 | 0.233 | YES       | Shapiro-Wilk |     0.924 | 0.056 | ns       |
| NA       | NA        | autoeficacia.pos | 117 | 1.604 |  1.581 | 1.000 | 2.306 | 0.362 | 0.033 | 0.066 | 0.517 | QQ        | D’Agostino   |     7.350 | 0.025 | ns       |

![](/home/rstudio/report/ancova/692c758e31a511ea/results/ancova_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

## Computation of ANCOVA Test and Pairwise Comparison

### ANCOVA test

| var              | Effect           | DFn | DFd |   SSn |   SSd |      F |     p |   ges | p.signif |
|:-----------------|:-----------------|----:|----:|------:|------:|-------:|------:|------:|:---------|
| autoeficacia.pos | autoeficacia.pre |   1 | 110 | 3.352 | 8.499 | 43.376 | 0.000 | 0.283 | \*\*\*\* |
| autoeficacia.pos | stType           |   2 | 110 | 0.773 | 8.499 |  5.003 | 0.008 | 0.083 | \*\*     |
| autoeficacia.pos | gender           |   1 | 110 | 0.710 | 8.499 |  9.185 | 0.003 | 0.077 | \*\*     |
| autoeficacia.pos | stType:gender    |   2 | 110 | 0.280 | 8.499 |  1.811 | 0.168 | 0.032 | ns       |

### Pairwise comparison

| var              | stType   | gender    | group1   | group2    | estimate |    se |  df | statistic |     p | p.adj | p.adj.signif |
|:-----------------|:---------|:----------|:---------|:----------|---------:|------:|----:|----------:|------:|------:|:-------------|
| autoeficacia.pos | NA       | Feminino  | default  | stFemale  |    0.022 | 0.108 | 110 |     0.206 | 0.837 | 1.000 | ns           |
| autoeficacia.pos | NA       | Feminino  | default  | stMale    |    0.035 | 0.108 | 110 |     0.322 | 0.748 | 1.000 | ns           |
| autoeficacia.pos | NA       | Feminino  | stFemale | stMale    |    0.012 | 0.113 | 110 |     0.110 | 0.912 | 1.000 | ns           |
| autoeficacia.pos | NA       | Masculino | default  | stFemale  |    0.020 | 0.081 | 110 |     0.242 | 0.809 | 1.000 | ns           |
| autoeficacia.pos | NA       | Masculino | default  | stMale    |    0.257 | 0.080 | 110 |     3.214 | 0.002 | 0.005 | \*\*         |
| autoeficacia.pos | NA       | Masculino | stFemale | stMale    |    0.238 | 0.077 | 110 |     3.086 | 0.003 | 0.008 | \*\*         |
| autoeficacia.pos | default  | NA        | Feminino | Masculino |    0.100 | 0.093 | 110 |     1.074 | 0.285 | 0.285 | ns           |
| autoeficacia.pos | stFemale | NA        | Feminino | Masculino |    0.097 | 0.097 | 110 |     1.007 | 0.316 | 0.316 | ns           |
| autoeficacia.pos | stMale   | NA        | Feminino | Masculino |    0.322 | 0.098 | 110 |     3.286 | 0.001 | 0.001 | \*\*         |

### Estimated Marginal Means and ANCOVA Plots

| var              | stType   | gender    | autoeficacia.pre |   n | emmean | se.emms | conf.low | conf.high |  mean | median |    sd |    ci |
|:-----------------|:---------|:----------|-----------------:|----:|-------:|--------:|---------:|----------:|------:|-------:|------:|------:|
| autoeficacia.pos | default  | Feminino  |            0.345 |  15 |  1.737 |   0.072 |    1.595 |     1.879 | 1.723 |  1.780 | 0.458 | 0.254 |
| autoeficacia.pos | default  | Masculino |            0.345 |  23 |  1.637 |   0.060 |    1.519 |     1.755 | 1.547 |  1.472 | 0.364 | 0.157 |
| autoeficacia.pos | stFemale | Feminino  |            0.345 |  12 |  1.715 |   0.080 |    1.556 |     1.874 | 1.710 |  1.706 | 0.352 | 0.224 |
| autoeficacia.pos | stFemale | Masculino |            0.345 |  27 |  1.617 |   0.054 |    1.511 |     1.724 | 1.644 |  1.633 | 0.325 | 0.128 |
| autoeficacia.pos | stMale   | Feminino  |            0.345 |  14 |  1.702 |   0.079 |    1.545 |     1.859 | 1.886 |  1.933 | 0.318 | 0.183 |
| autoeficacia.pos | stMale   | Masculino |            0.345 |  26 |  1.380 |   0.055 |    1.271 |     1.488 | 1.343 |  1.354 | 0.153 | 0.062 |

### Ancova plots for the dependent variable “autoeficacia.pos”

``` r
plots <- twoWayAncovaPlots(sdat[["autoeficacia.pos"]], "autoeficacia.pos", between
, aov[["autoeficacia.pos"]], pwc[["autoeficacia.pos"]], font.label.size=14, step.increase=0.25)
```

#### Plot for: `autoeficacia.pos` \~ `stType`

``` r
plots[["stType"]]
```

![](/home/rstudio/report/ancova/692c758e31a511ea/results/ancova_files/figure-gfm/unnamed-chunk-27-1.png)<!-- -->

#### Plot for: `autoeficacia.pos` \~ `gender`

``` r
plots[["gender"]]
```

![](/home/rstudio/report/ancova/692c758e31a511ea/results/ancova_files/figure-gfm/unnamed-chunk-28-1.png)<!-- -->

### Textual Report

After controlling the linearity of covariance “autoeficacia.pre”, ANCOVA
tests with independent between-subjects variables “stType” (default,
stFemale, stMale) and “gender” (Feminino, Masculino) were performed to
determine statistically significant difference on the dependent varibles
“autoeficacia.pos”. For the dependent variable “autoeficacia.pos”, there
was statistically significant effects in the factor “autoeficacia.pre”
with F(1,110)=43.376, p&lt;0.001 and ges=0.283 (effect size) and in the
factor “stType” with F(2,110)=5.003, p=0.008 and ges=0.083 (effect size)
and in the factor “gender” with F(1,110)=9.185, p=0.003 and ges=0.077
(effect size).

Pairwise comparisons using the Estimated Marginal Means (EMMs) were
computed to find statistically significant diferences among the groups
defined by the independent variables, and with the p-values ajusted by
the method “bonferroni”. For the dependent variable “autoeficacia.pos”,
the mean in the stType=“default” (adj M=1.637 and SD=0.364) was
significantly different than the mean in the stType=“stMale” (adj M=1.38
and SD=0.153) with p-adj=0.005; the mean in the stType=“stFemale” (adj
M=1.617 and SD=0.325) was significantly different than the mean in the
stType=“stMale” (adj M=1.38 and SD=0.153) with p-adj=0.008; the mean in
the gender=“Feminino” (adj M=1.702 and SD=0.318) was significantly
different than the mean in the gender=“Masculino” (adj M=1.38 and
SD=0.153) with p-adj=0.001.

## Tips and References

-   Use the site <https://www.tablesgenerator.com> to convert the HTML
    tables into Latex format

-   \[1\]: Ghasemi, A., & Zahediasl, S. (2012). Normality tests for
    statistical analysis: a guide for non-statisticians. International
    journal of endocrinology and metabolism, 10(2), 486.

-   \[2\]: Miot, H. A. (2017). Assessing normality of data in clinical
    and experimental trials. J Vasc Bras, 16(2), 88-91.

-   \[3\]: Bárány, Imre; Vu, Van (2007). “Central limit theorems for
    Gaussian polytopes”. Annals of Probability. Institute of
    Mathematical Statistics. 35 (4): 1593–1621.
