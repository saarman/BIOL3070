Final Project
================
Norah Saarman
2025-10-30

- [ABSTRACT](#abstract)
- [BACKGROUND](#background)
- [STUDY QUESTION and HYPOTHESIS](#study-question-and-hypothesis)
  - [Questions](#questions)
  - [Hypothesis](#hypothesis)
  - [Prediction](#prediction)
- [MOTHODS](#mothods)
  - [Fill in 1st analysis
    e.g. barplots](#fill-in-1st-analysis-eg-barplots)
  - [Optional 3rd analysis/plot
    e.g. heatmap](#optional-3rd-analysisplot-eg-heatmap)
- [DISCUSSION](#discussion)
  - [Interpretation of 1st analysis
    (e.g. barplots)](#interpretation-of-1st-analysis-eg-barplots)
  - [Interpretation of 2nd analysis (e.g. generalized linear
    model)](#interpretation-of-2nd-analysis-eg-generalized-linear-model)
  - [Optional interpretation of 3rd analysis
    (e.g. heatmaps)](#optional-interpretation-of-3rd-analysis-eg-heatmaps)
- [CONCLUSION](#conclusion)
- [REFERENCES](#references)

# ABSTRACT

Fill in abstract… Write this last, after finishing methods, results, and
discussion. Summarize the overall study question, approach, results, and
conclusion in a short paragraph.

# BACKGROUND

Provide background …

Example: You might cite Komar et al. (2003) showing viremia duration in
birds, which explains why house finches could act as amplifying hosts.
Connect this to the prediction that locations with more house finch
blood meals should also show higher rates of WNV-positive mosquito
pools.

# STUDY QUESTION and HYPOTHESIS

## Questions

What impact does latitude have on firefly sightings?

## Hypothesis

Fill in here…

## Prediction

Fill in here…

# MOTHODS

Fill in here…

## Fill in 1st analysis e.g. barplots

``` r
# code for figure 1 
```

Fill in here… Explain that you compared the number of mosquito blood
meals from each host species between sites with no WNV-positive pools
and sites with one or more WNV-positive pools. Describe why a barplot
helps visualize this comparison. \## Fill in 2nd analysis/plot
e.g. generalized linear model

Fill in here… Explain that you tested whether the presence or number of
house finch blood meals predicts whether a site had higher WNV
positivity rate in tested mosquito pools. Mention that this statistical
test lets you formally evaluate the relationship suggested by the
barplots.

## Optional 3rd analysis/plot e.g. heatmap

Fill in here… completely optional… If you include it, describe that you
mapped mosquito blood meals and WNV-positive pools across space. Explain
how this visualization can reveal whether the two overlap
geographically, providing another way to evaluate your hypothesis.

``` r
library(dplyr)
library(tidyr)
library(ggplot2)

#some analysis or plotting here, maybe a density plot for example...
```

# DISCUSSION

Fill in here… For each analysis, summarize what you found and interpret
the results. Say whether they support or contradict your hypothesis.

## Interpretation of 1st analysis (e.g. barplots)

The first analysis… fill in here what it was, the summary of the
results, and your interpretation.

## Interpretation of 2nd analysis (e.g. generalized linear model)

The second analysis… fill in here what it was, the summary of the
results, and your interpretation.

## Optional interpretation of 3rd analysis (e.g. heatmaps)

The third analysis… fill in here what it was, the summary of the
results, and your interpretation.

# CONCLUSION

Fill in here… State the overall answer to your research question, based
on all analyses. Mention whether the evidence supports your hypothesis
and what it suggests about WNV amplification in Salt Lake City.

# REFERENCES

Fill in here… List all sources you cited in your background and
throughout the report. Use a consistent style.a conclusion you can draw
from your analysis.

1.  Komar N, Langevin S, Hinten S, Nemeth N, Edwards E, Hettler D, Davis
    B, Bowen R, Bunning M. Experimental infection of North American
    birds with the New York 1999 strain of West Nile virus. Emerg Infect
    Dis. 2003 Mar;9(3):311-22. <https://doi.org/10.3201/eid0903.020628>

2.  ChatGPT. OpenAI, version Jan 2025. Used as a reference for functions
    such as plot() and to correct syntax errors. Accessed 2025-10-30.
