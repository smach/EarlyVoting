In order to reproduce my analysis of early-voting hours in 25 Massachusetts communities, you need to do the following after cloning this GitHub repo on your own machine. I am assuming you are running RStudio and a recently up-to-date version of R.

1. Run the config.R file. That will load necessary packages, installing them if needed.

2. Run the populations.R file. That will import and wrangle some Census data from files in the data subdirectory. Note that if you are interested in how I got the commuting times data specifically, which is rather difficult to download in a format R can read, you can see the get_commute_times.R file. It requires the tidycensus package and a properly configured (free) U.S. Census Bureau API key.

3. Run early_voting_analysis_by_place.R and early_voting_exploratory_dataviz.R.

4. If you are specifically interested in Framingham, see the framingham_internal_early_voting_analysis.R file.

While this code is posted on GitHub under an MIT license, if you end up using a substantial portion of it when writing an article for publication, I'd sure appreciate it if you gave me credit!

_Want more info about using R for election analysis? Check out the election chapter in my forthcoming book, [Practical R for Mass Communication and Journalism](https://www.crcpress.com/Practical-R-for-Mass-Communication-and-Journalism/Machlis/p/book/9781138726918) -- available for pre-order from [CRC Press](https://www.crcpress.com/Practical-R-for-Mass-Communication-and-Journalism/Machlis/p/book/9781138726918), [Amazon](https://www.amazon.com/Practical-Mass-Communication-Journalism-Chapman/dp/1138726915/), and [Barnes & Noble](https://www.barnesandnoble.com/w/practical-r-for-mass-communication-and-journalism-sharon-machlis/1129214032?ean=9781138726918)._

-- Sharon Machlis
