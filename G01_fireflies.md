G01 fireflies abundance data
================
Norah Saarman
2025-11-25

- [First explore the data](#first-explore-the-data)
  - [Firefly counts histogram](#firefly-counts-histogram)
- [Now, some analysis](#now-some-analysis)
  - [1st Analysis - Violin Plot](#1st-analysis---violin-plot)
  - [2nd Analysis - Shapiro-Wilk test for
    normality](#2nd-analysis---shapiro-wilk-test-for-normality)
  - [3rd Analysis - Wilcoxon Rank-Sum
    test](#3rd-analysis---wilcoxon-rank-sum-test)
  - [Analysis 4 - Even better, one-sided rank sum
    test!](#analysis-4---even-better-one-sided-rank-sum-test)

# First explore the data

Counting the reported firefly counts as abundance is problematic. For
example, the counts of even 100 or 1000 seems very unlikely… I do not
believe is accurate data, it is unlikely a citizen scientist would
accurately count exactly 1000 fire flies.

## Firefly counts histogram

``` r
library(ggplot2)

# Read in the data
fireflies <- read.csv("firefliesUtah_2014-2024.csv", stringsAsFactors = FALSE)
#colnames(fireflies) <- c("firefly_count", "region") # Already defined in .csv input

# Histogram for South
hist(
  fireflies$firefly_count[fireflies$region == "south"],
  breaks = 100,
  main = "South",
  xlab = "Firefly count per observation"
)
```

![](G01_fireflies_files/figure-gfm/firefly%20counts%20histogram-1.png)<!-- -->

``` r
# Histogram for North
hist(
  fireflies$firefly_count[fireflies$region == "north"],
  breaks = 100,
  main = "North",
  xlab = "Firefly count per observation"
)
```

![](G01_fireflies_files/figure-gfm/firefly%20counts%20histogram-2.png)<!-- -->

# Now, some analysis

## 1st Analysis - Violin Plot

Violin plot, this gives more information than the boxplot.

Also, dropping log transformation: Most observations are “1 firefly.”
Log(1) = 0, so nearly all observations collapse onto the same value.
This destroys any ability to detect differences between regions.

``` r
# Split Violin Plot (y-axis limited to 50) and downloaded the necessary library packages

library(ggplot2)
library(gghalves)
library(stringi)

fireflies$region[fireflies$region == ""] <- NA
fireflies$region <- stri_trans_general(fireflies$region, "NFKC")
fireflies$region <- stri_replace_all_regex(fireflies$region, "\\p{C}", "")
fireflies$region <- gsub("\u00A0", " ", fireflies$region)
fireflies$region <- trimws(tolower(fireflies$region))
fireflies$region[fireflies$region %in% c("n", "nrth", "noth")] <- "north"
fireflies$region[fireflies$region %in% c("s", "sth", "soth")] <- "south"
fireflies$region <- factor(fireflies$region, levels = c("north", "south"))
fireflies <- droplevels(subset(fireflies, !is.na(region)))

# Split the violin plot
ggplot() +
geom_half_violin(
data = subset(fireflies, region == "north"),
aes(x = factor(1), y = firefly_count, fill = region),
side = "l", trim = TRUE, color = "black", alpha = 0.7
) +
geom_half_violin(
data = subset(fireflies, region == "south"),
aes(x = factor(1), y = firefly_count, fill = region),
side = "r", trim = TRUE, color = "black", alpha = 0.7
) +
scale_fill_manual(values = c("north" = "#00A9FF", "south" = "orange")) +
coord_cartesian(ylim = c(0, 50)) + # y-axis capped at 50
labs(
title = "Firefly Abundance: North vs South",
x = NULL,
y = "Firefly Count"
) +
theme_minimal(base_size = 13) +
theme(
legend.position = "bottom",
plot.title = element_text(size = 24, face = "bold", hjust = 0.5),
axis.text.x = element_blank(),
axis.ticks.x = element_blank(),
axis.title.y = element_text(size = 20, face = "bold"),
axis.title.x = element_text(size = 20, face = "bold")
)
```

![](G01_fireflies_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
#ChatGPT. OpenAI, version GPT-5.1. Used as a first pass, but edited carefully to make the figure look correct. Accessed [November 2025].
```

## 2nd Analysis - Shapiro-Wilk test for normality

Let’s try testing for normality with Shapiro-Wilk test:

``` r
# Shapiro–Wilk tests for normality

shapiro.test(
  fireflies$firefly_count[fireflies$region == "south"]
)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  fireflies$firefly_count[fireflies$region == "south"]
    ## W = 0.19196, p-value < 2.2e-16

``` r
shapiro.test(
  fireflies$firefly_count[fireflies$region == "north"]
)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  fireflies$firefly_count[fireflies$region == "north"]
    ## W = 0.16535, p-value < 2.2e-16

Shapiro–Wilk tests indicated strong deviations from normality in both
regions. This confirms that firefly count data are highly non-normal,
consistent with the right-skewed distributions seen in the histograms.

## 3rd Analysis - Wilcoxon Rank-Sum test

The best test is the Wilcoxon rank-sum test (Mann–Whitney U):  
– non-normal distributions  
– right-skewed  
– ties  
– 1-infation  
– discrete counts

And it doesn’t require a parametric count model.

``` r
wilcox.test(
  firefly_count ~ region,
  data = fireflies
)
```

    ## 
    ##  Wilcoxon rank sum test with continuity correction
    ## 
    ## data:  firefly_count by region
    ## W = 23458, p-value = 0.1969
    ## alternative hypothesis: true location shift is not equal to 0

``` r
wilcox.test(
  firefly_count ~ region,
  data = fireflies
)
```

    ## 
    ##  Wilcoxon rank sum test with continuity correction
    ## 
    ## data:  firefly_count by region
    ## W = 23458, p-value = 0.1969
    ## alternative hypothesis: true location shift is not equal to 0

Why Wilcoxon is preferable to quasi-Poisson regression for this
comparison

Wilcoxon makes almost no assumptions. It does not require:  
– a specific distribution (Poisson, NB, etc.)  
– equal variances  
– linearity on the log scale  
– correct specification of the mean–variance relationship

It only requires that the two samples represent independent
observations.

Your firefly data violate key assumptions of quasi-Poisson models.  
The data are:  
– heavily right-skewed  
– strongly 1-inflated  
– full of ties  
– reported by citizen scientists with variable effort

These features break the basic Poisson‐type assumption that counts arise
from a well-defined rate process with variance proportional to the mean.

Quasi-Poisson is designed for modeling, not simple group comparisons.  
It is appropriate when you:  
– have a meaningful count process  
– want to estimate rates  
– want to include predictor variables  
– care about effect sizes and confidence intervals

Here, you only want to test whether the two regions differ.

Wilcoxon directly compares the distributions without pretending the
counts follow a mechanistic model.  
It simply asks: “Are values in one region generally larger than values
in the other?”

With messy citizen-science count data, nonparametric tests are more
robust.  
A quasi-Poisson model may produce:  
– poor fit  
– misleading dispersion estimates  
– unstable parameter estimates  
– inflated Type I errors  
… because the model is misspecified relative to what the data actually
are.

## Analysis 4 - Even better, one-sided rank sum test!

Test if North \> South

``` r
wilcox.test(firefly_count ~ region, data = fireflies,
            alternative = "greater")
```

    ## 
    ##  Wilcoxon rank sum test with continuity correction
    ## 
    ## data:  firefly_count by region
    ## W = 23458, p-value = 0.09847
    ## alternative hypothesis: true location shift is greater than 0

This is because the median value is higher for the north, you should
probably also report this!

``` r
tapply(fireflies$firefly_count, fireflies$region, median)
```

    ## north south 
    ##   3.0   2.5
