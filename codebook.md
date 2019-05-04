# Codebook

The following variables are found in `hancock_lakeview_tidy.csv` in the [Tidy Data](https://github.com/jamisoncrawford/wealth/tree/master/Tidy%20Data) folder of the this repository.

1. `project` - categorical; indicates whether Lakeview Amphitheater, `Lakeview`, or Hancock Airport, `Hancock`

2. `name` - categorical; corporation name, abbreviation, or DBA (Doing Business As) name, see folder [Raw Data](https://github.com/jamisoncrawford/wealth/tree/master/Raw%20Data) for full names

3. `ending` - date; final day of working period per payment record in YYYY-MM-DD format

4. `zip` - categorical; U.S. ZIP (Zone Improvement Plan) code of worker disclosed in payment record

5. `ssn` - text; last four digits of worker social security number per payment records

6. `class` - categorical; indicates whether worker is `Apprentice`, `Journeyman`, or `Foreman` per payment record

    * If company records distinguish `Apprentice` or `Foreman`, but not `Journeyman`, it is assumed workers without explicitly stated `class` are `Journeyman` 

7. `hours` - numeric/double; total hourage of worker record, including regular and overtime hours (combined during scraping)

8. `rate` - numeric/double; rate of pay, in USD, of worker per payment record

9. `gross` - numeric/double; total gross pay, in USD, earned by worker during work period of date `ending`

10. `net` - numeric/double; total net pay, in USD, earned by worker during work period of date `ending`

    * Note that `net` may contain payment for workers which are separate from specified `project`, and `net` is not a reflection of `gross` less deductions solely for the project
  
    * For this reason, it is advised to use `gross` as the most accurate reflection of earnings pertaining to `project`
  
11. `sex` - categorical; worker gender per record, only including categories `Male` and `Female`

    * If company records distinguish `sex` and/or `race`, worker records containing no distinction are assumed `Male`
  
12. `race` - categorical; race/ethnicity of worker per record, and includes human-readable abbreviations established by [EEOC race/ethnic classifications](https://www.eeoc.gov/eeoc/statistics/employment/jobpat-eeo1/glossary.cfm)

    * If company records distinguish `sex` and/or `race`, worker records containing no distinction are assumed `White` 
  
13. `ot` - logical; indicates whether `hours` of payment record includes overtime pay

14. `pdf_no` - integer; indicates which PDF in the raw data where the payment record may be found

15. `pdf_pg` - integer; indicates which page in the raw data PDF, indicated by `pdf_no`, where the payment record may be found

16. `pdf_ob` - integer; indicates which observation in the raw data PDF, indicated by `pdf_no` and `pdf_pg`, where the payment record may be found
