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
* Constants
  * Various fields whose values don't change throughout the program
  * `WS-RATE-TIER1`  - The amount charged for a tier 1 Kw usage
  * `WS-RATE-TIER2`  - The amount charged for a tier 2 Kw usage
  * `WS-RATE-TIER3`  - The amount charged for a tier 3 Kw usage
  * `WS-TIER1-LIMIT` - The amount of Kw for what is considered a tier 1 usage
  * `WS-TIER2-LIMIT` - The amount of Kw bigger than the tier 1 limit before it's considered tier 3 usage

* Predefined Customers
  * `WS-CUST1`, `WS-CUST2`, `WS-CUST3`
    * Stores information related to each customer
    * Data Items ('#' indicates the customer's number)
      * `WS-C#-NAME` - The name of the customer
      * `WS-C#-KWH`  - The total Kilowatt hours the person used
      * `WS-C#-FEE`  - The service fee for this customer
* Current Input fields
  * Store the information of the current customer whose values we are calculating
  * We do it this way so that the paragraphs can achieve a form of polymorphism
  * Data Items
    * `WS-CUST-NAME`   - Stores the name of the customer
    * `WS-KWH-USED`    - Stores the Kilowatt hours
    * `WS-SERVICE-FEE` - Stores the service fee
### Paragraphs
