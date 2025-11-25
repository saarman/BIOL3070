G03 Apple Harvest
================
Norah Saarman
2025-12-02

- [Explore the data](#explore-the-data)
- [ABSTRACT](#abstract)
- [BACKGROUND](#background)
- [STUDY QUESTION & HYPOTHESIS](#study-question--hypothesis)
  - [Questions](#questions)
  - [Hypothesis](#hypothesis)
  - [Prediction](#prediction)
- [METHODS & ANALYSIS](#methods--analysis)
  - [Method 1: Table of results, barplot
    visualization](#method-1-table-of-results-barplot-visualization)
  - [Method 2: Chi-squared test](#method-2-chi-squared-test)
    - [Why Chi-square is appropriate](#why-chi-square-is-appropriate)
    - [Interpretation logic](#interpretation-logic)
- [DISCUSSION](#discussion)
  - [Interpretation - Method 1
    (Barplot)](#interpretation---method-1-barplot)
  - [Interpretation - Method 2 (Chi-squared
    test)](#interpretation---method-2-chi-squared-test)
  - [Limitations](#limitations)
- [CONCLUSION](#conclusion)
- [REFERENCES](#references)

# Explore the data

Read in data

``` r
## Read in data set
apples <- read.csv(file="appleHarvest.csv")
#apples$city <- NULL #why this?

## Get length of harvest column
paste("N harvest data points =",length(apples$harvest))
```

    ## [1] "N harvest data points = 241"

Reformat, remove NAs, and structure the data:

``` r
## Replace blanks "" with "blank"
apples$harvest[apples$harvest == ""] <- "blank"

## Revalue factor levels, "blank" = NA
apples$harvest <- revalue(apples$harvest, c("Minimal"="Minimal", "Normal"="Normal", "Above average"="Superior", "blank" = NA))

## omit NA
apples <- na.omit(apples)

## Retain categorical variables as factor
#confirm harvest is a factor
apples$harvest <- as.factor(apples$harvest) 
#confirm pruned is a factor
apples$pruned <- as.factor(apples$pruned) 

## Check that NAs omitted from harvest
apples$harvest
```

    ##   [1] Normal   Normal   Superior Minimal  Minimal  Minimal  Minimal  Minimal 
    ##   [9] Normal   Normal   Normal   Normal   Normal   Normal   Normal   Normal  
    ##  [17] Normal   Minimal  Minimal  Minimal  Minimal  Normal   Minimal  Minimal 
    ##  [25] Minimal  Superior Minimal  Normal   Minimal  Minimal  Superior Minimal 
    ##  [33] Minimal  Minimal  Minimal  Minimal  Superior Minimal  Minimal  Minimal 
    ##  [41] Normal   Minimal  Minimal  Minimal  Normal   Normal   Normal   Normal  
    ##  [49] Normal   Normal   Normal   Normal   Normal   Superior Normal   Normal  
    ##  [57] Normal   Normal   Minimal  Normal   Normal   Normal   Normal   Normal  
    ##  [65] Normal   Minimal  Minimal  Normal   Minimal  Minimal  Normal   Minimal 
    ##  [73] Minimal  Normal   Normal   Normal   Minimal  Minimal  Normal   Minimal 
    ##  [81] Minimal  Normal   Minimal  Normal   Minimal  Minimal  Normal   Minimal 
    ##  [89] Normal   Superior Minimal  Minimal  Normal   Normal   Normal   Normal  
    ##  [97] Minimal  Minimal  Minimal  Minimal  Minimal  Minimal  Normal   Normal  
    ## [105] Normal   Normal   Minimal  Normal   Normal   Minimal  Minimal  Minimal 
    ## [113] Normal   Normal   Normal   Normal   Minimal  Minimal  Normal   Normal  
    ## [121] Normal   Minimal  Minimal  Minimal  Normal   Minimal  Normal   Normal  
    ## [129] Minimal  Minimal  Minimal  Normal   Normal   Normal   Superior Normal  
    ## [137] Normal   Normal   Normal   Normal   Normal   Normal   Superior Superior
    ## Levels: Minimal Normal Superior

``` r
## Check that NAs omitted from purned status
apples$pruned
```

    ##   [1] Yes Yes Yes Yes No  Yes Yes Yes Yes Yes Yes Yes Yes Yes Yes Yes Yes Yes
    ##  [19] Yes Yes Yes Yes Yes Yes Yes No  Yes Yes Yes Yes No  Yes Yes Yes Yes Yes
    ##  [37] No  Yes Yes Yes Yes Yes No  No  No  No  No  No  Yes Yes Yes Yes Yes Yes
    ##  [55] Yes Yes Yes Yes No  No  No  No  No  Yes No  Yes Yes Yes Yes Yes Yes Yes
    ##  [73] Yes Yes Yes Yes Yes Yes Yes No  Yes Yes No  Yes No  No  Yes Yes Yes Yes
    ##  [91] Yes Yes Yes Yes Yes Yes Yes Yes Yes No  No  No  No  No  No  No  No  No 
    ## [109] No  No  No  No  No  No  No  No  No  No  No  No  No  No  Yes No  No  No 
    ## [127] No  No  No  Yes No  No  No  Yes Yes No  No  No  No  No  No  No  No  No 
    ## Levels: No Yes

``` r
## Get length of final harvest column
paste("N harvest data points =",length(apples$harvest))
```

    ## [1] "N harvest data points = 144"

``` r
## Get length of final pruned column
paste("N pruning data points =",length(apples$pruned))
```

    ## [1] "N pruning data points = 144"

This now looks right (no blanks, no NA’s), and the number of data points
has been reduced from 241 to 144, and there is matching data for harvest
and pruning status.

# ABSTRACT

Fill in here.

# BACKGROUND

Fill in here.

# STUDY QUESTION & HYPOTHESIS

## Questions

Do pruned apple trees achieve higher categorical harvest ratings than
unpruned trees?

## Hypothesis

We hypothesize that pruning improves yield for that year.

## Prediction

We predict that pruned trees will have a higher yield rating, with a
rating more often marked as “Superior” or “Normal” than unpruned trees.

# METHODS & ANALYSIS

## Method 1: Table of results, barplot visualization

``` r
library(ggplot2)   # load library
library(scales)    # for percent_format()

## Table of results
table(apples$harvest,apples$pruned)
```

    ##           
    ##            No Yes
    ##   Minimal  22  40
    ##   Normal   34  39
    ##   Superior  5   4

``` r
## Custom muted color palette (Minimal, Normal, Superior)
harvest_colors <- c(
  "Minimal"  = "#D4B86A",  # muted gold
  "Normal"   = "#97C29A",  # pastel green
  "Superior" = "#8CB7D6"   # pastel blue
)

## Stacked bar chart of yield categories by pruning status (ggplot2)
ggplot(apples, aes(x = pruned, fill = harvest)) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = harvest_colors) +
  labs(
    x = "Pruning status",
    y = "Proportion of trees",
    fill = "Harvest"
  ) +
  scale_y_continuous(labels = percent_format()) +
  theme_minimal()
```

![](G03_appleharvest_files/figure-gfm/table%20and%20barplot-1.png)<!-- -->

## Method 2: Chi-squared test

### Why Chi-square is appropriate

Both variables are categorical:  
- Pruned (No / Yes)  
- Harvest grade (Minimal / Normal / Superior)

Cells have sufficient expected counts (all \> 5 except perhaps one, but
overall ≥ 80% ≥ 5, which meets χ² assumptions).

We are testing whether the distribution of harvest grades differs by
pruning status.

### Interpretation logic

Chi-square will tell you whether the grading categories occur in
different proportions for pruned vs. unpruned trees.

Based on the table, the proportions look fairly similar (and “Superior”
is rare in both), so we can expect non-significant results — aligning
with the earlier ANOVA conclusion but now with the correct method.

``` r
# Contingency table
yield_tab <- table(apples$harvest, apples$pruned)

# Chi-square test of independence
chisq.test(yield_tab)
```

    ## Warning in chisq.test(yield_tab): Chi-squared approximation may be incorrect

    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  yield_tab
    ## X-squared = 2.3737, df = 2, p-value = 0.3052

**Warning** appears because the superior counts are low and creates
expected counts slightly below 5.

The rule is:

Chi-square approximation works well if ≥ 80% of cells have expected ≥ 5,
and no cell is \< 1. You have 1 small cell, but the rest are fine.

\*\* So: Chi-square is usable, but you should confirm with Fisher’s
Exact test\*\*

This is standard practice for categorical tests with a small cell or
two.

``` r
fisher.test(yield_tab)
```

    ## 
    ##  Fisher's Exact Test for Count Data
    ## 
    ## data:  yield_tab
    ## p-value = 0.3079
    ## alternative hypothesis: two.sided

This confirms the result from the Chi-squared test.

# DISCUSSION

### Interpretation - Method 1 (Barplot)

The stacked bar plot shows that pruned and unpruned trees have very
similar proportions of Minimal, Normal, and Superior harvest ratings.
Although pruned trees appear to have slightly fewer Minimal yields and
slightly more Normal yields, these differences are small and not
visually convincing. Overall, the barplot suggests that pruning does not
dramatically shift trees into higher or lower harvest categories in this
dataset.

### Interpretation - Method 2 (Chi-squared test)

The chi-square test of independence formally tested whether pruning
status was associated with harvest yield grade. The test was not
significant (χ² = 2.37, df = 2, p = 0.31), meaning that the distribution
of Minimal, Normal, and Superior yields did not differ between pruned
and unpruned trees. This statistical result supports what is seen in the
barplot: pruning did not lead to noticeably higher yield ratings in this
dataset. Because the p-value was well above the common threshold of
0.05, we conclude that any differences observed are likely due to random
variation rather than a real effect of pruning.

### Limitations

Fill in here.

# CONCLUSION

Fill in here.

# REFERENCES

2025-26 apple production will reach nearly 279 million bushels. USApple.
(2025, August 15).
<https://usapple.org/news-resources/2025-26-apple-crop-outlook>

About the Wasatch Back Fruit Tree Project. Utah State University.
(n.d.). <https://extension.usu.edu/wasatch/WBFTP_about>

Kantor, L., & Blazejczyk, A. (2023, May 5). Apples and oranges are the
top U.S. fruit choices. Apples and oranges are the top U.S. fruit
choices \| Economic Research Service.
<https://www.ers.usda.gov/data-products/chart-gallery/chart-detail?chartId=58322>

University of Saskatchewan. (2018, February 2). Alternate or biennial
bearing on fruit trees. College of Agriculture and bioresources.
<https://gardening.usask.ca/articles-and-lists/articles-disorders/disorder-alternate-or-biennial-bearing-on-fruit-trees.php>

Wikimedia Foundation. (2025, October 22). Dummy Variable (statistics).
Wikipedia. <https://en.wikipedia.org/wiki/Dummy_variable_(statistics)>
