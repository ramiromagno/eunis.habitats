
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eunis.habitats

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/eunis.habitats)](https://CRAN.R-project.org/package=eunis.habitats)
<!-- badges: end -->

`{eunis.habitats}` is an R data package that provides the [EUNIS Habitat
Classification](https://www.eea.europa.eu/data-and-maps/data/eunis-habitat-classification-1)
in tidy format.

## Installation

You can install the development version of `{eunis.habitats}` like so:

``` r
# install.packages("remotes")
remotes::install_github("ramiromagno/eunis.habitats")
```

## EUNIS classifications

There are four EUNIS classifications included in the one data set
`eunis_habitats` are:

1.  EUNIS classification from 2007, revised in 2012.
2.  EUNIS marine classification from 2019
3.  EUNIS marine classification from 2022
4.  EUNIS terrestrial classification from 2021

Check the documentation for more details: `?eunis_habitats`.

## EUNIS 2012

The full list of EUNIS habitats 2012: codes, scientific names and
revised descriptions. The habitat descriptions of the EUNIS
classification 2007 were revised in 2012. The 2007 habitat types were
not changed in the 2012 description revision which mostly replaced
Palaearctic or UK Marine habitat classification codes used in habitat
descriptions at levels 5 and below with their EUNIS classification
equivalents. In 2019 the classification was further amended to include
two new habitats of the revised Resolution 4 of Bern Convention as
adopted at the 38th Standing Committee meeting, November 2018. The two
habitats are G3.4G Pinus sylvestris forest on chalk in the steppe zone
and X36 Depressions (pody) of the Steppe zone.

``` r
subset(eunis_habitats, classification == "EUNIS_2012")
#> # A tibble: 5,285 × 8
#>    classification section version group level code    name           description
#>    <chr>          <chr>   <chr>   <chr> <int> <chr>   <chr>          <chr>      
#>  1 EUNIS_2012     <NA>    2012    <NA>      1 A       Marine habita… "Marine ha…
#>  2 EUNIS_2012     <NA>    2012    <NA>      2 A1      Littoral rock… "Littoral …
#>  3 EUNIS_2012     <NA>    2012    <NA>      3 A1.1    High energy l… "Extremely…
#>  4 EUNIS_2012     <NA>    2012    <NA>      4 A1.11   Mussel and/or… "Communiti…
#>  5 EUNIS_2012     <NA>    2012    <NA>      5 A1.111  [Mytilus edul… "On very e…
#>  6 EUNIS_2012     <NA>    2012    <NA>      5 A1.112  [Chthamalus] … "Very expo…
#>  7 EUNIS_2012     <NA>    2012    <NA>      6 A1.1121 [Chthamalus m… "Very expo…
#>  8 EUNIS_2012     <NA>    2012    <NA>      6 A1.1122 [Chthamalus] … "Areas of …
#>  9 EUNIS_2012     <NA>    2012    <NA>      5 A1.113  [Semibalanus … "Exposed t…
#> 10 EUNIS_2012     <NA>    2012    <NA>      6 A1.1131 [Semibalanus … "Very expo…
#> # ℹ 5,275 more rows
```

## EUNIS marine 2019

A revision of EUNIS marine habitat classification was published in 2019.
From June 2021 the classification was complemented with crosswalks to
Habitats Directive Annex I and to European Red List of Habitats. An
updated version was published in March 2022. Users should change to the
2022 version at their earliest convenience.

``` r
subset(eunis_habitats, classification == "EUNIS_M_2019")
#> # A tibble: 1,939 × 8
#>    classification section version group   level code    name         description
#>    <chr>          <chr>   <chr>   <chr>   <int> <chr>   <chr>        <chr>      
#>  1 EUNIS_M_2019   marine  2019    benthic     1 M       Marine bent… "Marine be…
#>  2 EUNIS_M_2019   marine  2019    benthic     2 MA1     Littoral ro… "Littoral …
#>  3 EUNIS_M_2019   marine  2019    benthic     3 MA11    Arctic litt… "Arctic li…
#>  4 EUNIS_M_2019   marine  2019    benthic     3 MA12    Atlantic li… "Atlantic …
#>  5 EUNIS_M_2019   marine  2019    benthic     4 MA121   Lichens or … "Lichen co…
#>  6 EUNIS_M_2019   marine  2019    benthic     5 MA1211  Yellow and … "Vertical …
#>  7 EUNIS_M_2019   marine  2019    benthic     5 MA1212  Prasiola st… "Exposed t…
#>  8 EUNIS_M_2019   marine  2019    benthic     5 MA1213  Verrucaria … "Bedrock o…
#>  9 EUNIS_M_2019   marine  2019    benthic     6 MA12131 Verrucaria … "The litto…
#> 10 EUNIS_M_2019   marine  2019    benthic     6 MA12132 Verrucaria … "Upper lit…
#> # ℹ 1,929 more rows
```

## EUNIS marine 2022

The review of the marine component of the EUNIS habitat classification
was initiated in 2014. Marine benthic habitats, marine pelagic and
marine ice associated habitats are separated into three distinct groups,
each with a separate classification structure. The first major division
in the benthic marine part of the EUNIS classification is based on major
biological zones (related to depth) and substrate type. Level 3 of the
classification reflects the main biogeographical regions of Europe’s
seas based on their distinct combinations of salinity and temperature
regimes (Arctic, Baltic, Atlantic, Mediterranean and Black Sea). A first
review was published in 2019 and an update to this version concerning
mostly the Atlantic regional sea is available since March 2022.
Crosswalks to Habitats Directive Annex I and to European Red List of
Habitats are available while crosswalks to EUNIS marine habitats of
version 2012 for the regional seas apart from the Atlantic need to be
revisited.

``` r
subset(eunis_habitats, classification == "EUNIS_M_2022")
#> # A tibble: 1,942 × 8
#>    classification section version group   level code    name         description
#>    <chr>          <chr>   <chr>   <chr>   <int> <chr>   <chr>        <chr>      
#>  1 EUNIS_M_2022   marine  2022    benthic     1 M       Marine bent… "Marine be…
#>  2 EUNIS_M_2022   marine  2022    benthic     2 MA1     Littoral ro… "Littoral …
#>  3 EUNIS_M_2022   marine  2022    benthic     3 MA11    Arctic litt… "Arctic li…
#>  4 EUNIS_M_2022   marine  2022    benthic     3 MA12    Atlantic li… "Atlantic …
#>  5 EUNIS_M_2022   marine  2022    benthic     4 MA121   Lichens or … "Lichen co…
#>  6 EUNIS_M_2022   marine  2022    benthic     5 MA1211  Yellow and … "Vertical …
#>  7 EUNIS_M_2022   marine  2022    benthic     5 MA1212  Prasiola st… "Exposed t…
#>  8 EUNIS_M_2022   marine  2022    benthic     5 MA1213  Verrucaria … "Bedrock o…
#>  9 EUNIS_M_2022   marine  2022    benthic     6 MA12131 Verrucaria … "The litto…
#> 10 EUNIS_M_2022   marine  2022    benthic     6 MA12132 Verrucaria … "Upper lit…
#> # ℹ 1,932 more rows
```

## EUNIS terrestrial 2021

The review of the terrestrial component of the EUNIS habitat
classification was initiated in 2015. The review concerns the groups of
coastal habitats, grasslands, heathland, forest, sparsely vegetated and
vegetated man-made habitats. The review was updated in January 2023 with
some corrections to the existing groups and with the inclusion of
wetlands and additional crosslinks. The remaining groups will be revised
and published at a later stage. The classification includes cross-walks
at level 3 to Habitats Directive Annex I, to European Red List of
Habitats, to Bern Convention Resolution 4 habitats, to MAES and IUCN
ecosystems, to Corine Land Cover classes and to the Euroveg Checklist
2016 Syntaxa. The groups of forest and heathland include also crosswalks
to an earlier revision of these groups published in 2017. Habitats at
level 3 are complemented with lists of characteristic species identified
from the EVA database.

``` r
subset(eunis_habitats, classification == "EUNIS_T_2021")
#> # A tibble: 3,949 × 8
#>    classification section     version group   level code  name       description
#>    <chr>          <chr>       <chr>   <chr>   <int> <chr> <chr>      <chr>      
#>  1 EUNIS_T_2021   terrestrial 2021_1  coastal     1 N     Coastal h… Coastal ha…
#>  2 EUNIS_T_2021   terrestrial 2021_1  coastal     2 N1    Coastal d… Sand-cover…
#>  3 EUNIS_T_2021   terrestrial 2021_1  coastal     3 N11   Atlantic,… Atlantic, …
#>  4 EUNIS_T_2021   terrestrial 2021_1  coastal     4 N111  Boreo-Arc… Annual com…
#>  5 EUNIS_T_2021   terrestrial 2021_1  coastal     4 N112  Middle Eu… Annual hal…
#>  6 EUNIS_T_2021   terrestrial 2021_1  coastal     5 N1121 Baltic sa… Annual dri…
#>  7 EUNIS_T_2021   terrestrial 2021_1  coastal     4 N113  Unvegetat… Sandy beac…
#>  8 EUNIS_T_2021   terrestrial 2021_1  coastal     5 N1131 Baltic un… No descrip…
#>  9 EUNIS_T_2021   terrestrial 2021_1  coastal     5 N1132 Baltic un… No descrip…
#> 10 EUNIS_T_2021   terrestrial 2021_1  coastal     4 N114  Biocenosi… Area corre…
#> # ℹ 3,939 more rows
```

## Original data source

The original data is by [EUNIS Habitat
Classification](https://www.eea.europa.eu/data-and-maps/data/eunis-habitat-classification-1).
