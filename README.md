<!-- README.md is generated from README.Rmd. Please edit that file -->
SVAA
====

The goal of SVAA is is to provide an accessible and scalable framework
for structural vector autoregressive analysis in R. While similar - and
at this point more comprehensive - packages have long existed and been
established within the R community (namely
[vars](https://cran.r-project.org/web/packages/vars/vars.pdf)), SVAA is
designed to... This guide will not only take you through the core
functionality of SVAA, but also explain theory underlying the code. The
package draws heavily on the text book [Structural Vector Autoregressive
Analysis](https://sites.google.com/site/lkilian2019/textbook) by Lutz
Kilian and Helmut Luethkepohl.

Installation
------------

You can install SVAA from the Bank's package repository -
[Artifactory](https://binarycentral/artifactory/webapp/). In most cases
R will automatically be linked to Artifactory, so you should be able to
install SVAA in the same way you would install any other package:

    install.packages("SVAA")

If this does not work for you, please see
[here](https://bankexchange/groups/1067/Pages/Wiki/Accessing%20and%20using%20Artifactory.aspx)
for guidance on accessing Artifactory.

Once installed you need to attach the package:

    library(SVAA)

Guidance
--------

For detailed guidance on different topics and estimation methods covered
by SVAA, you should consult the package vignettes. Simply type
`utils::browseVignettes()` once you have completed the steps above.
