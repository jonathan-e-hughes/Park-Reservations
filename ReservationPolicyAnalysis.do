**** Globals
set seed 1977 

*** Timed Entry Analysis
* Make color palette
colorpalette viridis, n(8) reverse

* Define consisten date range
global xstart = td(01jan2021)
global xend   = td(31dec2024)
global xlabels ///
    `=td(01jan2021)' `=td(01jul2021)' `=td(01jan2022)' `=td(01jul2022)' ///
    `=td(01jan2023)' `=td(01jul2023)' `=td(01jan2024)' `=td(01jul2024)' `=td(31dec2024)'

*** Competition graphs
** Iterate through individual permit systems
foreach p in 4001 4002 10088427 10087087 10090792 255 10101918 10101919 10086911 10086912 10086746 {
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
keep if productid == `p'
sort orderdate 
replace DASharef5 = . if DayAhead != 1
replace APSharef5 = . if AdvPurch != 1
collapse (mean) DASharef5 APSharef5, by(orderdate)
* Graph
local labeltext : label permitlbl `p'
#delimit ;
twoway (bar DASharef5 orderdate, bcolor(gs9)) 
(bar APSharef5 orderdate, title("`labeltext'") bcolor("39 127 142")
ytitle("Share of Permits Reserved in First 5 Minutes") xtitle("Order Date") 
legend(rows(1) label(1 "Day Ahead") label(2 "Advanced Purchase") position(6)) 
ylabel(0(0.2)1) yscale(range(0 1))
xscale(range($xstart $xend)) xlabel($xlabels, format(%tdMon_CCYY))
);
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\Competition`labeltext'.pdf", replace
}
*** Reservation graphs
** Iterate through individual permit systems
foreach p in 4001 4002 10088427 10087087 10090792 255 10101918 10101919 10086911 10086912 10086746 {
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
keep if productid == `p'
sort orderdate
collapse (sum) count, by(orderdate)
* Graph
local labeltext : label permitlbl `p'
#delimit ;
twoway (bar count orderdate, bcolor("68 1 84") title("`labeltext'")
ytitle("Total Reservations Per Day") xtitle("Order Date") 
legend(rows(1) label(1 "All Permit Types") position(6)) 
xscale(range($xstart $xend)) xlabel($xlabels, format(%tdMon_CCYY))
);
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\Reservations`labeltext'.pdf", replace
}
*** Permits graphs
** Iterate through individual permit systems
foreach p in 4001 4002 10088427 10087087 10090792 255 10101918 10101919 10086911 10086912 10086746 {
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
keep if productid == `p'
sort startdate
collapse (sum) count, by(startdate)
* Graph
local labeltext : label permitlbl `p'
#delimit ;
twoway (bar count startdate, bcolor("74 194 109") title("`labeltext'")
ytitle("Total Permits Per Day") xtitle("Start Date") 
legend(rows(1) label(1 "All Permit Types") position(6)) 
xscale(range($xstart $xend)) xlabel($xlabels, format(%tdMon_CCYY))
);
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\Permits`labeltext'.pdf", replace
}

*** Event study graphs
** Acadia sunrise
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
keep if productid == 4001
keep if DayAhead == 1
sort startdate
collapse (sum) count (mean) MedInc DASharef5 (first) year, by(startdate)
* 2021
#delimit ;
twoway 
    (bar count startdate if year == 2021, bcolor(navy%30))
	(line DASharef5 startdate if year == 2021, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2021, yaxis(3) mcolor(navy) ),
    title("Acadia Cadillac Mountain Sunrise")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6));
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\ACAD_Sun_Event2021.pdf", replace
* 2022
#delimit ;
twoway 
    (bar count startdate if year == 2022, bcolor(navy%30))
	(line DASharef5 startdate if year == 2022, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2022, yaxis(3) mcolor(navy)),
    title("Acadia Cadillac Mountain Sunrise")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6));
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\ACAD_Sun_Event2022.pdf", replace
* 2023
#delimit ;
twoway 
    (bar count startdate if year == 2023, bcolor(navy%30))
	(line DASharef5 startdate if year == 2023, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2023, yaxis(3) mcolor(navy)),
    title("Acadia Cadillac Mountain Sunrise")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6));
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\ACAD_Sun_Event2023.pdf", replace
* 2024
#delimit ;
twoway 
    (bar count startdate if year == 2024, bcolor(navy%30))
	(line DASharef5 startdate if year == 2024, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2024, yaxis(3) mcolor(navy)),
    title("Acadia Cadillac Mountain Sunrise")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6));
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\ACAD_Sun_Event2024.pdf", replace
** Acadia daytime
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
keep if productid == 4002
keep if DayAhead == 1
sort startdate
collapse (sum) count (mean) MedInc DASharef5 (first) year, by(startdate)
* 2021
#delimit ;
twoway 
    (bar count startdate if year == 2021, bcolor(navy%30))
	(line DASharef5 startdate if year == 2021, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2021, yaxis(3) mcolor(navy)),
    title("Acadia Cadillac Mountain Daytime")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6));
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\ACAD_Day_Event2021.pdf", replace
* 2022
#delimit ;
twoway 
    (bar count startdate if year == 2022, bcolor(navy%30))
	(line DASharef5 startdate if year == 2022, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2022, yaxis(3) mcolor(navy)),
    title("Acadia Cadillac Mountain Daytime")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6));
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\ACAD_Day_Event2022.pdf", replace
* 2023
#delimit ;
twoway 
    (bar count startdate if year == 2023, bcolor(navy%30))
	(line DASharef5 startdate if year == 2023, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2023, yaxis(3) mcolor(navy)),
    title("Acadia Cadillac Mountain Daytime")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6));
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\ACAD_Day_Event2023.pdf", replace
* 2024
#delimit ;
twoway 
    (bar count startdate if year == 2024, bcolor(navy%30))
	(line DASharef5 startdate if year == 2024, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2024, yaxis(3) mcolor(navy)),
    title("Acadia Cadillac Mountain Daytime")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6));
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\ACAD_Day_Event2024.pdf", replace
** Arches
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
keep if productid == 10088427
keep if DayAhead == 1
sort startdate
collapse (sum) count (mean) MedInc DASharef5 (first) year, by(startdate)
* 2022
#delimit ;
twoway 
    (bar count startdate if year == 2022, bcolor(navy%30))
	(line DASharef5 startdate if year == 2022, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2022, yaxis(3) mcolor(navy)),
    title("Arches National Park")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))  
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\ARCH_Event2022.pdf", replace
* 2023
#delimit ;
twoway 
    (bar count startdate if year == 2023, bcolor(navy%30))
	(line DASharef5 startdate if year == 2023, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2023, yaxis(3) mcolor(navy)),
    title("Arches National Park")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))  
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\ARCH_Event2023.pdf", replace
* 2024
#delimit ;
twoway 
    (bar count startdate if year == 2024, bcolor(navy%30))
	(line DASharef5 startdate if year == 2024, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2024, yaxis(3) mcolor(navy)),
    title("Arches National Park")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))  
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\ARCH_Event2024.pdf", replace
** Glacier - Going to the Sun Road
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
keep if productid == 10087087
keep if DayAhead == 1
sort startdate
collapse (sum) count (mean) MedInc DASharef5 (first) year, by(startdate)
* 2021
#delimit ;
twoway 
    (bar count startdate if year == 2021, bcolor(navy%30))
	(line DASharef5 startdate if year == 2021, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2021, yaxis(3) mcolor(navy)),
    title("Glacier - Going to the Sun Road")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income") position(6)) 
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\GlacierGTSEvent2021.pdf", replace
* 2022
#delimit ;
twoway 
    (bar count startdate if year == 2022, bcolor(navy%30))
	(line DASharef5 startdate if year == 2022, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2022, yaxis(3) mcolor(navy)),
    title("Glacier - Going to the Sun Road")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income") position(6)) 
	xline(`=td(13jul2022)');
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\GlacierGTSEvent2022.pdf", replace
* 2023
#delimit ;
twoway 
    (bar count startdate if year == 2023, bcolor(navy%30))
	(line DASharef5 startdate if year == 2023, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2023, yaxis(3) mcolor(navy)),
    title("Glacier - Going to the Sun Road")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income") position(6)) 
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\GlacierGTSEvent2023.pdf", replace
* 2024
#delimit ;
twoway 
    (bar count startdate if year == 2024, bcolor(navy%30))
	(line DASharef5 startdate if year == 2024, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2024, yaxis(3) mcolor(navy)),
    title("Glacier - Going to the Sun Road")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Share First 5-min.") label(3 "Income") position(6)) 
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\GlacierGTSEvent2024.pdf", replace
** Glacier - Many Glacier
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
keep if productid == 10090792
keep if DayAhead == 1
sort startdate
collapse (sum) count (mean) MedInc DASharef5 (first) year, by(startdate)
* 2023
#delimit ;
twoway 
    (bar count startdate if year == 2023, bcolor(navy%30))
	(line DASharef5 startdate if year == 2023, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2023, yaxis(3) mcolor(navy)),
    title("Glacier - Many Glacier")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income") position(6)) 
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\GlacierMGEvent2023.pdf", replace
* 2024
#delimit ;
twoway 
    (bar count startdate if year == 2024, bcolor(navy%30))
	(line DASharef5 startdate if year == 2024, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2024, yaxis(3) mcolor(navy)),
    title("Glacier - Many Glacier")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income") position(6)) 
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\GlacierMGEvent2024.pdf", replace
** Haleakala 
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
keep if productid == 255
keep if DayAhead == 1
sort startdate
collapse (sum) count (mean) MedInc DASharef5 (first) year, by(startdate)
* 2021
#delimit ;
twoway 
    (bar count startdate if year == 2021, bcolor(navy%30))
	(line DASharef5 startdate if year == 2021, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2021, yaxis(3) mcolor(navy)),
    title("Haleakala Sunrise")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6)) 
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\HALE_Event2021.pdf", replace
* 2022
#delimit ;
twoway 
    (bar count startdate if year == 2022, bcolor(navy%30))
	(line DASharef5 startdate if year == 2022, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2022, yaxis(3) mcolor(navy)),
    title("Haleakala Sunrise")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6)) 
	xline(`=td(29may2022)');
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\HALE_Event2022.pdf", replace
* 2023
#delimit ;
twoway 
    (bar count startdate if year == 2023, bcolor(navy%30))
	(line DASharef5 startdate if year == 2023, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2023, yaxis(3) mcolor(navy)),
    title("Haleakala Sunrise")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6)) 
	xline(`=td(8aug2023)');
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\HALE_Event2023.pdf", replace
* 2024
#delimit ;
twoway 
    (bar count startdate if year == 2024, bcolor(navy%30))
	(line DASharef5 startdate if year == 2024, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2024, yaxis(3) mcolor(navy)),
    title("Haleakala Sunrise")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))  
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\HALE_Event2024.pdf", replace
** Rainier - Sunrise Corridor
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
keep if productid == 10101918
keep if DayAhead == 1
sort startdate
collapse (sum) count (mean) MedInc DASharef5 (first) year, by(startdate)
* 2024
#delimit ;
twoway 
    (bar count startdate if year == 2024, bcolor(navy%30))
	(line DASharef5 startdate if year == 2024, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2024, yaxis(3) mcolor(navy)),
    title("Rainier - Sunrise Corridor")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))  
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\RAIN_Sun_Event2024.pdf", replace
** Rainier - Paradise
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
keep if productid == 10101919
keep if DayAhead == 1
sort startdate
collapse (sum) count (mean) MedInc DASharef5 (first) year, by(startdate)
* 2024
#delimit ;
twoway 
    (bar count startdate if year == 2024, bcolor(navy%30))
	(line DASharef5 startdate if year == 2024, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2024, yaxis(3) mcolor(navy)),
    title("Rainier - Paradise")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))  
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\RAIN_Par_Event2024.pdf", replace
** Rocky Mountain - No Bear Lake Road
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
keep if productid == 10086911
keep if DayAhead == 1
sort startdate
collapse (sum) count (mean) MedInc DASharef5 (first) year, by(startdate)
* 2021
#delimit ;
twoway 
    (bar count startdate if year == 2021, bcolor(navy%30))
	(line DASharef5 startdate if year == 2021, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2021, yaxis(3) mcolor(navy)),
    title("RMNP - Rest of Park")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))
	xline(`=td(1jul2021)');
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\RMNP_NBLREvent2021.pdf", replace
* 2022
#delimit ;
twoway 
    (bar count startdate if year == 2022, bcolor(navy%30))
	(line DASharef5 startdate if year == 2022, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2022, yaxis(3) mcolor(navy)),
    title("RMNP - Rest of Park")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Share First 5-min.") label(3 "Income")position(6)) 
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\RMNP_NBLREvent2022.pdf", replace
* 2023
#delimit ;
twoway 
    (bar count startdate if year == 2023, bcolor(navy%30))
	(line DASharef5 startdate if year == 2023, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2023, yaxis(3) mcolor(navy)),
    title("RMNP - Rest of Park")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6)) 
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\RMNP_NBLREvent2023.pdf", replace
* 2024
#delimit ;
twoway 
    (bar count startdate if year == 2024, bcolor(navy%30))
	(line DASharef5 startdate if year == 2024, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2024, yaxis(3) mcolor(navy)),
    title("RMNP - Rest of Park")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))  
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\RMNP_NBLREvent2024.pdf", replace
** Rocky Mountain - Bear Lake Road
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
keep if productid == 10086912
keep if DayAhead == 1
sort startdate
collapse (sum) count (mean) MedInc DASharef5 (first) year, by(startdate)
* 2021
#delimit ;
twoway 
    (bar count startdate if year == 2021, bcolor(navy%30))
	(line DASharef5 startdate if year == 2021, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2021, yaxis(3) mcolor(navy)),
    title("RMNP - Bear Lake Road")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))  
	xline(`=td(1jul2021)');
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\RMNP_BLREvent2021.pdf", replace
* 2022 
#delimit ;
twoway 
    (bar count startdate if year == 2022, bcolor(navy%30))
	(line DASharef5 startdate if year == 2022, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2022, yaxis(3) mcolor(navy)),
    title("RMNP - Bear Lake Road")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))  
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\RMNP_BLREvent2022.pdf", replace
* 2023
#delimit ;
twoway 
    (bar count startdate if year == 2023, bcolor(navy%30))
	(line DASharef5 startdate if year == 2023, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2023, yaxis(3) mcolor(navy)),
    title("RMNP - Bear Lake Road")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))  
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\RMNP_BLREvent2023.pdf", replace
* 2024
#delimit ;
twoway 
    (bar count startdate if year == 2024, bcolor(navy%30))
	(line DASharef5 startdate if year == 2024, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2024, yaxis(3) mcolor(navy)),
    title("RMNP - Bear Lake Road")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))  
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\RMNP_BLREvent2024.pdf", replace
** Yosemite
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
keep if productid == 10086746
keep if DayAhead == 1
sort startdate
collapse (sum) count (mean) MedInc DASharef5 (first) year, by(startdate)
* 2021
#delimit ;
twoway 
    (bar count startdate if year == 2021, bcolor(navy%30))
	(line DASharef5 startdate if year == 2021, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2021, yaxis(3) mcolor(navy)),
    title("Yosemite")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))  
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\YOSE_Event2021.pdf", replace
* 2022
#delimit ;
twoway 
    (bar count startdate if year == 2022, bcolor(navy%30))
	(line DASharef5 startdate if year == 2022, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2022, yaxis(3) mcolor(navy)),
    title("Yosemite")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))  
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\YOSE_Event2022.pdf", replace
* 2024
#delimit ;
twoway 
    (bar count startdate if year == 2024, bcolor(navy%30))
	(line DASharef5 startdate if year == 2024, lcolor(green%30) yaxis(2))
    (scatter MedInc startdate if year == 2024, yaxis(3) mcolor(navy)),
    title("Yosemite")
    ytitle("Total Permits Per Day", axis(1))
	ytitle("Competition (5-min. Share)", axis(2))
	ytitle("Median Income", axis(3))
    xtitle("Start Date")
    legend(rows(1) label(1 "Day Ahead Permits") label(2 "Competition (Shr. 5-min.)") label(3 "Income")position(6))  
	;
#delimit cr
graph export "D:\YourDirectory_HERE\Figures\YOSE_Event2024.pdf", replace

*** Regression analysis
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
** Create indicator variable bins
gen A1 = AdvPurch == 1 & Sharef5 > 0 & Sharef5 < 0.25
gen A2 = AdvPurch == 1 & Sharef5 >= 0.25 & Sharef5 < 0.50
gen A3 = AdvPurch == 1 & Sharef5 >= 0.50 & Sharef5 < 0.75
gen A4 = AdvPurch == 1 & Sharef5 >= 0.75 & Sharef5 <= 1
gen D1 = DayAhead == 1 & Sharef5 > 0 & Sharef5 < 0.25
gen D2 = DayAhead == 1 & Sharef5 >= 0.25 & Sharef5 < 0.50
gen D3 = DayAhead == 1 & Sharef5 >= 0.50 & Sharef5 < 0.75
gen D4 = DayAhead == 1 & Sharef5 >= 0.75 & Sharef5 <= 1
gen L1 = LeadTime > 0 & LeadTime < 30
gen L2 = LeadTime >= 30 & LeadTime < 60
gen L3 = LeadTime >= 60 & LeadTime < 90
gen L4 = LeadTime >= 90 & LeadTime < 120
gen L5 = LeadTime >= 120 & LeadTime < 180
gen L6 = LeadTime >= 180 
** Create clustering variable (product X year)
egen TxID = group(productid year)
** Models
* Unconditional
xi: reg MedInc i.A1 i.A2 i.A3 i.A4 i.D1 i.D2 i.D3 i.D4 ///
i.L1 i.L2 i.L3 i.L4 i.L5 i.L6 i.productid, cluster(TxID)
estadd local parkeffects "Yes" 
estadd local weekeffects "No" 
estadd local parkweekeffects "No" 
eststo Base
* Add holidays and weekends
xi: reg MedInc i.A1 i.A2 i.A3 i.A4 i.D1 i.D2 i.D3 i.D4 ///
i.L1 i.L2 i.L3 i.L4 i.L5 i.L6 i.FedHoliday i.Weekend i.productid, cluster(TxID)
estadd local parkeffects "Yes" 
estadd local weekeffects "No" 
estadd local parkweekeffects "No" 
eststo WeekendEffects
* Add week of year effects
xi: reg MedInc i.A1 i.A2 i.A3 i.A4 i.D1 i.D2 i.D3 i.D4 ///
i.L1 i.L2 i.L3 i.L4 i.L5 i.L6 i.FedHoliday i.Weekend i.week i.productid, cluster(TxID)
estadd local parkeffects "Yes" 
estadd local weekeffects "Yes" 
estadd local parkweekeffects "No" 
eststo Seasonality
* Add parkXweek of year effects
xi: reg MedInc i.A1 i.A2 i.A3 i.A4 i.D1 i.D2 i.D3 i.D4 ///
i.L1 i.L2 i.L3 i.L4 i.L5 i.L6 i.FedHoliday i.Weekend i.week*i.productid, cluster(TxID)
estadd local parkeffects "Yes" 
estadd local weekeffects "Yes" 
estadd local parkweekeffects "Yes" 
eststo ParkSeasonality
*** Non-parametric estimator
**************** Randomly sample to make computation feasible ****************
sample 10
******************************************************************************
#delimit ;
foreach var in MedInc 
_IA1_1 _IA2_1 _IA3_1 _IA4_1 
_ID1_1  _ID2_1 _ID3_1 _ID4_1 
_IFedHolida_1 _IWeekend_1 
_Iproductid_4001 _Iproductid_4002 
_Iproductid_10086746 _Iproductid_10086911 
_Iproductid_10086912 _Iproductid_10087087 
_Iproductid_10088427 _Iproductid_10090792 
_Iproductid_10101918 _Iproductid_10101919
{;
#delimit cr
qui: lpoly `var' LeadTime, generate(s`var') at(LeadTime) nograph kernel(gaussian) degree(1) bwidth(10) 
qui: gen resid`var' = `var' - s`var'
display `var'
}
** Estimate parameters
* Rename residual values for table consistency
gen OrigMedInc = MedInc
replace MedInc = residMedInc 
replace _IA1_1 = resid_IA1_1 
replace _IA2_1 = resid_IA2_1 
replace _IA3_1 = resid_IA3_1 
replace _IA4_1 = resid_IA4_1 
replace _IA4_1 = resid_IA4_1  
replace _ID2_1 = resid_ID2_1 
replace _ID3_1 = resid_ID3_1 
replace _ID4_1 = resid_ID4_1 
replace _IFedHolida_ = resid_IFedHolida_1 
replace _IWeekend_1 = resid_IWeekend_1 
replace _Iproductid_4001 = resid_Iproductid_4001 
replace _Iproductid_4002 = resid_Iproductid_4002 
replace _Iproductid_10086746 = resid_Iproductid_10086746 
replace _Iproductid_10086911 = resid_Iproductid_10086911 
replace _Iproductid_10086912 = resid_Iproductid_10086912 
replace _Iproductid_10087087 = resid_Iproductid_10087087 
replace _Iproductid_10088427 = resid_Iproductid_10088427 
replace _Iproductid_10090792 = resid_Iproductid_10090792 
replace _Iproductid_10101918 = resid_Iproductid_10101918 
replace _Iproductid_10101919 = resid_Iproductid_10101919
#delimit ;
reg MedInc 
_IA1_1 _IA2_1 _IA3_1 _IA4_1 
_ID1_1  _ID2_1 _ID3_1 _ID4_1 
_IFedHolida_1 _IWeekend_1 
_Iproductid_4001 _Iproductid_4002 
_Iproductid_10086746 _Iproductid_10086911 
_Iproductid_10086912 _Iproductid_10087087 
_Iproductid_10088427 _Iproductid_10090792 
_Iproductid_10101918 _Iproductid_10101919, cluster(TxID) 
nocons;
#delimit cr
estadd local parkeffects "Yes" 
estadd local weekeffects "No" 
estadd local parkweekeffects "No" 
eststo NonParametric
* Figure
predict fittedInc
replace fittedInc = OrigMedInc-fittedInc
#delimit ;
twoway 
(scatter fittedInc LeadTime if LeadTime <= 250, msymbol(o) msize(tiny) mcolor(navy%30))
(lpolyci fittedInc LeadTime if LeadTime <= 250, kernel(gaussian) degree(1) bwidth(10))
, scheme(s1mono)
legend(off)
title("Income Lead Time Relationship")
ytitle("Median Income ($)")
xtitle("Lead Time (Days)")
xscale(range(0 250))
;
graph export "D:\YourDirectory_HERE\Figures\LeadTimeNonPara.jpg", replace width(1600) height(1200) quality(100);
#delimit cr
** Create table
esttab Base WeekendEffects Seasonality ParkSeasonality NonParametric using "D:\YourDirectory_HERE\Writing\MainRegressions.tex", ///
    se label star(* 0.10 ** 0.05 *** 0.01) ///
	keep(_IA1_1 _IA2_1 _IA3_1 _IA4_1 _ID1_1  _ID2_1 _ID3_1 _ID4_1 /// 
	_IL1_1 _IL2_1 _IL3_1 _IL4_1 _IL5_1 _IFedHolida_1 _IWeekend_1 ) ///
    booktabs title("Effects of Timed-Entry Systems on User Income") ///
	stats(parkeffects weekeffects parkweekeffects N, fmt(%s %s %s %9.0g) ///
	label("Permit Effects" "Week effects" "Park*Week" "Observations")) ///
    replace mtitles

**** Selection on unobservables and outputs for Oster (2019) calculations
*** Clean up income distribution variable
import delimited "D:\Dropbox\Timed Entry\Data\IncDist\ZipGini.csv", clear 
gen Gini = real(v3)
drop if Gini == .
split(v2)
rename v22 zip
order zip Gini
sort zip
keep zip Gini
save "D:\Dropbox\Timed Entry\Data\Gini2019Clean.dta", replace
*** Clean up population variable
import delimited "D:\Dropbox\Timed Entry\Data\IncDist\ZipPop.csv", clear 
gen Pop = real(v3)
drop if Pop == .
split(v2)
rename v22 zip
order zip Pop
sort zip
keep zip Pop
save "D:\Dropbox\Timed Entry\Data\Pop2019Clean.dta", replace
*** Construct total Rec.gov activity variable
import delimited "D:\Recreation dot Gov Data\reservations2021\reservations2021.csv", clear
gen TotRec = 1
sort customerzip
gen zip = substr(customerzip,1,5)
drop if zip == ""
sort zip
collapse (sum) TotRec, by(zip)
merge 1:1 zip using "D:\Dropbox\Timed Entry\Data\Pop2019Clean.dta",
gen RecPerCap = TotRec/Pop
keep zip RecPerCap
sort zip
save "D:\Dropbox\Timed Entry\Data\RecPerCapClean.dta", replace
**** Income Models
******* Use Model 3 Specification as Marginal Effects NOT Computed for Model 4 **********
use "D:\Dropbox\Timed Entry\Data\AllParks_All.dta", clear
drop if strlen(customerzip) > 5
recast str5 customerzip
*** Merge in and create proxies for cross moments
** Travel distances
sort customerzip
merge m:1 customerzip using "D:\Recreation dot Gov Data\US_ZIP_codes_to_longitude_and_latitude_clean.dta",
drop if _merge == 2
drop _merge
* Fill in some missing latitudes and longitudes
replace facilitylongitude = -68.4616174 if parentlocation == "Acadia National Park"
replace facilitylatitude = 44.3192622 if parentlocation == "Acadia National Park"
replace facilitylongitude = -156.2318748 if parentlocation == "HaleakalÄ National Park"
replace facilitylatitude = 20.7034967 if parentlocation == "HaleakalÄ National Park"
replace facilitylongitude = -156.2318748 if parentlocation == "Haleakala National Park"
replace facilitylatitude = 20.7034967 if parentlocation == "Haleakala National Park"
replace facilitylongitude = -121.7149235 if parentlocation == "Mount Rainier National Park"
replace facilitylatitude = 46.8601069 if parentlocation == "Mount Rainier National Park"
replace facilitylongitude = -109.7504503 if parentlocation == "Arches National Park"
replace facilitylatitude = 38.7317195 if parentlocation == "Arches National Park"
replace facilitylongitude = -114.1754903 if parentlocation == "Glacier National Park"
replace facilitylatitude = 48.6596785 if parentlocation == "Glacier National Park"
replace facilitylongitude = -105.8412874 if parentlocation == "Rocky Mountain National Park"
replace facilitylatitude = 40.350615 if parentlocation == "Rocky Mountain National Park"
replace facilitylongitude = -119.8807559 if parentlocation == "Yosemite National Park"
replace facilitylatitude = 37.8528496 if parentlocation == "Yosemite National Park"
geodist customerlat customerlong facilitylatitude facilitylongitude, gen(distance) miles
drop if distance == .
rename distance Dist
** Merge in Gini coeff
sort zip
merge m:1 zip using "D:\Dropbox\Timed Entry\Data\Gini2019Clean.dta",
keep if _merge == 3
drop _merge
** Merge in Recreation per capita 
sort zip
merge m:1 zip using "D:\Dropbox\Timed Entry\Data\RecPerCapClean.dta",
keep if _merge == 3
drop _merge
***
gen A1 = AdvPurch == 1 & Sharef5 > 0 & Sharef5 < 0.25
gen A2 = AdvPurch == 1 & Sharef5 >= 0.25 & Sharef5 < 0.50
gen A3 = AdvPurch == 1 & Sharef5 >= 0.50 & Sharef5 < 0.75
gen A4 = AdvPurch == 1 & Sharef5 >= 0.75 & Sharef5 <= 1
gen D1 = DayAhead == 1 & Sharef5 > 0 & Sharef5 < 0.25
gen D2 = DayAhead == 1 & Sharef5 >= 0.25 & Sharef5 < 0.50
gen D3 = DayAhead == 1 & Sharef5 >= 0.50 & Sharef5 < 0.75
gen D4 = DayAhead == 1 & Sharef5 >= 0.75 & Sharef5 <= 1
gen L1 = LeadTime > 0 & LeadTime < 30
gen L2 = LeadTime >= 30 & LeadTime < 60
gen L3 = LeadTime >= 60 & LeadTime < 90
gen L4 = LeadTime >= 90 & LeadTime < 120
gen L5 = LeadTime >= 120 & LeadTime < 180
gen L6 = LeadTime >= 180 
* Clustering variable (product X year)
egen TxID = group(productid year)
**** Check of main specification with (smaller) sample
drop if Gini == .
drop if Dist == .
drop if RecPerCap == .
* Add parkXweek of year effects
xi: reg MedInc i.A1 i.A2 i.A3 i.A4 i.D1 i.D2 i.D3 i.D4 ///
i.L1 i.L2 i.L3 i.L4 i.L5 i.L6 i.FedHoliday i.Weekend i.week i.productid, cluster(TxID)
estadd local parkeffects "Yes" 
estadd local weekeffects "Yes" 
estadd local parkweekeffects "Yes" 
eststo ParkSeasonality_redsamp
* Add Mundlak terms
xi: reg MedInc i.A1 i.A2 i.A3 i.A4 i.D1 i.D2 i.D3 i.D4 ///
i.L1 i.L2 i.L3 i.L4 i.L5 i.L6 ///
Dist RecPerCap Gini ///
i.FedHoliday i.Weekend i.week i.productid, cluster(TxID)
estadd local parkeffects "Yes" 
estadd local weekeffects "Yes" 
estadd local parkweekeffects "Yes" 
eststo Mundlak
*** Create tables
esttab ParkSeasonality_redsamp Mundlak using ///
    "D:\Dropbox\Timed Entry\Writing\RobustRegressions.tex", ///
    cells(b(fmt(3)) se(par fmt(3))) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs ///
    keep(_IA1_1 _IA2_1 _IA3_1 _IA4_1 _ID1_1  _ID2_1 _ID3_1 _ID4_1 ///
         _IL1_1 _IL2_1 _IL3_1 _IL4_1 _IL5_1 _IL6_1 _IFedHolida_1 _IWeekend_1) ///
    title("Effects of Timed-Entry Systems on User Income") ///
    stats(parkeffects weekeffects parkweekeffects N r2, ///
          fmt(%s %s %s %9.0g) ///
          label("Permit Effects" "Week effects" "Park*Week" "Observations" "R-squared")) ///
replace mtitles
* Auxilliary version for calculations
*** Create .csv table
esttab ParkSeasonality_redsamp Mundlak using ///
    "D:\Dropbox\Timed Entry\Writing\RobustRegressions.csv", ///
    cells(b(fmt(3)) se(par fmt(3))) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label ///
    keep(_IA1_1 _IA2_1 _IA3_1 _IA4_1 _ID1_1 _ID2_1 _ID3_1 _ID4_1 ///
         _IL1_1 _IL2_1 _IL3_1 _IL4_1 _IL5_1 _IL6_1 _IFedHolida_1 _IWeekend_1) ///
    stats(parkeffects weekeffects parkweekeffects N r2, ///
          fmt(%s %s %s %9.0g %9.3f %9.3f) ///
          label("Permit Effects" "Week effects" "Park*Week" "Observations" "R-squared")) ///
    replace mtitles ///
    plain
**** Formatting is a pain here, so output a separate table and  
* manually add the marginal effects
* Add Proxies for cross-moments
xi: reg MedInc ///
c.Dist##i.A1 c.Dist##i.A2 c.Dist##i.A3 c.Dist##i.A4 ///
c.RecPerCap##i.A1 c.RecPerCap##i.A2 c.RecPerCap##i.A3 c.RecPerCap##i.A4 ///
c.Gini##i.A1 c.Gini##i.A2 c.Gini##i.A3 c.Gini##i.A4 ///
c.Dist##i.D1 c.Dist##i.D2 c.Dist##i.D3 c.Dist##i.D4 ///
c.RecPerCap##i.D1 c.RecPerCap##i.D2 c.RecPerCap##i.D3 c.RecPerCap##i.D4 ///
c.Gini##i.D1 c.Gini##i.D2 c.Gini##i.D3 c.Gini##i.D4 ///
c.Dist##i.L1 c.Dist##i.L2 c.Dist##i.L3 c.Dist##i.L4 c.Dist##i.L5 c.Dist##i.L6 ///
c.RecPerCap##i.L1 c.RecPerCap##i.L2 c.RecPerCap##i.L3 c.RecPerCap##i.L4 c.RecPerCap##i.L5 c.RecPerCap##i.L6 ///
c.Gini##i.L1 c.Gini##i.L2 c.Gini##i.L3 c.Gini##i.L4 c.Gini##i.L5 c.Gini##i.L6 ///
i.FedHoliday i.Weekend i.week i.productid, cluster(TxID)
scalar reg_r2  = e(r2)
scalar reg_N   = e(N)
margins, dydx(A1 A2 A3 A4 D1 D2 D3 D4 L1 L2 L3 L4 L5 L6) atmeans
matrix b = r(b)
matrix V = r(V)
ereturn post b V
scalar reg_r2  = e(r2)
scalar reg_N   = e(N)
eststo Margins
* Make table
esttab Margins using "D:\Dropbox\Timed Entry\Writing\margins_table.tex", ///
    cells(b(fmt(3)) se(par fmt(3))) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs ///
    stats(N r2, ///
          fmt(%9.0g %9.3f %9.3f) ///
          label("Observations" "R-squared")) ///
    title("Marginal Effects at Means") ///
    replace
* .csv version for calculations
esttab Margins using "D:\Dropbox\Timed Entry\Writing\margins_table.csv", ///
    cells(b(fmt(3)) se(par fmt(3))) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    label ///
    plain ///
    stats(N r2, ///
          fmt(%9.0g %9.3f %9.3f) ///
          label("Observations" "R-squared")) ///
    title("Marginal Effects at Means") ///
    replace	
	
*** Robustness checks 
** "Leave one out" analysis
use "D:\YourDirectory_HERE\Data\AllParks_All.dta", clear
gen A1 = AdvPurch == 1 & Sharef5 > 0 & Sharef5 < 0.25
gen A2 = AdvPurch == 1 & Sharef5 >= 0.25 & Sharef5 < 0.50
gen A3 = AdvPurch == 1 & Sharef5 >= 0.50 & Sharef5 < 0.75
gen A4 = AdvPurch == 1 & Sharef5 >= 0.75 & Sharef5 <= 1
gen D1 = DayAhead == 1 & Sharef5 > 0 & Sharef5 < 0.25
gen D2 = DayAhead == 1 & Sharef5 >= 0.25 & Sharef5 < 0.50
gen D3 = DayAhead == 1 & Sharef5 >= 0.50 & Sharef5 < 0.75
gen D4 = DayAhead == 1 & Sharef5 >= 0.75 & Sharef5 <= 1
gen L1 = LeadTime > 0 & LeadTime < 30
gen L2 = LeadTime >= 30 & LeadTime < 60
gen L3 = LeadTime >= 60 & LeadTime < 90
gen L4 = LeadTime >= 90 & LeadTime < 120
gen L5 = LeadTime >= 120 & LeadTime < 180
gen L6 = LeadTime >= 180 
* Clustering variable (product X year)
egen TxID = group(productid year)
* Acadia
xi: reg MedInc i.A1 i.A2 i.A3 i.A4 i.D1 i.D2 i.D3 i.D4 ///
i.L1 i.L2 i.L3 i.L4 i.L5 i.L6 i.FedHoliday i.Weekend i.week*i.productid ///
if parentlocation != "Acadia National Park", cluster(TxID)
estadd local parkeffects "Yes" 
estadd local weekeffects "Yes" 
estadd local parkweekeffects "Yes" 
eststo Acadia
* Arches
xi: reg MedInc i.A1 i.A2 i.A3 i.A4 i.D1 i.D2 i.D3 i.D4 ///
i.L1 i.L2 i.L3 i.L4 i.L5 i.L6 i.FedHoliday i.Weekend i.week*i.productid ///
if parentlocation != "Arches National Park", cluster(TxID)
estadd local parkeffects "Yes" 
estadd local weekeffects "Yes" 
estadd local parkweekeffects "Yes" 
eststo Arches
* Glacier
xi: reg MedInc i.A1 i.A2 i.A3 i.A4 i.D1 i.D2 i.D3 i.D4 ///
i.L1 i.L2 i.L3 i.L4 i.L5 i.L6 i.FedHoliday i.Weekend i.week*i.productid ///
if parentlocation != "Glacier National Park", cluster(TxID)
estadd local parkeffects "Yes" 
estadd local weekeffects "Yes" 
estadd local parkweekeffects "Yes" 
eststo Glacier
* Haleakala
xi: reg MedInc i.A1 i.A2 i.A3 i.A4 i.D1 i.D2 i.D3 i.D4 ///
i.L1 i.L2 i.L3 i.L4 i.L5 i.L6 i.FedHoliday i.Weekend i.week*i.productid ///
if parentlocation != "Haleakala National Park", cluster(TxID)
estadd local parkeffects "Yes" 
estadd local weekeffects "Yes" 
estadd local parkweekeffects "Yes" 
eststo Haleakala
* Rainier
xi: reg MedInc i.A1 i.A2 i.A3 i.A4 i.D1 i.D2 i.D3 i.D4 ///
i.L1 i.L2 i.L3 i.L4 i.L5 i.L6 i.FedHoliday i.Weekend i.week*i.productid ///
if parentlocation != "Mount Rainier National Park", cluster(TxID)
estadd local parkeffects "Yes" 
estadd local weekeffects "Yes" 
estadd local parkweekeffects "Yes" 
eststo Rainier
* Rocky Mountain National Park
xi: reg MedInc i.A1 i.A2 i.A3 i.A4 i.D1 i.D2 i.D3 i.D4 ///
i.L1 i.L2 i.L3 i.L4 i.L5 i.L6 i.FedHoliday i.Weekend i.week*i.productid ///
if parentlocation != "Rocky Mountain National Park", cluster(TxID)
estadd local parkeffects "Yes" 
estadd local weekeffects "Yes" 
estadd local parkweekeffects "Yes" 
eststo Rocky
* Yosemite National Park
xi: reg MedInc i.A1 i.A2 i.A3 i.A4 i.D1 i.D2 i.D3 i.D4 ///
i.L1 i.L2 i.L3 i.L4 i.L5 i.L6 i.FedHoliday i.Weekend i.week*i.productid ///
if parentlocation != "Yosemite National Park", cluster(TxID)
estadd local parkeffects "Yes" 
estadd local weekeffects "Yes" 
estadd local parkweekeffects "Yes" 
eststo Yosemite
*** Create table
esttab Acadia Arches Glacier Haleakala Rainier Rocky Yosemite ///
using "D:\YourDirectory_HERE\Writing\LeaveOutRobust.tex", ///
    se label star(* 0.10 ** 0.05 *** 0.01) ///
	keep(_IA1_1 _IA2_1 _IA3_1 _IA4_1 _ID1_1  _ID2_1 _ID3_1 _ID4_1 /// 
	_IL1_1 _IL2_1 _IL3_1 _IL4_1 _IL5_1 _IFedHolida_1 _IWeekend_1 ) ///
    booktabs title("Effects of Timed-Entry Systems on User Income") ///
	stats(parkeffects weekeffects parkweekeffects N, fmt(%s %s %s %9.0g) ///
	label("Permit Effects" "Week effects" "Park*Week" "Observations")) ///
    replace mtitles
