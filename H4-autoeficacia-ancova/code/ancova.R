#' ---
#' title: "ANCOVA test for `autoeficacia.pos`"
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
#' * Data for autoeficacia.pos [../data/table-for-autoeficacia.pos.csv](../data/table-for-autoeficacia.pos.csv)
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
wid <- "ID"
covar <- "autoeficacia.pre"
between <- c("stType","gender")
dvs <- c("autoeficacia.pos")
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
df <- dat; df[[covar]] <- dat[[1]]
(df <- descriptive_statistics(df, c(dvs,covar), between, include.global = T, symmetry.test = T))

#' 

#' 
#' 
## ---- echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------------------------
for (dv in dvs) {
  car::Boxplot(`dv` ~ `stType`*`gender`, data = dat[[dv]] %>% cbind(dv=dat[[dv]][[dv]]), id = list(n = Inf))  
}

#' 
#' ## Checking of Assumptions
#' 
#' ### Assumption: Symmetry and treatment of outliers
#' 
#' #### Applying transformation for skewness data when normality is not achieved in any dependent variables or covariance
#' 
#' 
#'  Applying transformation in "autoeficacia.pos" to reduce skewness
#' 
## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
density_res_plot(rdat[["autoeficacia.pos"]],"autoeficacia.pos",between,c(),covar)
rdat[["autoeficacia.pos"]][["autoeficacia.pos"]] <- sqrt(max(dat[["autoeficacia.pos"]][["autoeficacia.pos"]]+1) - dat[["autoeficacia.pos"]][["autoeficacia.pos"]])
rdat[["autoeficacia.pos"]][["autoeficacia.pre"]] <- log10(max(dat[["autoeficacia.pos"]][["autoeficacia.pre"]]+1) - dat[["autoeficacia.pos"]][["autoeficacia.pre"]])
density_res_plot(rdat[["autoeficacia.pos"]],"autoeficacia.pos",between,c(),covar)

#' 
#' 
#' 
#' #### Dealing with outliers (performing treatment of outliers)
#' 
## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
rdat[["autoeficacia.pos"]] <- winzorize(rdat[["autoeficacia.pos"]],"autoeficacia.pos", c("stType","gender"),"autoeficacia.pre")


#' 
#' ### Assumption: Normality distribution of data
#' 
#' #### Removing data that affect normality (extreme values)
#' 
## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
non.normal <- list(
"autoeficacia.pos" = c("p37","p44","p50","p63","p69","p105","p04","p09","p10","p27","p28","p49","p79","p86","p88","p101","p110","p111","p121","p134","p142","p29","p48","p109","p120")
)
sdat <- remove_from_datatable(rdat, non.normal, wid)

#' 
#' #### Result of normality test in the residual model
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
(df <- normality_test_by_res(sdat, dvs, between, c(), covar))

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
#' ### Assumption: Linearity of dependent variables and covariate variable
#' 
#' * Linearity test in "autoeficacia.pos"
## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
ggscatter(sdat[["autoeficacia.pos"]], x=covar, y="autoeficacia.pos", facet.by=between, short.panel.labs = F) + 
stat_smooth(method = "loess", span = 0.9)

#' 
#' 
#' 
#' ### Assumption: Homogeneity of data distribution
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
(df <- homogeneity_test(sdat, dvs, between, c(), covar))

#' 

#' 
#' ## Saving the Data with Normal Distribution Used for Performing ANCOVA Test 
#' 
## ---- echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------------------------
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
  car::Boxplot(`dv` ~ `stType`*`gender`, data = sdat[[dv]] %>% cbind(dv=sdat[[dv]][[dv]]), id = list(n = Inf))  
}

#' 
#' ## Computation of ANCOVA Test and Pairwise Comparison
#' 
#' ### ANCOVA test
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
(aov <- ancova.test(sdat, dvs, between, covar, 2, "ges", "var"))

#' 

#' 
#' ### Pairwise comparison
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
(pwc <- ancova.pwc(sdat, dvs, between, covar, "bonferroni", "var"))

#' 

#' 
#' ### Estimated Marginal Means and ANCOVA Plots 
#' 
## ---- include=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------
(emms <- get.ancova.emmeans.with.ds(pwc, sdat, dvs, between, "common", "var"))

#' 

#' 
#' 
#' ### Ancova plots for the dependent variable "autoeficacia.pos"
## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
plots <- twoWayAncovaPlots(sdat[["autoeficacia.pos"]], "autoeficacia.pos", between
, aov[["autoeficacia.pos"]], pwc[["autoeficacia.pos"]], font.label.size=14, step.increase=0.25)

#' 
#' #### Plot for: `autoeficacia.pos` ~ `stType`
## ---- fig.width=7, fig.height=7----------------------------------------------------------------------------------------------------------------------------------------
plots[["stType"]]

#' 
#' 
#' #### Plot for: `autoeficacia.pos` ~ `gender`
## ---- fig.width=7, fig.height=7----------------------------------------------------------------------------------------------------------------------------------------
plots[["gender"]]

#' 
#' 
#' 
#' ### Textual Report
#' 
#' After controlling the linearity of covariance "autoeficacia.pre", ANCOVA tests with independent between-subjects variables "stType" (default, stFemale, stMale) and "gender" (Feminino, Masculino) were performed to determine statistically significant difference on the dependent varibles "autoeficacia.pos". For the dependent variable "autoeficacia.pos", there was statistically significant effects in the factor "autoeficacia.pre" with F(1,110)=43.376, p<0.001 and ges=0.283 (effect size) and in the factor "stType" with F(2,110)=5.003, p=0.008 and ges=0.083 (effect size) and in the factor "gender" with F(1,110)=9.185, p=0.003 and ges=0.077 (effect size).
#' 
#' 
#' Pairwise comparisons using the Estimated Marginal Means (EMMs) were computed to find statistically significant diferences among the groups defined by the independent variables, and with the p-values ajusted by the method "bonferroni". For the dependent variable "autoeficacia.pos", the mean in the stType="default" (adj M=1.637 and SD=0.364) was significantly different than the mean in the stType="stMale" (adj M=1.38 and SD=0.153) with p-adj=0.005; the mean in the stType="stFemale" (adj M=1.617 and SD=0.325) was significantly different than the mean in the stType="stMale" (adj M=1.38 and SD=0.153) with p-adj=0.008; the mean in the gender="Feminino" (adj M=1.702 and SD=0.318) was significantly different than the mean in the gender="Masculino" (adj M=1.38 and SD=0.153) with p-adj=0.001.
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
