
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eunis.habitats <a href="https://rmagno.eu/eunis.habitats/"><img src="man/figures/logo.svg" align="right" height="139" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/eunis.habitats)](https://CRAN.R-project.org/package=eunis.habitats)
<!-- badges: end -->

`{eunis.habitats}` is an R data package that provides the [EUNIS Habitat
Classification](https://www.eea.europa.eu/data-and-maps/data/eunis-habitat-classification-1)
in tidy format.

## Installation

Install from CRAN:

``` r
install.packages("eunis.habitats")
```

You can install the development version of `{eunis.habitats}` like so:

``` r
# install.packages("remotes")
remotes::install_github("ramiromagno/eunis.habitats")
```

## EUNIS classifications

There are four EUNIS classifications included in the one single data set
`eunis_habitats`, namely:

1.  EUNIS classification from 2007, revised in 2012.
2.  EUNIS marine classification from 2019
3.  EUNIS marine classification from 2022
4.  EUNIS terrestrial classification from 2021

For example, to access the marine habitats classified according to EUNIS
revision of 2022:

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

Check the documentation for more details: `?eunis_habitats`.

## Crosswalks (mapping of habitat codes)

From EUNIS 2012 to EUNIS Marine 2022:

``` r
crosswalk(
  code = c("A3.4", "A3.5"),
  from = "EUNIS_2012",
  to = "EUNIS_M_2022",
  unnest = TRUE
)
#> # A tibble: 64 × 2
#>    eunis_2012_code eunis_m_2022_code
#>    <chr>           <chr>            
#>  1 A3.4            MA133            
#>  2 A3.4            MA134            
#>  3 A3.4            MA135            
#>  4 A3.4            MA136            
#>  5 A3.4            MA137            
#>  6 A3.4            MB13             
#>  7 A3.4            MB131            
#>  8 A3.4            MB1311           
#>  9 A3.4            MB1312           
#> 10 A3.4            MB1313           
#> # ℹ 54 more rows
```

From EUNIS Marine 2019 to EUNIS 2012:

``` r
crosswalk(
code = c("MH152", "MH2331"),
from = "EUNIS_M_2019",
to = "EUNIS_2012",
unnest = TRUE
)
#> # A tibble: 2 × 2
#>   eunis_m_2019_code eunis_2012_code
#>   <chr>             <chr>          
#> 1 MH152             A7.12          
#> 2 MH2331            A7.231
```

From EUNIS Marine 2022 to the European Red List of Habitats:

``` r
crosswalk(
code = c("MH152", "MH2331", "MA146", "MD55"),
from = "EUNIS_M_2022",
to = "RL",
unnest = TRUE
)
#> # A tibble: 4 × 2
#>   eunis_m_2022_code rl_code
#>   <chr>             <chr>  
#> 1 MH152             <NA>   
#> 2 MH2331            <NA>   
#> 3 MA146             A1.1xx 
#> 4 MD55              A5.27
```

From EUNIS Marine 2019 to Habitats Directive Annex I:

``` r
crosswalk(
code = c("M", "MA1", "MA11", "MA12"),
from = "EUNIS_M_2019",
to = "Annex_I", unnest = TRUE
)
#> # A tibble: 7 × 2
#>   eunis_m_2019_code annex_i_code
#>   <chr>             <chr>       
#> 1 M                 <NA>        
#> 2 MA1               <NA>        
#> 3 MA11              <NA>        
#> 4 MA12              8330        
#> 5 MA12              1160        
#> 6 MA12              1170        
#> 7 MA12              1130
```

## Original data source

The original data is by [EUNIS Habitat
Classification](https://www.eea.europa.eu/data-and-maps/data/eunis-habitat-classification-1).
