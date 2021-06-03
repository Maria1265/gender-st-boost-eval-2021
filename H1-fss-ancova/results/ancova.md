ANCOVA test for `fss`
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
        “fss”](#ancova-plots-for-the-dependent-variable-fss)
    -   [Textual Report](#textual-report)
-   [Tips and References](#tips-and-references)

## Initial Variables and Data

-   R-script file: [../code/ancova.R](../code/ancova.R)
-   Initial table file:
    [../data/initial-table.csv](../data/initial-table.csv)
-   Data for fss: [../data/table-for-fss.csv](../data/table-for-fss.csv)
-   Other data: [../data/](../data/) 

### Descriptive statistics of initial data

| condicao | variable |   n |  mean | median |   min |   max |    sd |    se |    ci |   iqr | symmetry | skewness | kurtosis |
|:---------|:---------|----:|------:|-------:|------:|------:|------:|------:|------:|------:|:---------|---------:|---------:|
| inBoost  | fss      |  55 | 3.885 |  3.778 | 2.889 | 5.000 | 0.580 | 0.078 | 0.157 | 0.944 | YES      |    0.421 |   -0.859 |
| inThreat | fss      |  49 | 3.685 |  3.667 | 2.778 | 4.889 | 0.545 | 0.078 | 0.157 | 0.667 | YES      |    0.191 |   -0.834 |
| neutro   | fss      |  38 | 3.827 |  3.944 | 1.778 | 5.000 | 0.620 | 0.101 | 0.204 | 0.444 | NO       |   -0.876 |    1.794 |
| NA       | fss      | 142 | 3.800 |  3.778 | 1.778 | 5.000 | 0.582 | 0.049 | 0.097 | 0.667 | YES      |   -0.040 |    0.170 |
| inBoost  | dfs      |  55 | 3.671 |  3.667 | 1.000 | 4.556 | 0.652 | 0.088 | 0.176 | 0.889 | NO       |   -1.165 |    3.187 |
| inThreat | dfs      |  49 | 3.703 |  3.667 | 2.556 | 5.000 | 0.512 | 0.073 | 0.147 | 0.667 | YES      |   -0.051 |   -0.251 |
| neutro   | dfs      |  38 | 3.640 |  3.556 | 2.222 | 5.000 | 0.603 | 0.098 | 0.198 | 0.889 | YES      |    0.096 |   -0.200 |
| NA       | dfs      | 142 | 3.674 |  3.667 | 1.000 | 5.000 | 0.590 | 0.049 | 0.098 | 0.778 | NO       |   -0.608 |    1.943 |

![](ancova_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

## Checking of Assumptions

### Assumption: Symmetry and treatment of outliers

#### Applying transformation for skewness data when normality is not achieved in any dependent variables or covariance

#### Dealing with outliers (performing treatment of outliers)

``` r
rdat[["fss"]] <- winzorize(rdat[["fss"]],"fss", c("condicao"),"dfs")
```

### Assumption: Normality distribution of data

#### Removing data that affect normality (extreme values)

``` r
non.normal <- list(
"fss" = c("p13","p121","p46")
)
sdat <- remove_from_datatable(rdat, non.normal, wid)
```

    ## [1] "fss"

#### Result of normality test in the residual model

|     | var |   n | skewness | kurtosis | symmetry | statistic | method     |     p | p.signif | normality |
|:----|:----|----:|---------:|---------:|:---------|----------:|:-----------|------:|:---------|:----------|
| fss | fss | 139 |    0.515 |    0.369 | NO       |     7.636 | D’Agostino | 0.022 | ns       | QQ        |

#### Result of normality test in each group

This is an optional validation and only performed for groups with number
greater than 30 observations

| condicao | variable |   n |  mean | median |   min |   max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:---------|----:|------:|-------:|------:|------:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| inBoost  | fss      |  53 | 3.878 |  3.778 | 3.000 | 4.883 | 0.537 | 0.074 | 0.148 | 0.889 | YES       | D’Agostino   |     5.919 | 0.052 | ns       |
| inThreat | fss      |  48 | 3.699 |  3.667 | 2.889 | 4.622 | 0.516 | 0.074 | 0.150 | 0.667 | YES       | Shapiro-Wilk |     0.954 | 0.059 | ns       |
| neutro   | fss      |  38 | 3.855 |  3.944 | 2.889 | 4.794 | 0.501 | 0.081 | 0.165 | 0.444 | YES       | Shapiro-Wilk |     0.946 | 0.064 | ns       |
| NA       | fss      | 139 | 3.810 |  3.778 | 2.889 | 4.883 | 0.523 | 0.044 | 0.088 | 0.667 | QQ        | D’Agostino   |     5.605 | 0.061 | ns       |

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

-   Linearity test in “fss”

``` r
ggscatter(sdat[["fss"]], x=covar, y="fss", facet.by=between, short.panel.labs = F) + 
stat_smooth(method = "loess", span = 0.9)
```

    ## `geom_smooth()` using formula 'y ~ x'

![](ancova_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

### Assumption: Homogeneity of data distribution

|       | var | method         | formula              |   n | DFn.df1 | DFd.df2 | statistic |     p | p.signif |
|:------|:----|:---------------|:---------------------|----:|--------:|--------:|----------:|------:|:---------|
| fss.1 | fss | Levene’s test  | `.res` \~ `condicao` | 139 |       2 |     136 |     1.094 | 0.338 | ns       |
| fss.2 | fss | Anova’s slopes | `.res` \~ `condicao` | 139 |       2 |     133 |     2.533 | 0.083 | ns       |

## Saving the Data with Normal Distribution Used for Performing ANCOVA Test

Descriptive statistics of data with normal distribution

| condicao | variable |   n |  mean | median |   min |   max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:---------|----:|------:|-------:|------:|------:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| inBoost  | fss      |  53 | 3.878 |  3.778 | 3.000 | 4.883 | 0.537 | 0.074 | 0.148 | 0.889 | YES       | D’Agostino   |     5.919 | 0.052 | ns       |
| inThreat | fss      |  48 | 3.699 |  3.667 | 2.889 | 4.622 | 0.516 | 0.074 | 0.150 | 0.667 | YES       | Shapiro-Wilk |     0.954 | 0.059 | ns       |
| neutro   | fss      |  38 | 3.855 |  3.944 | 2.889 | 4.794 | 0.501 | 0.081 | 0.165 | 0.444 | YES       | Shapiro-Wilk |     0.946 | 0.064 | ns       |
| NA       | fss      | 139 | 3.810 |  3.778 | 2.889 | 4.883 | 0.523 | 0.044 | 0.088 | 0.667 | QQ        | D’Agostino   |     5.605 | 0.061 | ns       |

![](ancova_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

## Computation of ANCOVA Test and Pairwise Comparison

### ANCOVA test

| var | Effect   | DFn | DFd |   SSn |    SSd |      F |     p |   ges | p.signif |
|:----|:---------|----:|----:|------:|-------:|-------:|------:|------:|:---------|
| fss | dfs      |   1 | 135 | 9.826 | 26.962 | 49.199 | 0.000 | 0.267 | \*\*\*\* |
| fss | condicao |   2 | 135 | 1.032 | 26.962 |  2.583 | 0.079 | 0.037 | ns       |

### Pairwise comparison

| var | condicao | group1   | group2   | estimate |    se |  df | statistic |     p | p.adj | p.adj.signif |
|:----|:---------|:---------|:---------|---------:|------:|----:|----------:|------:|------:|:-------------|
| fss | NA       | inBoost  | inThreat |    0.176 | 0.089 | 135 |     1.979 | 0.050 | 0.150 | ns           |
| fss | NA       | inBoost  | neutro   |   -0.012 | 0.095 | 135 |    -0.121 | 0.904 | 1.000 | ns           |
| fss | NA       | inThreat | neutro   |   -0.188 | 0.097 | 135 |    -1.932 | 0.055 | 0.166 | ns           |

### Estimated Marginal Means and ANCOVA Plots

| var | condicao |   dfs |   n | emmean | se.emms | conf.low | conf.high |  mean | median |    sd |    ci |
|:----|:---------|------:|----:|-------:|--------:|---------:|----------:|------:|-------:|------:|------:|
| fss | inBoost  | 3.699 |  53 |  3.867 |   0.061 |    3.746 |     3.989 | 3.878 |  3.778 | 0.537 | 0.148 |
| fss | inThreat | 3.699 |  48 |  3.691 |   0.065 |    3.564 |     3.819 | 3.699 |  3.667 | 0.516 | 0.150 |
| fss | neutro   | 3.699 |  38 |  3.879 |   0.073 |    3.735 |     4.022 | 3.855 |  3.944 | 0.501 | 0.165 |

### Ancova plots for the dependent variable “fss”

``` r
plots <- oneWayAncovaPlots(sdat[["fss"]], "fss", between
, aov[["fss"]], pwc[["fss"]], font.label.size=14, step.increase=0.25)
```

#### Plot for: `fss` \~ `condicao`

``` r
plots[["condicao"]]
```

![](ancova_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

### Textual Report

After controlling the linearity of covariance “dfs”, ANCOVA tests with
independent between-subjects variables “condicao” (inBoost, inThreat,
neutro) were performed to determine statistically significant difference
on the dependent varibles “fss”. For the dependent variable “fss”, there
was statistically significant effects in the factor “dfs” with
F(1,135)=49.199, p&lt;0.001 and ges=0.267 (effect size).

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
