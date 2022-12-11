ANOVA test for `points`\~`stType`\*`gender`
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
  - <a href="#assumption-homogeneity-of-data-distribution"
    id="toc-assumption-homogeneity-of-data-distribution">Assumption:
    Homogeneity of data distribution</a>
- <a
  href="#saving-the-data-with-normal-distribution-used-for-performing-anova-test"
  id="toc-saving-the-data-with-normal-distribution-used-for-performing-anova-test">Saving
  the Data with Normal Distribution Used for Performing ANOVA test</a>
- <a href="#computation-of-anova-test-and-pairwise-comparison"
  id="toc-computation-of-anova-test-and-pairwise-comparison">Computation
  of ANOVA test and Pairwise Comparison</a>
  - <a href="#anova-test" id="toc-anova-test">ANOVA test</a>
  - <a href="#pairwise-comparison" id="toc-pairwise-comparison">Pairwise
    comparison</a>
  - <a href="#descriptive-statistic-of-estimated-marginal-means"
    id="toc-descriptive-statistic-of-estimated-marginal-means">Descriptive
    Statistic of Estimated Marginal Means</a>
  - <a href="#anova-plots-for-the-dependent-variable-points"
    id="toc-anova-plots-for-the-dependent-variable-points">Anova plots for
    the dependent variable “points”</a>
  - <a href="#textual-report" id="toc-textual-report">Textual Report</a>
- <a href="#tips-and-references" id="toc-tips-and-references">Tips and
  References</a>

## Initial Variables and Data

- R-script file: [../code/anova.R](../code/anova.R)
- Initial table file:
  [../data/initial-table.csv](../data/initial-table.csv)
- Data for points
  [../data/table-for-points.csv](../data/table-for-points.csv)
- Table without outliers and normal distribution of data:
  [../data/table-with-normal-distribution.csv](../data/table-with-normal-distribution.csv)
- Other data files: [../data/](../data/)
- Files related to the presented results: [../results/](../results/)

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

![](anova_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

    ## [1] "p124" "p117" "p122" "p13"  "p27"  "p28"  "p29"  "p79"  "p101"

## Checking of Assumptions

### Assumption: Symmetry and treatment of outliers

#### Applying transformation for skewness data when normality is not achieved

Applying transformation in “points” to reduce skewness

``` r
density.plot.by.residual(rdat[["points"]],"points",between)
```

![](anova_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

``` r
rdat[["points"]][["std.points"]] <- -1*sqrt(max(dat[["points"]][["points"]]+1) - dat[["points"]][["points"]])
density.plot.by.residual(rdat[["points"]],"std.points",between)
```

![](anova_files/figure-gfm/unnamed-chunk-6-2.png)<!-- -->

#### Dealing with outliers (performing treatment of outliers)

``` r
rdat[["points"]] <- winzorize(rdat[["points"]],"points", c("stType","gender"), skewness=skewness)
```

### Assumption: Normality distribution of data

#### Removing data that affect normality (extreme values)

``` r
non.normal <- list(

)
sdat <- removeFromDataTable(rdat, non.normal, wid)
```

#### Result of normality test in the residual model

|        | var    |   n | skewness | kurtosis | symmetry | statistic | method     |     p | p.signif | normality |
|:-------|:-------|----:|---------:|---------:|:---------|----------:|:-----------|------:|:---------|:----------|
| points | points | 142 |   -0.091 |   -0.265 | YES      |     0.354 | D’Agostino | 0.838 | ns       | QQ        |

#### Result of normality test in each group

This is an optional validation and only valid for groups with number
greater than 30 observations

| stType   | gender    | variable |   n |   mean | median |    min |    max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:----------|:---------|----:|-------:|-------:|-------:|-------:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| default  | Feminino  | points   |  15 | -3.335 | -3.162 | -4.472 | -2.236 | 0.809 | 0.209 | 0.448 | 1.300 | YES       | Shapiro-Wilk |     0.902 | 0.101 | ns       |
| default  | Masculino | points   |  23 | -2.824 | -2.828 | -4.243 | -1.732 | 0.502 | 0.105 | 0.217 | 0.435 | NO        | Shapiro-Wilk |     0.870 | 0.007 | \*\*     |
| stFemale | Feminino  | points   |  12 | -3.212 | -3.081 | -4.243 | -2.236 | 0.689 | 0.199 | 0.438 | 1.160 | YES       | Shapiro-Wilk |     0.935 | 0.434 | ns       |
| stFemale | Masculino | points   |  29 | -3.079 | -2.828 | -4.359 | -1.414 | 0.709 | 0.132 | 0.270 | 0.818 | YES       | Shapiro-Wilk |     0.930 | 0.054 | ns       |
| stMale   | Feminino  | points   |  20 | -3.110 | -3.000 | -4.472 | -2.000 | 0.747 | 0.167 | 0.349 | 0.970 | YES       | Shapiro-Wilk |     0.949 | 0.354 | ns       |
| stMale   | Masculino | points   |  43 | -2.534 | -2.449 | -4.359 | -1.000 | 0.963 | 0.147 | 0.296 | 0.764 | NO        | Shapiro-Wilk |     0.930 | 0.011 | \*       |

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

### Assumption: Homogeneity of data distribution

|        | var    | method        | formula                      |   n | df1 | df2 | statistic |     p | p.signif |
|:-------|:-------|:--------------|:-----------------------------|----:|----:|----:|----------:|------:|:---------|
| points | points | Levene’s test | `points`\~`stType`\*`gender` | 142 |   5 | 136 |     2.423 | 0.039 | ns       |

## Saving the Data with Normal Distribution Used for Performing ANOVA test

``` r
ndat <- sdat[[1]]
for (dv in names(sdat)[-1]) ndat <- merge(ndat, sdat[[dv]])
write.csv(ndat, paste0("../data/table-with-normal-distribution.csv"))
```

Descriptive statistics of data with normal distribution

|          | stType   | gender    | variable |   n |   mean | median |   min |   max |    sd |    se |    ci | iqr |
|:---------|:---------|:----------|:---------|----:|-------:|-------:|------:|------:|------:|------:|------:|----:|
| points.1 | default  | Feminino  | points   |  15 |  9.467 |   11.0 |  3.00 | 16.00 | 5.125 | 1.323 | 2.838 | 9.0 |
| points.2 | default  | Masculino | points   |  23 | 13.104 |   13.0 | 11.00 | 17.70 | 1.965 | 0.410 | 0.850 | 2.5 |
| points.3 | stFemale | Feminino  | points   |  12 | 10.250 |   11.5 |  3.55 | 15.45 | 4.396 | 1.269 | 2.793 | 7.5 |
| points.4 | stFemale | Masculino | points   |  29 | 11.000 |   13.0 |  3.00 | 16.00 | 4.243 | 0.788 | 1.614 | 5.0 |
| points.5 | stMale   | Feminino  | points   |  20 | 10.900 |   12.0 |  3.00 | 17.00 | 4.644 | 1.038 | 2.174 | 6.0 |
| points.6 | stMale   | Masculino | points   |  43 | 13.558 |   15.0 |  4.00 | 19.00 | 4.697 | 0.716 | 1.446 | 4.0 |

![](anova_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

## Computation of ANOVA test and Pairwise Comparison

### ANOVA test

| var    | Effect        | DFn | DFd |   SSn |    SSd |     F |     p |   ges | p.signif |
|:-------|:--------------|----:|----:|------:|-------:|------:|------:|------:|:---------|
| points | stType        |   2 | 136 | 4.574 | 83.579 | 3.722 | 0.027 | 0.052 | \*       |
| points | gender        |   1 | 136 | 5.949 | 83.579 | 9.680 | 0.002 | 0.066 | \*\*     |
| points | stType:gender |   2 | 136 | 1.100 | 83.579 | 0.895 | 0.411 | 0.013 | ns       |

### Pairwise comparison

| var    | stType   | gender    | group1   | group2    | estimate | conf.low | conf.high |    se | statistic |     p | p.adj | p.adj.signif |
|:-------|:---------|:----------|:---------|:----------|---------:|---------:|----------:|------:|----------:|------:|------:|:-------------|
| points | NA       | Feminino  | default  | stFemale  |   -0.783 |   -4.071 |     2.504 | 1.662 |    -0.407 | 0.685 | 1.000 | ns           |
| points | NA       | Feminino  | default  | stMale    |   -1.433 |   -4.333 |     1.466 | 1.466 |    -0.842 | 0.402 | 1.000 | ns           |
| points | NA       | Feminino  | stFemale | stMale    |   -0.650 |   -3.749 |     2.449 | 1.567 |    -0.356 | 0.722 | 1.000 | ns           |
| points | NA       | Masculino | default  | stFemale  |    2.104 |   -0.266 |     4.474 | 1.198 |     1.164 | 0.247 | 0.740 | ns           |
| points | NA       | Masculino | default  | stMale    |   -0.454 |   -2.647 |     1.739 | 1.109 |    -1.435 | 0.154 | 0.461 | ns           |
| points | NA       | Masculino | stFemale | stMale    |   -2.558 |   -4.598 |    -0.519 | 1.031 |    -2.895 | 0.004 | 0.013 | \*           |
| points | default  | NA        | Feminino | Masculino |   -3.638 |   -6.455 |    -0.821 | 1.425 |    -1.963 | 0.052 | 0.052 | ns           |
| points | stFemale | NA        | Feminino | Masculino |   -0.750 |   -3.664 |     2.164 | 1.473 |    -0.493 | 0.623 | 0.623 | ns           |
| points | stMale   | NA        | Feminino | Masculino |   -2.658 |   -4.956 |    -0.361 | 1.162 |    -2.715 | 0.007 | 0.007 | \*\*         |

### Descriptive Statistic of Estimated Marginal Means

| var    | stType   | gender    |   n |      M |    SE |
|:-------|:---------|:----------|----:|-------:|------:|
| points | default  | Feminino  |  15 |  9.467 | 1.323 |
| points | default  | Masculino |  23 | 13.104 | 0.410 |
| points | stFemale | Feminino  |  12 | 10.250 | 1.269 |
| points | stFemale | Masculino |  29 | 11.000 | 0.788 |
| points | stMale   | Feminino  |  20 | 10.900 | 1.038 |
| points | stMale   | Masculino |  43 | 13.558 | 0.716 |

| var    | stType   | gender    |   n | emmean |   mean | conf.low | conf.high |    sd | sd.emms | se.emms |
|:-------|:---------|:----------|----:|-------:|-------:|---------:|----------:|------:|--------:|--------:|
| points | default  | Feminino  |  15 |  9.467 |  9.467 |    7.275 |    11.658 | 5.125 |   4.292 |   1.108 |
| points | default  | Masculino |  23 | 13.104 | 13.104 |   11.334 |    14.874 | 1.965 |   4.292 |   0.895 |
| points | stFemale | Feminino  |  12 | 10.250 | 10.250 |    7.800 |    12.700 | 4.396 |   4.292 |   1.239 |
| points | stFemale | Masculino |  29 | 11.000 | 11.000 |    9.424 |    12.576 | 4.243 |   4.292 |   0.797 |
| points | stMale   | Feminino  |  20 | 10.900 | 10.900 |    9.002 |    12.798 | 4.644 |   4.292 |   0.960 |
| points | stMale   | Masculino |  43 | 13.558 | 13.558 |   12.264 |    14.853 | 4.697 |   4.292 |   0.655 |

### Anova plots for the dependent variable “points”

``` r
plots <- twoWayAnovaPlots(sdat[["points"]], "points", between, aov[["points"]], pwc[["points"]], c("jitter"), font.label.size=14, step.increase=0.25, p.label="p.adj")
```

#### Plot of “points” based on “stType” (color: gender)

``` r
plots[["stType"]]
```

![](anova_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

#### Plot of “points” based on “gender” (color: stType)

``` r
plots[["gender"]]
```

![](anova_files/figure-gfm/unnamed-chunk-27-1.png)<!-- -->

### Textual Report

ANOVA tests with independent between-subjects variables “stType”
(default, stFemale, stMale) and “gender” (Feminino, Masculino) were
performed to determine statistically significant difference on the
dependent varibles “points”. For the dependent variable “points”, there
was statistically significant effects in the factor “stType” with
F(2,136)=3.722, p=0.027 and ges=0.052 (effect size) and in the factor
“gender” with F(1,136)=9.68, p=0.002 and ges=0.066 (effect size).

Pairwise comparisons using the Estimated Marginal Means (EMMs) were
computed to find statistically significant diferences among the groups
defined by the independent variables, and with the p-values ajusted by
the method “bonferroni”. For the dependent variable “points”, the mean
in the stType=“stFemale” (adj M=11 and SD=4.243) was significantly
different than the mean in the stType=“stMale” (adj M=13.558 and
SD=4.697) with p-adj=0.013; the mean in the gender=“Feminino” (adj
M=10.9 and SD=4.644) was significantly different than the mean in the
gender=“Masculino” (adj M=13.558 and SD=4.697) with p-adj=0.007.

## Tips and References

- Use the site <https://www.tablesgenerator.com> to convert the HTML
  tables into Latex format

- \[2\]: Miot, H. A. (2017). Assessing normality of data in clinical and
  experimental trials. J Vasc Bras, 16(2), 88-91.

- \[3\]: Bárány, Imre; Vu, Van (2007). “Central limit theorems for
  Gaussian polytopes”. Annals of Probability. Institute of Mathematical
  Statistics. 35 (4): 1593–1621.