
*** IMPORT THE DATA ***

*** Iphone 10
import excel "E:\2nd year - Spring\AI TA\Presentations\Group Final\AI_Final project.xlsx", sheet("Iphone10") firstrow
tab Type
*save "E:\2nd year - Spring\AI TA\Presentations\Group Final\ip10.dta"

*** Iphone 11
import excel "E:\2nd year - Spring\AI TA\Presentations\Group Final\AI_Final project.xlsx", sheet("Iphone11") firstrow clear
drop if No ==.
tab Type
*save "E:\2nd year - Spring\AI TA\Presentations\Group Final\ip11.dta"

*** Iphone 12
import excel "E:\2nd year - Spring\AI TA\Presentations\Group Final\AI_Final project.xlsx", sheet("Iphone12") firstrow clear
drop if No ==.
tab Type
*save "E:\2nd year - Spring\AI TA\Presentations\Group Final\ip12.dta"

*** Iphone 13
import excel "E:\2nd year - Spring\AI TA\Presentations\Group Final\AI_Final project.xlsx", sheet("Iphone13") firstrow clear
drop if No ==.
tab Type
*save "E:\2nd year - Spring\AI TA\Presentations\Group Final\ip13.dta"

*** Append all the data ***

use "E:\2nd year - Spring\AI TA\Presentations\Group Final\ip10.dta", clear
append using "E:\2nd year - Spring\AI TA\Presentations\Group Final\ip11.dta"
append using "E:\2nd year - Spring\AI TA\Presentations\Group Final\ip12.dta"
append using "E:\2nd year - Spring\AI TA\Presentations\Group Final\ip13.dta"

replace Label = "positive" if Label =="P"
replace Label = "negative" if Label =="N"
replace Label = lower(Label)

*save "E:\2nd year - Spring\AI TA\Presentations\Group Final\ipall.dta"

*** Tabulate "negative" vs "positive" and Finding the incosistent value between actual comments vs system computation ***

use "E:\2nd year - Spring\AI TA\Presentations\Group Final\ipall.dta", clear

tab Label Type

destring Score, replace
sum Score if Label == "positive", detail 
sum Score if Label == "negative", detail 

gen system = 5 if Label == "positive"
replace system = 1 if system ==.
gen correct = Star - system
tab correct 

bro if correct == -4
bro if correct ==3
bro if correct ==4

*** Customer attention ***

use "E:\2nd year - Spring\AI TA\Presentations\Group Final\ipall.dta", clear

* Cleaning superfluous "space" within a string
replace Comments = itrim( Comments )
* Lower words in Comments
replace Comments = lower( Comments )

gen battery = regexm( Comments ,"battery")
gen camera = regexm( Comments ,"camera")
gen sound = regexm( Comments ,"sound")
gen deliver = regexm( Comments ,"deliver")
gen price = regexm( Comments ,"price")

count if battery == 1
count if camera == 1
count if sound == 1
count if deliver == 1
count if price == 1

asdoc tab battery Type
asdoc tab camera Type
asdoc tab sound Type
asdoc tab deliver Type
asdoc tab price Type

















