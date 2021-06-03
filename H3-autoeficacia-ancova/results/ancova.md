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

| condicao | variable         |   n |  mean | median |   min | max |    sd |    se |    ci |   iqr | symmetry | skewness | kurtosis |
|:---------|:-----------------|----:|------:|-------:|------:|----:|------:|------:|------:|------:|:---------|---------:|---------:|
| inBoost  | autoeficacia.pos |  55 | 6.758 |  6.833 | 3.667 |   8 | 0.938 | 0.126 | 0.254 | 1.167 | NO       |   -1.012 |    1.251 |
| inThreat | autoeficacia.pos |  49 | 6.065 |  6.333 | 2.500 |   8 | 1.370 | 0.196 | 0.394 | 1.333 | NO       |   -0.804 |    0.242 |
| neutro   | autoeficacia.pos |  38 | 6.118 |  6.417 | 1.000 |   8 | 1.571 | 0.255 | 0.516 | 1.958 | NO       |   -0.991 |    1.028 |
| NA       | autoeficacia.pos | 142 | 6.347 |  6.500 | 1.000 |   8 | 1.316 | 0.110 | 0.218 | 1.333 | NO       |   -1.149 |    1.625 |
| inBoost  | autoeficacia.pre |  55 | 6.758 |  7.000 | 3.167 |   8 | 0.969 | 0.131 | 0.262 | 0.917 | NO       |   -1.401 |    2.481 |
| inThreat | autoeficacia.pre |  49 | 6.044 |  6.500 | 1.000 |   8 | 1.662 | 0.237 | 0.477 | 2.333 | NO       |   -1.126 |    0.962 |
| neutro   | autoeficacia.pre |  38 | 6.724 |  7.333 | 2.167 |   8 | 1.463 | 0.237 | 0.481 | 1.917 | NO       |   -1.422 |    1.692 |
| NA       | autoeficacia.pre | 142 | 6.502 |  7.000 | 1.000 |   8 | 1.404 | 0.118 | 0.233 | 1.667 | NO       |   -1.491 |    2.461 |

![](ancova_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

## Checking of Assumptions

### Assumption: Symmetry and treatment of outliers

#### Applying transformation for skewness data when normality is not achieved in any dependent variables or covariance

Applying transformation in “autoeficacia.pos” to reduce skewness

``` r
density_res_plot(rdat[["autoeficacia.pos"]],"autoeficacia.pos",between,c(),covar)
```

![](ancova_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

``` r
rdat[["autoeficacia.pos"]][["autoeficacia.pos"]] <- sqrt(max(dat[["autoeficacia.pos"]][["autoeficacia.pos"]]+1) - dat[["autoeficacia.pos"]][["autoeficacia.pos"]])
rdat[["autoeficacia.pos"]][["autoeficacia.pre"]] <- sqrt(max(dat[["autoeficacia.pos"]][["autoeficacia.pre"]]+1) - dat[["autoeficacia.pos"]][["autoeficacia.pre"]])
density_res_plot(rdat[["autoeficacia.pos"]],"autoeficacia.pos",between,c(),covar)
```

![](ancova_files/figure-gfm/unnamed-chunk-6-2.png)<!-- -->

#### Dealing with outliers (performing treatment of outliers)

``` r
rdat[["autoeficacia.pos"]] <- winzorize(rdat[["autoeficacia.pos"]],"autoeficacia.pos", c("condicao"),"autoeficacia.pre")
```

### Assumption: Normality distribution of data

#### Removing data that affect normality (extreme values)

``` r
non.normal <- list(
"autoeficacia.pos" = c("p18")
)
sdat <- remove_from_datatable(rdat, non.normal, wid)
```

    ## [1] "autoeficacia.pos"

#### Result of normality test in the residual model

|                  | var              |   n | skewness | kurtosis | symmetry | statistic | method     |     p | p.signif | normality |
|:-----------------|:-----------------|----:|---------:|---------:|:---------|----------:|:-----------|------:|:---------|:----------|
| autoeficacia.pos | autoeficacia.pos | 141 |    0.264 |   -0.048 | YES      |      1.85 | D’Agostino | 0.397 | ns       | QQ        |

#### Result of normality test in each group

This is an optional validation and only performed for groups with number
greater than 30 observations

| condicao | variable         |   n |  mean | median | min |   max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:-----------------|----:|------:|-------:|----:|------:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| inBoost  | autoeficacia.pos |  55 | 1.455 |  1.472 |   1 | 1.953 | 0.275 | 0.037 | 0.074 | 0.408 | YES       | D’Agostino   |     2.614 | 0.271 | ns       |
| inThreat | autoeficacia.pos |  49 | 1.655 |  1.633 |   1 | 2.306 | 0.368 | 0.053 | 0.106 | 0.399 | YES       | Shapiro-Wilk |     0.963 | 0.130 | ns       |
| neutro   | autoeficacia.pos |  37 | 1.638 |  1.683 |   1 | 2.306 | 0.407 | 0.067 | 0.136 | 0.604 | YES       | Shapiro-Wilk |     0.947 | 0.079 | ns       |
| NA       | autoeficacia.pos | 141 | 1.573 |  1.581 |   1 | 2.306 | 0.357 | 0.030 | 0.059 | 0.426 | QQ        | D’Agostino   |     4.333 | 0.115 | ns       |

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

![](ancova_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

### Assumption: Homogeneity of data distribution

|                    | var              | method         | formula              |   n | DFn.df1 | DFd.df2 | statistic |     p | p.signif |
|:-------------------|:-----------------|:---------------|:---------------------|----:|--------:|--------:|----------:|------:|:---------|
| autoeficacia.pos.1 | autoeficacia.pos | Levene’s test  | `.res` \~ `condicao` | 141 |       2 |     138 |     1.443 | 0.240 | ns       |
| autoeficacia.pos.2 | autoeficacia.pos | Anova’s slopes | `.res` \~ `condicao` | 141 |       2 |     135 |     1.183 | 0.309 | ns       |

## Saving the Data with Normal Distribution Used for Performing ANCOVA Test

Descriptive statistics of data with normal distribution

| condicao | variable         |   n |  mean | median | min |   max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:-----------------|----:|------:|-------:|----:|------:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| inBoost  | autoeficacia.pos |  55 | 1.455 |  1.472 |   1 | 1.953 | 0.275 | 0.037 | 0.074 | 0.408 | YES       | D’Agostino   |     2.614 | 0.271 | ns       |
| inThreat | autoeficacia.pos |  49 | 1.655 |  1.633 |   1 | 2.306 | 0.368 | 0.053 | 0.106 | 0.399 | YES       | Shapiro-Wilk |     0.963 | 0.130 | ns       |
| neutro   | autoeficacia.pos |  37 | 1.638 |  1.683 |   1 | 2.306 | 0.407 | 0.067 | 0.136 | 0.604 | YES       | Shapiro-Wilk |     0.947 | 0.079 | ns       |
| NA       | autoeficacia.pos | 141 | 1.573 |  1.581 |   1 | 2.306 | 0.357 | 0.030 | 0.059 | 0.426 | QQ        | D’Agostino   |     4.333 | 0.115 | ns       |

![](ancova_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

## Computation of ANCOVA Test and Pairwise Comparison

### ANCOVA test

| var              | Effect           | DFn | DFd |   SSn |    SSd |      F |     p |   ges | p.signif |
|:-----------------|:-----------------|----:|----:|------:|-------:|-------:|------:|------:|:---------|
| autoeficacia.pos | autoeficacia.pre |   1 | 137 | 6.090 | 10.454 | 79.814 | 0.000 | 0.368 | \*\*\*\* |
| autoeficacia.pos | condicao         |   2 | 137 | 0.908 | 10.454 |  5.947 | 0.003 | 0.080 | \*\*     |

### Pairwise comparison

| var              | condicao | group1   | group2   | estimate |    se |  df | statistic |     p | p.adj | p.adj.signif |
|:-----------------|:---------|:---------|:---------|---------:|------:|----:|----------:|------:|------:|:-------------|
| autoeficacia.pos | NA       | inBoost  | inThreat |   -0.090 | 0.056 | 137 |    -1.620 | 0.108 | 0.323 | ns           |
| autoeficacia.pos | NA       | inBoost  | neutro   |   -0.202 | 0.059 | 137 |    -3.443 | 0.001 | 0.002 | \*\*         |
| autoeficacia.pos | NA       | inThreat | neutro   |   -0.112 | 0.062 | 137 |    -1.813 | 0.072 | 0.216 | ns           |

### Estimated Marginal Means and ANCOVA Plots

| var              | condicao | autoeficacia.pre |   n | emmean | se.emms | conf.low | conf.high |  mean | median |    sd |    ci |
|:-----------------|:---------|-----------------:|----:|-------:|--------:|---------:|----------:|------:|-------:|------:|------:|
| autoeficacia.pos | inBoost  |             1.51 |  55 |  1.488 |   0.037 |    1.414 |     1.562 | 1.455 |  1.472 | 0.275 | 0.074 |
| autoeficacia.pos | inThreat |             1.51 |  49 |  1.578 |   0.040 |    1.498 |     1.658 | 1.655 |  1.633 | 0.368 | 0.106 |
| autoeficacia.pos | neutro   |             1.51 |  37 |  1.690 |   0.046 |    1.600 |     1.781 | 1.638 |  1.683 | 0.407 | 0.136 |

### Ancova plots for the dependent variable “autoeficacia.pos”

``` r
plots <- oneWayAncovaPlots(sdat[["autoeficacia.pos"]], "autoeficacia.pos", between
, aov[["autoeficacia.pos"]], pwc[["autoeficacia.pos"]], font.label.size=14, step.increase=0.25)
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
F(1,137)=79.814, p&lt;0.001 and ges=0.368 (effect size) and in the
factor “condicao” with F(2,137)=5.947, p=0.003 and ges=0.08 (effect
size).

Pairwise comparisons using the Estimated Marginal Means (EMMs) were
computed to find statistically significant diferences among the groups
defined by the independent variables, and with the p-values ajusted by
the method “bonferroni”. For the dependent variable “autoeficacia.pos”,
the mean in the condicao=“inBoost” (adj M=1.488 and SD=0.275) was
significantly different than the mean in the condicao=“neutro” (adj
M=1.69 and SD=0.407) with p-adj=0.002.

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
