#' ---
#' title: "Factorial ANOVA for `points`"
#' author: Geiser C. Challco <geiser@alumni.usp.br>
#' comment: This file is automatically generate by Shiny-Statistic app (https://statistic.geiser.tech/)
#'          Author - Geiser C. Challco <geiser@alumni.usp.br>
#'          
#'          Shiny-Statistic is distributed in the hope that it will be useful,
#'          but WITHOUT ANY WARRANTY; without even the implied warranty of
#'          MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#'          GNU General Public License for more details.
#'          
#'          You should have received a copy of the GNU General Public License.
#'          If not, see <https://www.gnu.org/licenses/>.
#' output:
#'   github_document:
#'     toc: true
#'   word_document:
#'     toc: true
#'   html_document:
#'     toc: true
#'   pdf_document:
#'     toc: true
#'     keep_tex: true
#' fontsize: 10pt
#' ---
#' 
## ----setup, include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------
## Install and Load Packages
if (!'remotes' %in% rownames(installed.packages())) install.packages('remotes')
if (!"rshinystatistics" %in% rownames(installed.packages())) {
  remotes::install_github("geiser/rshinystatistics")
} else if (packageVersion("rshinystatistics") < "0.0.0.9151") {
  remotes::install_github("geiser/rshinystatistics")
}

wants <- c('ggplot2','ggpubr','rshinystatistics','utils')
has <- wants %in% rownames(installed.packages())
if (any(!has)) install.packages(wants[!has])

library(utils)
library(ggpubr)
library(ggplot2)
library(rshinystatistics)

#' 

#' 
#' ## Initial Variables and Data
#' 
#' * R-script file: [../code/ancova.R](../code/ancova.R)
#' * Initial table file: [../data/initial-table.csv](../data/initial-table.csv)
#' * Data for points [../data/table-for-points.csv](../data/table-for-points.csv)
#' * Table without outliers and normal distribution of  data:  [../data/table-with-normal-distribution.csv](../data/table-with-normal-distribution.csv)
#' * Other data files:  [../data/](../data/)
#' * Files related to the presented results:   [../results/](../results/)
#' 
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
wid <- "ID"
between <- c("condicao")
dvs <- c("points")
names(dvs) <- dvs

dat <- lapply(dvs, FUN = function(dv) {
  data <- read.csv(paste0("../data/table-for-",dv,".csv"))
  rownames(data) <- data[["ID"]]
  return(data)
})
rdat <- dat
sdat <- dat

#' 
#' ### Descriptive statistics of initial data
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
(df <- descriptive_statistics(dat, dvs, between, include.global = T, symmetry.test = T))

#' 

#' 
#' 
## ---- echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------------------------
for (dv in dvs) {
  car::Boxplot(`dv` ~ `condicao`, data = dat[[dv]] %>% cbind(dv=dat[[dv]][[dv]]), id = list(n = Inf))  
}

#' 
#' ## Checking of Assumptions
#' 
#' ### Assumption: Symmetry and treatment of outliers
#' 
#' #### Applying transformation for skewness data when normality is not achieved in any dependent variables or covariance
#' 
#' 
#'  Applying transformation in "points" to reduce skewness
#' 
## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
density_res_plot(rdat[["points"]],"points",between)
rdat[["points"]][["points"]] <- sqrt(max(dat[["points"]][["points"]]+1) - dat[["points"]][["points"]])
density_res_plot(rdat[["points"]],"points",between)

#' 
#' 
#' 
#' #### Dealing with outliers (performing treatment of outliers)
#' 
## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
rdat[["points"]] <- winzorize(rdat[["points"]],"points", c("condicao"))


#' 
#' ### Assumption: Normality distribution of data
#' 
#' #### Removing data that affect normality (extreme values)
#' 
## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
non.normal <- list(

)
sdat <- remove_from_datatable(rdat, non.normal, wid)

#' 
#' #### Result of normality test in the residual model
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
(df <- normality_test_by_res(sdat, dvs, between))

#' 

#' 
#' #### Result of normality test in each group
#' 
#' This is an optional validation and only performed for groups with number greater than 30 observations
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
(df <- descriptive_statistics(sdat, dvs, between, include.global = T, normality.test = T))

#' 

#' 
#' **Observation**:
#' 
#' As sample sizes increase, parametric tests remain valid even with the violation of normality [[1](#references)].
#' According to the central limit theorem, the sampling distribution tends to be normal if the sample is large, more than (`n > 30`) observations.
#' Therefore, we performed parametric tests with large samples as described as follows: 
#' 
#' - In cases with the sample size greater than 100 (`n > 100`), we adopted a significance level of `p < 0.01`
#' 
#' - For samples with `n > 50` observation, we adopted D'Agostino-Pearson test
#' that offers better accuracy for larger samples [[2](#references)].
#' 
#' - For samples' size between `n > 100` and `n <= 200`, we ignored the normality test,
#' and our decision of validating normality was based only in the interpretation of QQ-plots
#' and histograms because the Shapiro-Wilk and D'Agostino-Pearson tests tend to be too sensitive
#' with values greater than 200 observation [[3](#references)].
#' 
#' - For samples with `n > 200` observation, we ignore the normality assumption based on the central theorem limit.
#' 
#' 
#' ### Assumption: Homogeneity of data distribution
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
(df <- homogeneity_test(sdat, dvs, between))

#' 

#' 
#' ## Saving the Data with Normal Distribution Used for Performing ANCOVA Test 
#' 
## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
ndat <- sdat[[1]]
for (dv in names(sdat)[-1]) ndat <- merge(ndat, sdat[[dv]])
write.csv(ndat, paste0("../data/table-with-normal-distribution.csv"))

#' 
#' Descriptive statistics of data with normal distribution
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
(df <- descriptive_statistics(sdat, dvs, between, include.global = T, normality.test = T))

#' 

#' 
## ---- echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------------------------
for (dv in dvs) {
  car::Boxplot(`dv` ~ `condicao`, data = sdat[[dv]] %>% cbind(dv=sdat[[dv]][[dv]]), id = list(n = Inf))  
}

#' 
#' ## Computation of ANOVA Test and Pairwise Comparison
#' 
#' ### ANOVA test
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
(aov <- get.anova.test(sdat, dvs, between, type = 2, "ges"))

#' 

#' 
#' ### Pairwise comparison
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
(pwc <- get.anova.pwc(sdat, dvs, between, p.adjust.method="bonferroni"))

#' 

#' 
#' ### Estimated Marginal Means and ANOVA Plots 
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
(emms <- get.anova.emmeans.with.ds(pwc, sdat, dvs, between, "common", "var"))

#' 

#' 
#' 
#' ### Anova plots for the dependent variable "points"
## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
plots <- oneWayAnovaPlots(sdat[["points"]], "points", between, aov[["points"]], pwc[["points"]], c("jitter"), font.label.size=14, step.increase=0.25)

#' 
#' 
#' #### Plot of "points" based on "condicao"
## ---- fig.width=9, fig.height=7----------------------------------------------------------------------------------------------------------------------------------------
plots[["condicao"]]

#' 
#' 
#' 
#' ### Textual Report
#' 
#' ANOVA tests with independent between-subjects variables "condicao" (inBoost, inThreat, neutro) were performed to determine statistically significant difference on the dependent varibles "points". For the dependent variable "points", there was statistically significant effects in the factor "condicao" with F(2,139)=3.833, p=0.024 and ges=0.052 (effect size).
#' 
#' 
#' Pairwise comparisons using the Estimated Marginal Means (EMMs) were computed to find statistically significant diferences among the groups defined by the independent variables, and with the p-values ajusted by the method "bonferroni". For the dependent variable "points", the mean in the condicao="inBoost" (adj M=2.728 and SD=0.847) was significantly different than the mean in the condicao="inThreat" (adj M=3.1 and SD=0.667) with p-adj=0.032.
#' 
#' 
#' 
#' ## Tips and References
#' 
#' - Use the site [https://www.tablesgenerator.com](https://www.tablesgenerator.com) to convert the HTML tables into Latex format
#' 
#' - [1]: Ghasemi, A., & Zahediasl, S. (2012). Normality tests for statistical analysis: a guide for non-statisticians. International journal of endocrinology and metabolism, 10(2), 486.
#' 
#' - [2]: Miot, H. A. (2017). Assessing normality of data in clinical and experimental trials. J Vasc Bras, 16(2), 88-91.
#' 
#' - [3]: Bárány, Imre; Vu, Van (2007). "Central limit theorems for Gaussian polytopes". Annals of Probability. Institute of Mathematical Statistics. 35 (4): 1593–1621.
#' 
