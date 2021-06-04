Factorial ANOVA for `points`
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
    -   [Assumption: Homogeneity of data
        distribution](#assumption-homogeneity-of-data-distribution)
-   [Saving the Data with Normal Distribution Used for Performing ANCOVA
    Test](#saving-the-data-with-normal-distribution-used-for-performing-ancova-test)
-   [Computation of ANOVA Test and Pairwise
    Comparison](#computation-of-anova-test-and-pairwise-comparison)
    -   [ANOVA test](#anova-test)
    -   [Pairwise comparison](#pairwise-comparison)
    -   [Estimated Marginal Means and ANOVA
        Plots](#estimated-marginal-means-and-anova-plots)
    -   [Anova plots for the dependent variable
        “points”](#anova-plots-for-the-dependent-variable-points)
    -   [Textual Report](#textual-report)
-   [Tips and References](#tips-and-references)

## Initial Variables and Data

-   R-script file: [../code/ancova.R](../code/ancova.R)
-   Initial table file:
    [../data/initial-table.csv](../data/initial-table.csv)
-   Data for points
    [../data/table-for-points.csv](../data/table-for-points.csv)
-   Table without outliers and normal distribution of data:
    [../data/table-with-normal-distribution.csv](../data/table-with-normal-distribution.csv)
-   Other data files: [../data/](../data/)
-   Files related to the presented results: [../results/](../results/)

### Descriptive statistics of initial data

| stType   | gender    | variable |   n |   mean | median | min | max |    sd |    se |    ci |  iqr | symmetry | skewness | kurtosis |
|:---------|:----------|:---------|----:|-------:|-------:|----:|----:|------:|------:|------:|-----:|:---------|---------:|---------:|
| default  | Feminino  | points   |  15 |  9.267 |   11.0 |   1 |  16 | 5.418 | 1.399 | 3.000 | 9.00 | YES      |   -0.182 |   -1.646 |
| default  | Masculino | points   |  23 | 12.783 |   13.0 |   3 |  18 | 2.907 | 0.606 | 1.257 | 2.50 | NO       |   -1.142 |    3.556 |
| stFemale | Feminino  | points   |  12 | 10.250 |   11.5 |   3 |  16 | 4.535 | 1.309 | 2.882 | 7.50 | YES      |   -0.337 |   -1.576 |
| stFemale | Masculino | points   |  29 | 11.034 |   13.0 |   2 |  19 | 4.539 | 0.843 | 1.727 | 5.00 | NO       |   -0.736 |   -0.494 |
| stMale   | Feminino  | points   |  20 | 10.800 |   12.0 |   1 |  17 | 4.841 | 1.082 | 2.265 | 6.00 | NO       |   -0.580 |   -0.970 |
| stMale   | Masculino | points   |  43 | 13.674 |   15.0 |   2 |  20 | 5.003 | 0.763 | 1.540 | 4.00 | NO       |   -0.752 |   -0.192 |
| NA       | NA        | points   | 142 | 11.831 |   13.0 |   1 |  20 | 4.788 | 0.402 | 0.794 | 4.75 | NO       |   -0.610 |   -0.333 |

![](factorialAnova_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

## Checking of Assumptions

### Assumption: Symmetry and treatment of outliers

#### Applying transformation for skewness data when normality is not achieved in any dependent variables or covariance

Applying transformation in “points” to reduce skewness

``` r
density_res_plot(rdat[["points"]],"points",between)
```

![](factorialAnova_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

``` r
rdat[["points"]][["points"]] <- sqrt(max(dat[["points"]][["points"]]+1) - dat[["points"]][["points"]])
density_res_plot(rdat[["points"]],"points",between)
```

![](factorialAnova_files/figure-gfm/unnamed-chunk-6-2.png)<!-- -->

#### Dealing with outliers (performing treatment of outliers)

``` r
rdat[["points"]] <- winzorize(rdat[["points"]],"points", c("stType","gender"))
```

### Assumption: Normality distribution of data

#### Removing data that affect normality (extreme values)

``` r
non.normal <- list(
"points" = c("p140","p41","p124","p112","p133","p45","p64","p78","p84","p117","p122","p29","p79","p91","p96","p97","p136","p13","p27","p28")
)
sdat <- remove_from_datatable(rdat, non.normal, wid)
```

    ## [1] "points"

#### Result of normality test in the residual model

|        | var    |   n | skewness | kurtosis | symmetry | statistic | method     |     p | p.signif | normality |
|:-------|:-------|----:|---------:|---------:|:---------|----------:|:-----------|------:|:---------|:----------|
| points | points | 122 |    0.195 |   -0.286 | YES      |     0.994 | D’Agostino | 0.608 | ns       | QQ        |

#### Result of normality test in each group

This is an optional validation and only performed for groups with number
greater than 30 observations

| stType   | gender    | variable |   n |  mean | median |   min |   max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:----------|:---------|----:|------:|-------:|------:|------:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| default  | Feminino  | points   |  14 | 3.246 |  3.081 | 2.236 | 4.243 | 0.761 | 0.203 | 0.439 | 1.326 | YES       | Shapiro-Wilk |     0.887 | 0.073 | ns       |
| default  | Masculino | points   |  17 | 2.893 |  2.828 | 2.449 | 3.162 | 0.205 | 0.050 | 0.105 | 0.172 | YES       | Shapiro-Wilk |     0.901 | 0.069 | ns       |
| stFemale | Feminino  | points   |  12 | 3.216 |  3.081 | 2.353 | 4.177 | 0.666 | 0.192 | 0.423 | 1.160 | YES       | Shapiro-Wilk |     0.912 | 0.229 | ns       |
| stFemale | Masculino | points   |  25 | 2.921 |  2.828 | 2.236 | 4.243 | 0.486 | 0.097 | 0.201 | 0.517 | YES       | Shapiro-Wilk |     0.926 | 0.070 | ns       |
| stMale   | Feminino  | points   |  20 | 3.098 |  3.000 | 2.000 | 4.243 | 0.726 | 0.162 | 0.340 | 0.970 | YES       | Shapiro-Wilk |     0.936 | 0.202 | ns       |
| stMale   | Masculino | points   |  34 | 2.510 |  2.449 | 1.414 | 4.123 | 0.623 | 0.107 | 0.217 | 0.764 | YES       | Shapiro-Wilk |     0.938 | 0.053 | ns       |
| NA       | NA        | points   | 122 | 2.898 |  2.828 | 1.414 | 4.243 | 0.646 | 0.058 | 0.116 | 0.713 | QQ        | D’Agostino   |     1.730 | 0.421 | ns       |

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

### Assumption: Homogeneity of data distribution

|        | var    | method        | formula                        |   n | df1 | df2 | statistic |     p | p.signif |
|:-------|:-------|:--------------|:-------------------------------|----:|----:|----:|----------:|------:|:---------|
| points | points | Levene’s test | `points` \~ `stType`\*`gender` | 122 |   5 | 116 |     4.068 | 0.002 | \*       |

## Saving the Data with Normal Distribution Used for Performing ANCOVA Test

``` r
ndat <- sdat[[1]]
for (dv in names(sdat)[-1]) ndat <- merge(ndat, sdat[[dv]])
write.csv(ndat, paste0("../data/table-with-normal-distribution.csv"))
```

Descriptive statistics of data with normal distribution

| stType   | gender    | variable |   n |  mean | median |   min |   max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:----------|:---------|----:|------:|-------:|------:|------:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| default  | Feminino  | points   |  14 | 3.246 |  3.081 | 2.236 | 4.243 | 0.761 | 0.203 | 0.439 | 1.326 | YES       | Shapiro-Wilk |     0.887 | 0.073 | ns       |
| default  | Masculino | points   |  17 | 2.893 |  2.828 | 2.449 | 3.162 | 0.205 | 0.050 | 0.105 | 0.172 | YES       | Shapiro-Wilk |     0.901 | 0.069 | ns       |
| stFemale | Feminino  | points   |  12 | 3.216 |  3.081 | 2.353 | 4.177 | 0.666 | 0.192 | 0.423 | 1.160 | YES       | Shapiro-Wilk |     0.912 | 0.229 | ns       |
| stFemale | Masculino | points   |  25 | 2.921 |  2.828 | 2.236 | 4.243 | 0.486 | 0.097 | 0.201 | 0.517 | YES       | Shapiro-Wilk |     0.926 | 0.070 | ns       |
| stMale   | Feminino  | points   |  20 | 3.098 |  3.000 | 2.000 | 4.243 | 0.726 | 0.162 | 0.340 | 0.970 | YES       | Shapiro-Wilk |     0.936 | 0.202 | ns       |
| stMale   | Masculino | points   |  34 | 2.510 |  2.449 | 1.414 | 4.123 | 0.623 | 0.107 | 0.217 | 0.764 | YES       | Shapiro-Wilk |     0.938 | 0.053 | ns       |
| NA       | NA        | points   | 122 | 2.898 |  2.828 | 1.414 | 4.243 | 0.646 | 0.058 | 0.116 | 0.713 | QQ        | D’Agostino   |     1.730 | 0.421 | ns       |

![](factorialAnova_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

## Computation of ANOVA Test and Pairwise Comparison

### ANOVA test

| var    | Effect        | DFn | DFd |   SSn |    SSd |      F |     p |   ges | p.signif |
|:-------|:--------------|----:|----:|------:|-------:|-------:|------:|------:|:---------|
| points | stType        |   2 | 116 | 2.714 | 41.587 |  3.786 | 0.026 | 0.061 | \*       |
| points | gender        |   1 | 116 | 5.507 | 41.587 | 15.361 | 0.000 | 0.117 | \*\*\*   |
| points | stType:gender |   2 | 116 | 0.507 | 41.587 |  0.708 | 0.495 | 0.012 | ns       |

### Pairwise comparison

| var    | stType   | gender    | group1   | group2    | estimate |    se |  df | statistic |     p | p.adj | p.adj.signif |
|:-------|:---------|:----------|:---------|:----------|---------:|------:|----:|----------:|------:|------:|:-------------|
| points | NA       | Feminino  | default  | stFemale  |    0.030 | 0.236 | 116 |     0.126 | 0.900 | 1.000 | ns           |
| points | NA       | Feminino  | default  | stMale    |    0.147 | 0.209 | 116 |     0.706 | 0.482 | 1.000 | ns           |
| points | NA       | Feminino  | stFemale | stMale    |    0.118 | 0.219 | 116 |     0.538 | 0.591 | 1.000 | ns           |
| points | NA       | Masculino | default  | stFemale  |   -0.028 | 0.188 | 116 |    -0.147 | 0.883 | 1.000 | ns           |
| points | NA       | Masculino | default  | stMale    |    0.384 | 0.178 | 116 |     2.157 | 0.033 | 0.099 | ns           |
| points | NA       | Masculino | stFemale | stMale    |    0.411 | 0.158 | 116 |     2.607 | 0.010 | 0.031 | \*           |
| points | default  | NA        | Feminino | Masculino |    0.352 | 0.216 | 116 |     1.629 | 0.106 | 0.106 | ns           |
| points | stFemale | NA        | Feminino | Masculino |    0.295 | 0.210 | 116 |     1.402 | 0.164 | 0.164 | ns           |
| points | stMale   | NA        | Feminino | Masculino |    0.588 | 0.169 | 116 |     3.487 | 0.001 | 0.001 | \*\*\*       |

### Estimated Marginal Means and ANOVA Plots

| var    | stType   | gender    |   n | emmean | se.emms | conf.low | conf.high |  mean | median |    sd |    ci |
|:-------|:---------|:----------|----:|-------:|--------:|---------:|----------:|------:|-------:|------:|------:|
| points | default  | Feminino  |  14 |  3.246 |   0.160 |    2.929 |     3.562 | 3.246 |  3.081 | 0.761 | 0.439 |
| points | default  | Masculino |  17 |  2.893 |   0.145 |    2.606 |     3.181 | 2.893 |  2.828 | 0.205 | 0.105 |
| points | stFemale | Feminino  |  12 |  3.216 |   0.173 |    2.874 |     3.558 | 3.216 |  3.081 | 0.666 | 0.423 |
| points | stFemale | Masculino |  25 |  2.921 |   0.120 |    2.684 |     3.158 | 2.921 |  2.828 | 0.486 | 0.201 |
| points | stMale   | Feminino  |  20 |  3.098 |   0.134 |    2.833 |     3.363 | 3.098 |  3.000 | 0.726 | 0.340 |
| points | stMale   | Masculino |  34 |  2.510 |   0.103 |    2.307 |     2.713 | 2.510 |  2.449 | 0.623 | 0.217 |

### Anova plots for the dependent variable “points”

``` r
plots <- twoWayAnovaPlots(sdat[["points"]], "points", between, aov[["points"]], pwc[["points"]], c("jitter"), font.label.size=14, step.increase=0.25)
```

#### Plot of “points” based on “stType” (color: gender)

``` r
plots[["stType"]]
```

![](factorialAnova_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

#### Plot of “points” based on “gender” (color: stType)

``` r
plots[["gender"]]
```

![](factorialAnova_files/figure-gfm/unnamed-chunk-27-1.png)<!-- -->

### Textual Report

ANOVA tests with independent between-subjects variables “stType”
(default, stFemale, stMale) and “gender” (Feminino, Masculino) were
performed to determine statistically significant difference on the
dependent varibles “points”. For the dependent variable “points”, there
was statistically significant effects in the factor “stType” with
F(2,116)=3.786, p=0.026 and ges=0.061 (effect size) and in the factor
“gender” with F(1,116)=15.361, p&lt;0.001 and ges=0.117 (effect size).

Pairwise comparisons using the Estimated Marginal Means (EMMs) were
computed to find statistically significant diferences among the groups
defined by the independent variables, and with the p-values ajusted by
the method “bonferroni”. For the dependent variable “points”, the mean
in the stType=“stFemale” (adj M=2.921 and SD=0.486) was significantly
different than the mean in the stType=“stMale” (adj M=2.51 and SD=0.623)
with p-adj=0.031; the mean in the gender=“Feminino” (adj M=3.098 and
SD=0.726) was significantly different than the mean in the
gender=“Masculino” (adj M=2.51 and SD=0.623) with p-adj&lt;0.001.

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
