*import dataset

import delimited using "/Users/hl0616/Library/Mobile Documents/com~apple~CloudDocs/NYU/Spring 2024/GPH-GU-2225 Psychometric Measurement and Analysis/Final Project/mexican_medical_students_mental_health_data_new.csv"

destring weight, replace force
destring phq1-phq9, replace force
destring gad1-gad7, replace force
destring epw1-epw8, replace force

export delimited using "mexican_medical_students_mental_health_data_new.csv", replace

import delimited using "mexican_medical_students_mental_health_data_new.csv"

describe

/* Demographic Characterstics */

*School Year in Medical School
label define school_year_new 1 "Year 1" 2 "Year 2" 3 "Year 3" 4 "Year 4"
label value school_year school_year_new
tab school_year, missing

*Semester in Medical School
label define semester_new 1 "Semester 1" 2 "Semester 2" 3 "Semester 3" 4 "Semester 4" 5 "Semester 5" 6 "Semester 6" 7 "Semester 7" 8 "Semester 8"
label value semester semester_new
tab semester, missing

*Age
summarize age, detail

*Gender
gen gender_new =.
replace gender_new = 1 if gender == "m"
replace gender_new = 2 if gender == "f"
replace gender_new =. if gender == "NA"

label define gender_label 1 "Male" 2 "Female"
label value gender_new gender_label
tab gender_new, missing

*Height
summarize height, detail

*Weight
summarize weight, detail

/* PHQ-9 Depression Scale */

*phq1 - Little interest or pleasure in doing things	
summarize phq1	
*phq2 - Feeling down, depressed, or hopeless
summarize phq2		
*phq3 - Trouble falling or stay asleep, or sleep too much
summarize phq3		
*phq4 - Feeling tired or having little energy
summarize phq4	
*phq5 - Poor appetite or overeating
summarize phq5
*phq6 - Feeling bad about yourself - or that you are a failure or have let yourself or your family down
summarize phq6
*phq7 - Trouble concentrating on things, such as reading the newspaper or watching television
summarize phq7
*phq8 - Moving or speaking so slowly that other people could have noticed? Or the opposite - being so fidgety or restless that you have been moving around a lot more than usual
summarize phq8
*phq9 - Thoughts that you would be better off dead or of hurting yourself in some way			
summarize phq9

/* Reliability */

alpha phq1 phq2 phq3 phq4 phq5 phq6 phq7 phq8 phq9, asis item detail
*drop phq1
alpha phq2 phq3 phq4 phq5 phq6 phq7 phq8 phq9, asis item detail
*drop phq2
alpha phq1 phq3 phq4 phq5 phq6 phq7 phq8 phq9, asis item detail
*drop phq3
alpha phq1 phq2 phq4 phq5 phq6 phq7 phq8 phq9, asis item detail
*drop phq4
alpha phq1 phq2 phq3 phq5 phq6 phq7 phq8 phq9, asis item detail
*drop phq5
alpha phq1 phq2 phq3 phq4 phq6 phq7 phq8 phq9, asis item detail
*drop phq6
alpha phq1 phq2 phq3 phq4 phq5 phq7 phq8 phq9, asis item detail
*drop phq7
alpha phq1 phq2 phq3 phq4 phq5 phq6 phq8 phq9, asis item detail
*drop phq8
alpha phq1 phq2 phq3 phq4 phq5 phq6 phq7 phq9, asis item detail
*drop phq9
alpha phq1 phq2 phq3 phq4 phq5 phq6 phq7 phq8, asis item detail

/* Factor Analysis */

factor phq1 phq2 phq3 phq4 phq5 phq6 phq7 phq8 phq9, factors(2) ipf

/* Plot scree plot */
screeplot, mean title("")

/* Validity */

*phq9 and gad7
pwcorr (phq1-phq9) (gad1-gad7)

egen phq_total = rowtotal(phq1-phq9)
egen gad_total = rowtotal(gad1-gad7)
summarize phq_total gad_total

pwcorr phq_total gad_total, sig

*phq9 and epw
pwcorr (phq1-phq9) (epw1-epw8)

egen epw_total = rowtotal(epw1-epw8)
summarize phq_total epw_total

pwcorr phq_total epw_total, sig
