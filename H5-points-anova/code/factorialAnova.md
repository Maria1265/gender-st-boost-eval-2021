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

| condicao | variable |   n |   mean | median | min | max |    sd |    se |    ci |  iqr | symmetry | skewness | kurtosis |
|:---------|:---------|----:|-------:|-------:|----:|----:|------:|------:|------:|-----:|:---------|---------:|---------:|
| inBoost  | points   |  55 | 12.927 |     14 |   2 |  20 | 5.069 | 0.684 | 1.370 | 5.00 | NO       |   -0.572 |   -0.557 |
| inThreat | points   |  49 | 10.939 |     12 |   1 |  19 | 4.616 | 0.659 | 1.326 | 5.00 | NO       |   -0.691 |   -0.609 |
| neutro   | points   |  38 | 11.395 |     12 |   1 |  18 | 4.378 | 0.710 | 1.439 | 3.00 | NO       |   -0.944 |    0.015 |
| NA       | points   | 142 | 11.831 |     13 |   1 |  20 | 4.788 | 0.402 | 0.794 | 4.75 | NO       |   -0.610 |   -0.333 |

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
rdat[["points"]] <- winzorize(rdat[["points"]],"points", c("condicao"))
```

### Assumption: Normality distribution of data

#### Removing data that affect normality (extreme values)

``` r
non.normal <- list(

)
sdat <- remove_from_datatable(rdat, non.normal, wid)
```

#### Result of normality test in the residual model

|        | var    |   n | skewness | kurtosis | symmetry | statistic | method     |     p | p.signif | normality |
|:-------|:-------|----:|---------:|---------:|:---------|----------:|:-----------|------:|:---------|:----------|
| points | points | 142 |    0.321 |   -0.585 | YES      |     5.227 | D’Agostino | 0.073 | ns       | QQ        |

#### Result of normality test in each group

This is an optional validation and only performed for groups with number
greater than 30 observations

| condicao | variable |   n |  mean | median |   min |   max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:---------|----:|------:|-------:|------:|------:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| inBoost  | points   |  55 | 2.728 |  2.646 | 1.414 | 4.123 | 0.847 | 0.114 | 0.229 | 0.926 | YES       | D’Agostino   |     2.418 | 0.298 | ns       |
| inThreat | points   |  49 | 3.100 |  3.000 | 2.094 | 4.243 | 0.667 | 0.095 | 0.191 | 0.818 | NO        | Shapiro-Wilk |     0.914 | 0.002 | \*\*     |
| neutro   | points   |  38 | 3.039 |  3.000 | 2.160 | 4.243 | 0.622 | 0.101 | 0.204 | 0.517 | NO        | Shapiro-Wilk |     0.887 | 0.001 | \*\*     |
| NA       | points   | 142 | 2.940 |  2.828 | 1.414 | 4.243 | 0.746 | 0.063 | 0.124 | 0.829 | QQ        | D’Agostino   |     1.304 | 0.521 | ns       |

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

|        | var    | method        | formula                |   n | df1 | df2 | statistic |     p | p.signif |
|:-------|:-------|:--------------|:-----------------------|----:|----:|----:|----------:|------:|:---------|
| points | points | Levene’s test | `points` \~ `condicao` | 142 |   2 | 139 |     2.976 | 0.054 | ns       |

## Saving the Data with Normal Distribution Used for Performing ANCOVA Test

``` r
ndat <- sdat[[1]]
for (dv in names(sdat)[-1]) ndat <- merge(ndat, sdat[[dv]])
write.csv(ndat, paste0("../data/table-with-normal-distribution.csv"))
```

Descriptive statistics of data with normal distribution

| condicao | variable |   n |  mean | median |   min |   max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:---------|----:|------:|-------:|------:|------:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| inBoost  | points   |  55 | 2.728 |  2.646 | 1.414 | 4.123 | 0.847 | 0.114 | 0.229 | 0.926 | YES       | D’Agostino   |     2.418 | 0.298 | ns       |
| inThreat | points   |  49 | 3.100 |  3.000 | 2.094 | 4.243 | 0.667 | 0.095 | 0.191 | 0.818 | NO        | Shapiro-Wilk |     0.914 | 0.002 | \*\*     |
| neutro   | points   |  38 | 3.039 |  3.000 | 2.160 | 4.243 | 0.622 | 0.101 | 0.204 | 0.517 | NO        | Shapiro-Wilk |     0.887 | 0.001 | \*\*     |
| NA       | points   | 142 | 2.940 |  2.828 | 1.414 | 4.243 | 0.746 | 0.063 | 0.124 | 0.829 | QQ        | D’Agostino   |     1.304 | 0.521 | ns       |

![](factorialAnova_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

## Computation of ANOVA Test and Pairwise Comparison

### ANOVA test

| var    | Effect   | DFn | DFd |   SSn |    SSd |     F |     p |   ges | p.signif |
|:-------|:---------|----:|----:|------:|-------:|------:|------:|------:|:---------|
| points | condicao |   2 | 139 | 4.103 | 74.384 | 3.833 | 0.024 | 0.052 | \*       |

### Pairwise comparison

| var    | var.1  | term     | null.value |    se | .y.    | group1   | group2   | estimate |  df | statistic | conf.low | conf.high |     p | p.adj | p.adj.signif |
|:-------|:-------|:---------|-----------:|------:|:-------|:---------|:---------|---------:|----:|----------:|---------:|----------:|------:|------:|:-------------|
| points | points | condicao |          0 | 0.144 | points | inBoost  | inThreat |   -0.372 | 139 |    -2.589 |   -0.656 |    -0.088 | 0.011 | 0.032 | \*           |
| points | points | condicao |          0 | 0.154 | points | inBoost  | neutro   |   -0.312 | 139 |    -2.019 |   -0.617 |    -0.006 | 0.045 | 0.136 | ns           |
| points | points | condicao |          0 | 0.158 | points | inThreat | neutro   |    0.061 | 139 |     0.383 |   -0.252 |     0.373 | 0.703 | 1.000 | ns           |

### Estimated Marginal Means and ANOVA Plots

| var    | condicao |   n | emmean | se.emms | conf.low | conf.high |  mean | median |    sd |    ci |
|:-------|:---------|----:|-------:|--------:|---------:|----------:|------:|-------:|------:|------:|
| points | inBoost  |  55 |  2.728 |   0.099 |    2.533 |     2.923 | 2.728 |  2.646 | 0.847 | 0.229 |
| points | inThreat |  49 |  3.100 |   0.105 |    2.893 |     3.306 | 3.100 |  3.000 | 0.667 | 0.191 |
| points | neutro   |  38 |  3.039 |   0.119 |    2.805 |     3.274 | 3.039 |  3.000 | 0.622 | 0.204 |

### Anova plots for the dependent variable “points”

``` r
plots <- oneWayAnovaPlots(sdat[["points"]], "points", between, aov[["points"]], pwc[["points"]], c("jitter"), font.label.size=14, step.increase=0.25)
```

#### Plot of “points” based on “condicao”

``` r
plots[["condicao"]]
```

![](factorialAnova_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

### Textual Report

ANOVA tests with independent between-subjects variables “condicao”
(inBoost, inThreat, neutro) were performed to determine statistically
significant difference on the dependent varibles “points”. For the
dependent variable “points”, there was statistically significant effects
in the factor “condicao” with F(2,139)=3.833, p=0.024 and ges=0.052
(effect size).

Pairwise comparisons using the Estimated Marginal Means (EMMs) were
computed to find statistically significant diferences among the groups
defined by the independent variables, and with the p-values ajusted by
the method “bonferroni”. For the dependent variable “points”, the mean
in the condicao=“inBoost” (adj M=2.728 and SD=0.847) was significantly
different than the mean in the condicao=“inThreat” (adj M=3.1 and
SD=0.667) with p-adj=0.032.

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
