ANOVA test for `points`\~`condicao`
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

| condicao | variable |   n |   mean | median | min | max |    sd |    se |    ci |  iqr | symmetry | skewness | kurtosis |
|:---------|:---------|----:|-------:|-------:|----:|----:|------:|------:|------:|-----:|:---------|---------:|---------:|
| inBoost  | points   |  55 | 12.927 |     14 |   2 |  20 | 5.069 | 0.684 | 1.370 | 5.00 | NO       |   -0.572 |   -0.557 |
| inThreat | points   |  49 | 10.939 |     12 |   1 |  19 | 4.616 | 0.659 | 1.326 | 5.00 | NO       |   -0.691 |   -0.609 |
| neutro   | points   |  38 | 11.395 |     12 |   1 |  18 | 4.378 | 0.710 | 1.439 | 3.00 | NO       |   -0.944 |    0.015 |
| NA       | points   | 142 | 11.831 |     13 |   1 |  20 | 4.788 | 0.402 | 0.794 | 4.75 | NO       |   -0.610 |   -0.333 |

![](anova_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

    ##  [1] "p79"  "p90"  "p33"  "p14"  "p56"  "p61"  "p124" "p127" "p129" "p140"

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
rdat[["points"]] <- winzorize(rdat[["points"]],"points", c("condicao"), skewness=skewness)
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
| points | points | 142 |   -0.055 |   -0.261 | YES      |     0.206 | D’Agostino | 0.902 | ns       | QQ        |

#### Result of normality test in each group

This is an optional validation and only valid for groups with number
greater than 30 observations

| condicao | variable |   n |   mean | median |    min |    max |    sd |    se |    ci |   iqr | normality | method       | statistic |     p | p.signif |
|:---------|:---------|----:|-------:|-------:|-------:|-------:|------:|------:|------:|------:|:----------|:-------------|----------:|------:|:---------|
| inBoost  | points   |  55 | -2.682 | -2.646 | -4.359 | -1.000 | 0.948 | 0.128 | 0.256 | 0.926 | YES       | D’Agostino   |     0.799 | 0.671 | ns       |
| inThreat | points   |  49 | -3.092 | -3.000 | -4.472 | -1.414 | 0.717 | 0.102 | 0.206 | 0.818 | NO        | Shapiro-Wilk |     0.950 | 0.036 | \*       |
| neutro   | points   |  38 | -3.026 | -3.000 | -4.472 | -1.732 | 0.679 | 0.110 | 0.223 | 0.517 | NO        | Shapiro-Wilk |     0.923 | 0.013 | \*       |

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

|        | var    | method        | formula              |   n | df1 | df2 | statistic |     p | p.signif |
|:-------|:-------|:--------------|:---------------------|----:|----:|----:|----------:|------:|:---------|
| points | points | Levene’s test | `points`\~`condicao` | 142 |   2 | 139 |     3.039 | 0.051 | ns       |

## Saving the Data with Normal Distribution Used for Performing ANOVA test

``` r
ndat <- sdat[[1]]
for (dv in names(sdat)[-1]) ndat <- merge(ndat, sdat[[dv]])
write.csv(ndat, paste0("../data/table-with-normal-distribution.csv"))
```

Descriptive statistics of data with normal distribution

|          | condicao | variable |   n |   mean | median | min |  max |    sd |    se |    ci | iqr |
|:---------|:---------|:---------|----:|-------:|-------:|----:|-----:|------:|------:|------:|----:|
| points.1 | inBoost  | points   |  55 | 12.855 |     14 |   4 | 19.0 | 4.786 | 0.645 | 1.294 |   5 |
| points.2 | inThreat | points   |  49 | 10.955 |     12 |   3 | 16.6 | 4.356 | 0.622 | 1.251 |   5 |
| points.3 | neutro   | points   |  38 | 11.384 |     12 |   3 | 16.3 | 4.076 | 0.661 | 1.340 |   3 |

![](anova_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

## Computation of ANOVA test and Pairwise Comparison

### ANOVA test

| var    | Effect   | DFn | DFd |   SSn |    SSd |     F |     p |   ges | p.signif |
|:-------|:---------|----:|----:|------:|-------:|------:|------:|------:|:---------|
| points | condicao |   2 | 139 | 4.991 | 90.271 | 3.843 | 0.024 | 0.052 | \*       |

### Pairwise comparison

| var    | group1   | group2   | estimate | conf.low | conf.high |    se | statistic |     p | p.adj | p.adj.signif |
|:-------|:---------|:---------|---------:|---------:|----------:|------:|----------:|------:|------:|:-------------|
| points | inBoost  | inThreat |    1.899 |    0.168 |     3.631 | 0.876 |     2.590 | 0.011 | 0.032 | \*           |
| points | inBoost  | neutro   |    1.470 |   -0.389 |     3.330 | 0.940 |     2.025 | 0.045 | 0.134 | ns           |
| points | inThreat | neutro   |   -0.429 |   -2.334 |     1.476 | 0.964 |    -0.377 | 0.707 | 1.000 | ns           |

### Descriptive Statistic of Estimated Marginal Means

| var    | condicao |   n |      M |    SE |
|:-------|:---------|----:|-------:|------:|
| points | inBoost  |  55 | 12.855 | 0.645 |
| points | inThreat |  49 | 10.955 | 0.622 |
| points | neutro   |  38 | 11.384 | 0.661 |

| var    | condicao |   n | emmean |   mean | conf.low | conf.high |    sd | sd.emms | se.emms |
|:-------|:---------|----:|-------:|-------:|---------:|----------:|------:|--------:|--------:|
| points | inBoost  |  55 | 12.855 | 12.855 |   11.666 |    14.043 | 4.786 |   4.458 |   0.601 |
| points | inThreat |  49 | 10.955 | 10.955 |    9.696 |    12.214 | 4.356 |   4.458 |   0.637 |
| points | neutro   |  38 | 11.384 | 11.384 |    9.954 |    12.814 | 4.076 |   4.458 |   0.723 |

### Anova plots for the dependent variable “points”

``` r
plots <- oneWayAnovaPlots(sdat[["points"]], "points", between, aov[["points"]], pwc[["points"]], c("jitter"), font.label.size=14, step.increase=0.25, p.label="p.adj")
```

#### Plot of “points” based on “condicao”

``` r
plots[["condicao"]]
```

![](anova_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

### Textual Report

ANOVA tests with independent between-subjects variables “condicao”
(inBoost, inThreat, neutro) were performed to determine statistically
significant difference on the dependent varibles “points”. For the
dependent variable “points”, there was statistically significant effects
in the factor “condicao” with F(2,139)=3.843, p=0.024 and ges=0.052
(effect size).

Pairwise comparisons using the Estimated Marginal Means (EMMs) were
computed to find statistically significant diferences among the groups
defined by the independent variables, and with the p-values ajusted by
the method “bonferroni”. For the dependent variable “points”, the mean
in the condicao=“inBoost” (adj M=12.855 and SD=4.786) was significantly
different than the mean in the condicao=“inThreat” (adj M=10.955 and
SD=4.356) with p-adj=0.032.

## Tips and References

- Use the site <https://www.tablesgenerator.com> to convert the HTML
  tables into Latex format

- \[2\]: Miot, H. A. (2017). Assessing normality of data in clinical and
  experimental trials. J Vasc Bras, 16(2), 88-91.

- \[3\]: Bárány, Imre; Vu, Van (2007). “Central limit theorems for
  Gaussian polytopes”. Annals of Probability. Institute of Mathematical
  Statistics. 35 (4): 1593–1621.