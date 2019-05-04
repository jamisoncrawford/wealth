# Codebook

The following variables are found in `hancock_lakeview_tidy.csv` in the [Tidy Data](https://github.com/jamisoncrawford/wealth/tree/master/Tidy%20Data) folder of the this repository.

`project` - categorical; indicates whether Lakeview Amphitheater, `Lakeview`, or Hancock Airport, `Hancock`

`name` - categorical; corporation name, abbreviation, or DBA (Doing Business As) name, see folder [Raw Data](https://github.com/jamisoncrawford/wealth/tree/master/Raw%20Data) for full names

`ending` - date; final day of working period per payment record in YYYY-MM-DD format

`zip` - categorical; U.S. ZIP (Zone Improvement Plan) code of worker disclosed in payment record

`ssn` - text; last four digits of worker social security number per payment records

`class` - categorical; indicates whether worker is `Apprentice`, `Journeyman`, or `Foreman` per payment record

* If company records distinguish `Apprentice` or `Foreman`, but not `Journeyman`, it is assumed workers without explicitly stated `class` are `Journeyman` 

`hours` - numeric/double; total hourage of worker record, including regular and overtime hours (combined during scraping)

`rate` - numeric/double; rate of pay, in USD, of worker per payment record

`gross` - numeric/double; total gross pay, in USD, earned by worker during work period of date `ending`

`net` - numeric/double; total net pay, in USD, earned by worker during work period of date `ending`

* Note that `net` may contain payment for workers which are separate from specified `project`, and `net` is not a reflection of `gross` less deductions solely for the project
  
* For this reason, it is advised to use `gross` as the most accurate reflection of earnings pertaining to `project`
  
`sex` - categorical; worker gender per record, only including categories `Male` and `Female`

* If company records distinguish `sex` and/or `race`, worker records containing no distinction are assumed `Male`
  
`race` - categorical; race/ethnicity of worker per record, and includes human-readable abbreviations established by [EEOC race/ethnic classifications](https://www.eeoc.gov/eeoc/statistics/employment/jobpat-eeo1/glossary.cfm)

* If company records distinguish `sex` and/or `race`, worker records containing no distinction are assumed `White` 
  
`ot` - logical; indicates whether `hours` of payment record includes overtime pay

`pdf_no` - integer; indicates which PDF in the raw data where the payment record may be found

`pdf_pg` - integer; indicates which page in the raw data PDF, indicated by `pdf_no`, where the payment record may be found

`pdf_ob` - integer; indicates which observation in the raw data PDF, indicated by `pdf_no` and `pdf_pg`, where the payment record may be found
