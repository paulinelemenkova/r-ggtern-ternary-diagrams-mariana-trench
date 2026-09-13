# R Ternary Diagrams (ggtern) — Mariana Trench Geomorphic Factors

R script plotting ternary diagrams with the ggtern package to show the triple correlation of three geomorphic factors of the Mariana Trench (e.g. tectonics, slope angle, igneous volcanic areas) across its profiles and tectonic plates.

## Related publication

This script produced figures in:

Lemenkova, P. Plotting Ternary Diagrams by R Library ggtern for Geological Modelling. Eastern Anatolian Journal of Science 2019, 5(2), 16-25.

- DOI: https://doi.org/10.6084/m9.figshare.11369955
- HAL: https://hal.science/hal-02413007
- Zenodo: https://zenodo.org/record/3576669
- SSRN: https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3504383
- ISSN: 2149-6137

## Script

- Ternary.r: reads Morphology.csv and draws ternary (three-component) diagrams with ggtern (geom_point, tern-axis lines, confidence regions), one per factor triple (tectonics, aspect class, sediment thickness, igneous volcanic, slope morphology).

## Methods

- Ternary (barycentric) plotting of compositional three-part data (ggtern).

## Data

- Morphology.csv: per-profile morphometric/geological factors of the Mariana Trench.

## Requirements

- R (>= 3.5); packages: ggtern, ggplot2

## Author and citation

Polina Lemenkova — ORCID https://orcid.org/0000-0002-5759-1089

Cite: Lemenkova, P. Plotting Ternary Diagrams by R Library ggtern for Geological Modelling. Eastern Anatolian Journal of Science 2019, 5(2), 16-25. https://doi.org/10.6084/m9.figshare.11369955

## License

MIT — see LICENSE (Copyright Polina Lemenkova).
