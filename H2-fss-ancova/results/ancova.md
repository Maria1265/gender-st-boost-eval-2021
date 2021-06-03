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
-   Data for fss [../data/table-for-fss.csv](../data/table-for-fss.csv)

### Descriptive statistics of initial data

| stType   | gender    | variable |   n |  mean | median |   min |   max |    sd |    se |    ci |   iqr | symmetry | skewness | kurtosis |
|:---------|:----------|:---------|----:|------:|-------:|------:|------:|------:|------:|------:|------:|:---------|---------:|---------:|
| default  | Feminino  | fss      |  15 | 3.800 |  3.889 | 1.778 | 5.000 | 0.725 | 0.187 | 0.402 | 0.278 | NO       |   -1.184 |    1.785 |
| default  | Masculino | fss      |  23 | 3.845 |  4.000 | 2.556 | 5.000 | 0.558 | 0.116 | 0.241 | 0.611 | YES      |   -0.234 |   -0.136 |
| stFemale | Feminino  | fss      |  12 | 3.963 |  3.889 | 3.333 | 5.000 | 0.624 | 0.180 | 0.396 | 0.972 | NO       |    0.526 |   -1.334 |
| stFemale | Masculino | fss      |  29 | 3.828 |  3.778 | 2.778 | 4.889 | 0.516 | 0.096 | 0.196 | 0.889 | YES      |    0.138 |   -0.836 |
| stMale   | Feminino  | fss      |  20 | 3.478 |  3.389 | 2.778 | 4.667 | 0.532 | 0.119 | 0.249 | 0.917 | YES      |    0.405 |   -0.939 |
| stMale   | Masculino | fss      |  43 | 3.863 |  3.667 | 2.889 | 5.000 | 0.574 | 0.087 | 0.177 | 0.944 | YES      |    0.356 |   -0.869 |
| NA       | NA        | fss      | 142 | 3.800 |  3.778 | 1.778 | 5.000 | 0.582 | 0.049 | 0.097 | 0.667 | YES      |   -0.040 |    0.170 |
| default  | Feminino  | dfs      |  15 | 3.600 |  3.556 | 2.889 | 4.667 | 0.509 | 0.131 | 0.282 | 0.500 | YES      |    0.471 |   -0.760 |
| default  | Masculino | dfs      |  23 | 3.667 |  3.667 | 2.222 | 5.000 | 0.667 | 0.139 | 0.288 | 1.000 | YES      |   -0.068 |   -0.378 |
| stFemale | Feminino  | dfs      |  12 | 3.361 |  3.333 | 1.000 | 4.556 | 0.998 | 0.288 | 0.634 | 1.333 | NO       |   -0.801 |    0.063 |
| stFemale | Masculino | dfs      |  29 | 3.785 |  3.778 | 2.778 | 4.556 | 0.429 | 0.080 | 0.163 | 0.444 | YES      |   -0.330 |   -0.082 |
| stMale   | Feminino  | dfs      |  20 | 3.583 |  3.611 | 2.556 | 5.000 | 0.604 | 0.135 | 0.283 | 0.861 | YES      |    0.374 |   -0.521 |
| stMale   | Masculino | dfs      |  43 | 3.757 |  3.667 | 2.778 | 4.556 | 0.500 | 0.076 | 0.154 | 0.500 | YES      |   -0.069 |   -0.675 |
| NA       | NA        | dfs      | 142 | 3.674 |  3.667 | 1.000 | 5.000 | 0.590 | 0.049 | 0.098 | 0.778 | NO       |   -0.608 |    1.943 |

![](ancova_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

## Checking of Assumptions

### Assumption: Symmetry and treatment of outliers

#### Applying transformation for skewness data when normality is not achieved in any dependent variables or covariance

#### Dealing with outliers (performing treatment of outliers)

``` r
rdat[["fss"]] <- winzorize(rdat[["fss"]],"fss", c("stType","gender"),"dfs")
```

### Assumption: Normality distribution of data

#### Removing data that affect normality (extreme values)

``` r
non.normal <- list(
"fss" = c("p05","p06","p07","p62","p64","p114","p34","p103","p46","p02","p03","p04","p09","p10","p38","p01","p32","p100","p79","p13","p74","p85")
)
sdat <- remove_from_datatable(rdat, non.normal, wid)
```

    ## [1] "fss"

#### Result of normality test in the residual model

|     | var |   n | skewness | kurtosis | symmetry | statistic | method     |     p | p.signif | normality |
|:----|:----|----:|---------:|---------:|:---------|----------:|:-----------|------:|:---------|:----------|
| fss | fss | 120 |    0.213 |   -0.457 | YES      |     1.845 | D’Agostino | 0.397 | ns       | QQ        |

#### Result of normality test in each group

This is an optional validation and only performed for groups with number
greater than 30 observations

| stType   | gender    | variable |   n |  mean | median |   min |   max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:----------|:---------|----:|------:|-------:|------:|------:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| default  | Feminino  | fss      |  15 | 3.851 |  3.889 | 2.889 | 4.654 | 0.489 | 0.126 | 0.271 | 0.278 | YES       | Shapiro-Wilk |     0.906 | 0.119 | ns       |
| default  | Masculino | fss      |  23 | 3.851 |  4.000 | 3.011 | 4.722 | 0.486 | 0.101 | 0.210 | 0.611 | YES       | Shapiro-Wilk |     0.932 | 0.123 | ns       |
| stFemale | Feminino  | fss      |  11 | 3.858 |  3.889 | 3.333 | 4.883 | 0.534 | 0.161 | 0.359 | 0.722 | YES       | Shapiro-Wilk |     0.881 | 0.108 | ns       |
| stFemale | Masculino | fss      |  21 | 3.966 |  4.000 | 3.444 | 4.622 | 0.396 | 0.086 | 0.180 | 0.667 | YES       | Shapiro-Wilk |     0.915 | 0.068 | ns       |
| stMale   | Feminino  | fss      |  19 | 3.492 |  3.556 | 2.889 | 4.244 | 0.475 | 0.109 | 0.229 | 0.778 | YES       | Shapiro-Wilk |     0.906 | 0.062 | ns       |
| stMale   | Masculino | fss      |  31 | 4.024 |  4.111 | 3.000 | 4.873 | 0.492 | 0.088 | 0.181 | 0.889 | YES       | Shapiro-Wilk |     0.934 | 0.058 | ns       |
| NA       | NA        | fss      | 120 | 3.860 |  3.889 | 2.889 | 4.883 | 0.498 | 0.045 | 0.090 | 0.667 | QQ        | D’Agostino   |     2.325 | 0.313 | ns       |

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

|       | var | method         | formula                      |   n | DFn.df1 | DFd.df2 | statistic |     p | p.signif |
|:------|:----|:---------------|:-----------------------------|----:|--------:|--------:|----------:|------:|:---------|
| fss.1 | fss | Levene’s test  | `.res` \~ `stType`\*`gender` | 120 |       5 |     114 |     0.779 | 0.567 | ns       |
| fss.2 | fss | Anova’s slopes | `.res` \~ `stType`\*`gender` | 120 |       5 |     108 |     0.345 | 0.885 | ns       |

## Saving the Data with Normal Distribution Used for Performing ANCOVA Test

Descriptive statistics of data with normal distribution

| stType   | gender    | variable |   n |  mean | median |   min |   max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:----------|:---------|----:|------:|-------:|------:|------:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| default  | Feminino  | fss      |  15 | 3.851 |  3.889 | 2.889 | 4.654 | 0.489 | 0.126 | 0.271 | 0.278 | YES       | Shapiro-Wilk |     0.906 | 0.119 | ns       |
| default  | Masculino | fss      |  23 | 3.851 |  4.000 | 3.011 | 4.722 | 0.486 | 0.101 | 0.210 | 0.611 | YES       | Shapiro-Wilk |     0.932 | 0.123 | ns       |
| stFemale | Feminino  | fss      |  11 | 3.858 |  3.889 | 3.333 | 4.883 | 0.534 | 0.161 | 0.359 | 0.722 | YES       | Shapiro-Wilk |     0.881 | 0.108 | ns       |
| stFemale | Masculino | fss      |  21 | 3.966 |  4.000 | 3.444 | 4.622 | 0.396 | 0.086 | 0.180 | 0.667 | YES       | Shapiro-Wilk |     0.915 | 0.068 | ns       |
| stMale   | Feminino  | fss      |  19 | 3.492 |  3.556 | 2.889 | 4.244 | 0.475 | 0.109 | 0.229 | 0.778 | YES       | Shapiro-Wilk |     0.906 | 0.062 | ns       |
| stMale   | Masculino | fss      |  31 | 4.024 |  4.111 | 3.000 | 4.873 | 0.492 | 0.088 | 0.181 | 0.889 | YES       | Shapiro-Wilk |     0.934 | 0.058 | ns       |
| NA       | NA        | fss      | 120 | 3.860 |  3.889 | 2.889 | 4.883 | 0.498 | 0.045 | 0.090 | 0.667 | QQ        | D’Agostino   |     2.325 | 0.313 | ns       |

![](ancova_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

## Computation of ANCOVA Test and Pairwise Comparison

### ANCOVA test

| var | Effect        | DFn | DFd |   SSn |    SSd |      F |     p |   ges | p.signif |
|:----|:--------------|----:|----:|------:|-------:|-------:|------:|------:|:---------|
| fss | dfs           |   1 | 113 | 8.325 | 17.554 | 53.591 | 0.000 | 0.322 | \*\*\*\* |
| fss | stType        |   2 | 113 | 0.192 | 17.554 |  0.618 | 0.541 | 0.011 | ns       |
| fss | gender        |   1 | 113 | 0.495 | 17.554 |  3.186 | 0.077 | 0.027 | ns       |
| fss | stType:gender |   2 | 113 | 1.463 | 17.554 |  4.710 | 0.011 | 0.077 | \*       |

### Pairwise comparison

| var | stType   | gender    | group1   | group2    | estimate |    se |  df | statistic |     p | p.adj | p.adj.signif |
|:----|:---------|:----------|:---------|:----------|---------:|------:|----:|----------:|------:|------:|:-------------|
| fss | NA       | Feminino  | default  | stFemale  |   -0.015 | 0.156 | 113 |    -0.093 | 0.926 | 1.000 | ns           |
| fss | NA       | Feminino  | default  | stMale    |    0.362 | 0.136 | 113 |     2.661 | 0.009 | 0.027 | \*           |
| fss | NA       | Feminino  | stFemale | stMale    |    0.377 | 0.149 | 113 |     2.523 | 0.013 | 0.039 | \*           |
| fss | NA       | Masculino | default  | stFemale  |    0.019 | 0.120 | 113 |     0.155 | 0.877 | 1.000 | ns           |
| fss | NA       | Masculino | default  | stMale    |   -0.085 | 0.109 | 113 |    -0.779 | 0.438 | 1.000 | ns           |
| fss | NA       | Masculino | stFemale | stMale    |   -0.104 | 0.112 | 113 |    -0.929 | 0.355 | 1.000 | ns           |
| fss | default  | NA        | Feminino | Masculino |    0.043 | 0.131 | 113 |     0.326 | 0.745 | 0.745 | ns           |
| fss | stFemale | NA        | Feminino | Masculino |    0.076 | 0.149 | 113 |     0.511 | 0.610 | 0.610 | ns           |
| fss | stMale   | NA        | Feminino | Masculino |   -0.404 | 0.116 | 113 |    -3.482 | 0.001 | 0.001 | \*\*\*       |

### Estimated Marginal Means and ANCOVA Plots

| var | stType   | gender    |   dfs |   n | emmean | se.emms | conf.low | conf.high |  mean | median |    sd |    ci |
|:----|:---------|:----------|------:|----:|-------:|--------:|---------:|----------:|------:|-------:|------:|------:|
| fss | default  | Feminino  | 3.721 |  15 |  3.924 |   0.102 |    3.721 |     4.126 | 3.851 |  3.889 | 0.489 | 0.271 |
| fss | default  | Masculino | 3.721 |  23 |  3.881 |   0.082 |    3.718 |     4.044 | 3.851 |  4.000 | 0.486 | 0.210 |
| fss | stFemale | Feminino  | 3.721 |  11 |  3.938 |   0.119 |    3.702 |     4.175 | 3.858 |  3.889 | 0.534 | 0.359 |
| fss | stFemale | Masculino | 3.721 |  21 |  3.862 |   0.087 |    3.690 |     4.035 | 3.966 |  4.000 | 0.396 | 0.180 |
| fss | stMale   | Feminino  | 3.721 |  19 |  3.562 |   0.091 |    3.381 |     3.742 | 3.492 |  3.556 | 0.475 | 0.229 |
| fss | stMale   | Masculino | 3.721 |  31 |  3.966 |   0.071 |    3.825 |     4.107 | 4.024 |  4.111 | 0.492 | 0.181 |

### Ancova plots for the dependent variable “fss”

``` r
plots <- twoWayAncovaPlots(sdat[["fss"]], "fss", between
, aov[["fss"]], pwc[["fss"]], font.label.size=14, step.increase=0.25)
```

#### Plot for: `fss` \~ `stType`

``` r
plots[["stType"]]
```

![](ancova_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

#### Plot for: `fss` \~ `gender`

``` r
plots[["gender"]]
```

![](ancova_files/figure-gfm/unnamed-chunk-27-1.png)<!-- -->

### Textual Report

After controlling the linearity of covariance “dfs”, ANCOVA tests with
independent between-subjects variables “stType” (default, stFemale,
stMale) and “gender” (Feminino, Masculino) were performed to determine
statistically significant difference on the dependent varibles “fss”.
For the dependent variable “fss”, there was statistically significant
effects in the factor “dfs” with F(1,113)=53.591, p&lt;0.001 and
ges=0.322 (effect size) and in the interaction of factors
“stType:gender” with F(2,113)=4.71, p=0.011 and ges=0.077 (effect size).

Pairwise comparisons using the Estimated Marginal Means (EMMs) were
computed to find statistically significant diferences among the groups
defined by the independent variables, and with the p-values ajusted by
the method “bonferroni”. For the dependent variable “fss”, the mean in
the stType=“default” (adj M=3.924 and SD=0.489) was significantly
different than the mean in the stType=“stMale” (adj M=3.562 and
SD=0.475) with p-adj=0.027; the mean in the stType=“stFemale” (adj
M=3.938 and SD=0.534) was significantly different than the mean in the
stType=“stMale” (adj M=3.562 and SD=0.475) with p-adj=0.039; the mean in
the gender=“Feminino” (adj M=3.562 and SD=0.475) was significantly
different than the mean in the gender=“Masculino” (adj M=3.966 and
SD=0.492) with p-adj&lt;0.001.

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
