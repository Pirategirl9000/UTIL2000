# UTIL2000
## Table of Contents
* [Author](#author)
* [Purpose](#purpose)
* [Script Breakdown](#script-breakdown)
* [Output](#output)

## Output
![Picture of the output](assets/UTIL2000Output1.png)
---
![Second picture of the output](assets/UTIL2000Output2.png)

## Author
* [Violet French](https://github.com/Pirategirl9000/)
## Purpose
This program uses three predefined users and calculates their utility bill based on three different tiers of electricity consumption. It then displays these results to the SYSOUT
## Script Breakdown
### Data Items
* `WS-RATE-TIER1` - The amount charged for a tier 1 Kw usage
* `WS-RATE-TIER2` - The amount charged for a tier 2 Kw usage
* `WS-RATE-TIER3` - The amount charged for a tier 3 Kw usage
* `WS-TIER1-LIMIT` - The amount of Kw for what is considered a tier 1 usage
* `WS-TIER2-LIMIT` - The amount of Kw bigger than the tier 1 limit before it's considered tier 3 usage
### Paragraphs
