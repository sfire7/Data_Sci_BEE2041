#!/bin/bash

wget -O uk_hpi.csv "https://publicdata.landregistry.gov.uk/market-trend-data/house-price-index-data/UK-HPI-full-file-2025-12.csv?utm_medium=GOV.UK&utm_source=datadownload&utm_campaign=full_fil&utm_term=9.30_18_02_26"



388  sed -E 's|([0-9]{2})/([0-9]{2})/([0-9]{4})|\3-\2-\1|' uk_hpi.csv > uk_hpi_fixed_delimiter.csv
  389  head uk_hpi_fixed_delimiter.csv 

  415  tail -n +2 uk_hpi_fixed_delimiter.csv | grep "United Kingdom" | awk -F ',' '{ year=substr($1, 1, 4); sum[year]+=$4; count[year]++} END {for (year in sum) print year, sum[year]/count[year] }' | sort > uk_hpi_annual_average.csv
  416  cat uk_hpi_annual_average.csv
  417  ls
  418  mv gross-disposable-household-income-per-head-line-chart-data.csv uk_gdhi.csv

  423  head -n 2 uk_hpi.csv # Check the first two lines of the data file to understand its structure and format
  424  head -n 2 uk_hpi.csv | wc -l # Count the number of lines in the first two lines of the data file to confirm that it contains the expected number of lines (2)
  425  tail -n 2 uk_hpi.csv
  426  sed -E 's|([0-9]{2})/([0-9]{2})/([0-9]{4})|\3-\2-\1|' uk_hpi.csv > uk_hpi_fixed_delimiter.csv
  427  head uk_hpi_fixed_delimiter.csv
 
  449  head -n 10 uk_hpi.csv
  450  cd ~/Desktop/Data_Science_in_Economics_BEE2041/
  451  cd assignment1/
  452  head -n 10 uk_hpi.csv
  453  Date,RegionName,AreaCode,AveragePrice,Index,IndexSA,1m%Change,12m%Change,AveragePriceSA,SalesVolume,DetachedPrice,DetachedIndex,Detached1m%Change,Detached12m%Change,SemiDetachedPrice,SemiDetachedIndex,SemiDetached1m%Change,SemiDetached12m%C
  454  head -n 1 uk_hpi.csv
  455  head -n 1 uk_hpi.csv | awk -F',' '{for(i=1;i<=NF;i++) print i,$i}'

  465  tail -n +1 uk_hpi_fixed_delimiter.csv
  466  head -n 4 uk_hpi_fixed_delimiter.csv
  467  tail -n +2 uk_hpi_fixed_delimiter.csv | \ grep "United Kingdom" | \ awk -F ',' '{ year=substr($1, 1, 4); sum[year]+=$4; count[year]++} END {for (year in sum) print year, sum[year]/count[year] }' | \ sort > uk_hpi_annual_average.csv
  468  cat uk_hpi_annual_average.csv
  469  ls
  470  head -n 10 uk_gdhi.csv
  471  tail -n +7 uk_gdhi.csv | grep "United Kingdom" | awk -F ',' '{ year=substr($3, 1, 4); sum[year]+=$4; count[year]++} END {for (year in sum) print year, sum[year]/count[year] }' | sort > uk_gdhi_annual_average.csv
  472  cat uk_gdhi_annual_average.csv 

  482  awk -F ',' '$1 >= 2003 && $1 < 2024' uk_hpi_annual_average.csv > houseprice.csv

  485  cp uk_gdhi_annual_average.csv income.csv
MacBook-Air-546:~ datipapinashvili$ cd ~/Desktop/Data_Science_in_Economics_BEE2041/
MacBook-Air-546:Data_Science_in_Economics_BEE2041 datipapinashvili$ cd assignment1/
MacBook-Air-546:assignment1 datipapinashvili$ ls
historyproject.txt		uk_hpi_annual_average.csv	workflowd.sh
uk_gdhi_annual_average.csv	uk_hpi_fixed_delimiter.csv	years_house.txt
uk_gdhi.csv			uk_hpi.csv			years_income.txt
MacBook-Air-546:assignment1 datipapinashvili$ head -n 1 uk_hpi.csv
Date,RegionName,AreaCode,AveragePrice,Index,IndexSA,1m%Change,12m%Change,AveragePriceSA,SalesVolume,DetachedPrice,DetachedIndex,Detached1m%Change,Detached12m%Change,SemiDetachedPrice,SemiDetachedIndex,SemiDetached1m%Change,SemiDetached12m%Change,TerracedPrice,TerracedIndex,Terraced1m%Change,Terraced12m%Change,FlatPrice,FlatIndex,Flat1m%Change,Flat12m%Change,CashPrice,CashIndex,Cash1m%Change,Cash12m%Change,CashSalesVolume,MortgagePrice,MortgageIndex,Mortgage1m%Change,Mortgage12m%Change,MortgageSalesVolume,FTBPrice,FTBIndex,FTB1m%Change,FTB12m%Change,FOOPrice,FOOIndex,FOO1m%Change,FOO12m%Change,NewPrice,NewIndex,New1m%Change,New12m%Change,NewSalesVolume,OldPrice,OldIndex,Old1m%Change,Old12m%Change,OldSalesVolume
MacBook-Air-546:assignment1 datipapinashvili$ head -n 2 | wc -l
^C
MacBook-Air-546:assignment1 datipapinashvili$ head -n 2 uk_hpi.csv | wc -l
       2
MacBook-Air-546:assignment1 datipapinashvili$ tail -n 2 uk_hpi.csv
01/11/2025,Yorkshire and The Humber,E12000003,209467,109.3,108,1.5,3.8,206882,,348889,107,1.3,3.3,216132,110.4,1.2,4.5,169378,111.1,1.8,4.5,129914,104.5,2.1,0.6,205997,108.2,1.4,3.1,,210996,109.8,1.5,4.2,,181461,110.2,1.5,4.2,249005,108.2,1.5,3.4,,,,,,,,,,
01/12/2025,Yorkshire and The Humber,E12000003,208447,108.8,108,-0.5,3.3,206964,,347556,106.6,-0.4,2.2,215176,109.9,-0.4,4.5,168477,110.5,-0.5,3.7,128894,103.6,-0.8,0.1,204356,107.4,-0.8,2.4,,210255,109.4,-0.4,3.7,,180597,109.7,-0.5,3.7,247757,107.7,-0.5,2.8,,,,,,,,,,
MacBook-Air-546:assignment1 datipapinashvili$ awk -F ',' '$1 >= 2003 && $1 < 2024' uk_hpi_annual_average.csv > houseprice.csv
MacBook-Air-546:assignment1 datipapinashvili$ cp uk_gdhi_annual_average.csv income.csv
MacBook-Air-546:assignment1 datipapinashvili$ cp uk_gdhi_annual_average.csv income.txt
MacBook-Air-546:assignment1 datipapinashvili$ cp uk_hpi_annual_average.csv houseprice.txt
MacBook-Air-546:assignment1 datipapinashvili$ sort income.txt > sortedincome.txt
MacBook-Air-546:assignment1 datipapinashvili$ sort houseprice.txt > sortedhpi.txt
MacBook-Air-546:assignment1 datipapinashvili$  
MacBook-Air-546:assignment1 datipapinashvili$ echo 'Year AvgHPI GDHI Ratio' > affordability.txt
MacBook-Air-546:assignment1 datipapinashvili$ join sortedhpi.txt sortedincome.txt | awk '{print $1, $2, $3, $2/$3}' | sort -n >> affordability.txt
MacBook-Air-546:assignment1 datipapinashvili$ echo 'Year  Ratio' > prebrexit.txt
MacBook-Air-546:assignment1 datipapinashvili$ echo 'Year  Ratio' > postbrexit.txt
MacBook-Air-546:assignment1 datipapinashvili$ awk 'NR>1 && $1>2007 && $1<2016 {print $1, $4}' affordability.txt >> prebrexit.txt 
MacBook-Air-546:assignment1 datipapinashvili$ awk 'NR>1 && $1>2015 {print $1, $4}' affordability.txt >> postbrexit.txt
MacBook-Air-546:assignment1 datipapinashvili$ 
MacBook-Air-546:assignment1 datipapinashvili$ cat prebrexit.txt
Year  Ratio
2008 10.3799
2009 9.29932
2010 9.74092
2011 9.50547
2012 9.20385
2013 9.09757
2014 9.52594
2015 9.59224
MacBook-Air-546:assignment1 datipapinashvili$ cat postbrexit.txt
Year  Ratio
2016 10.1433
2017 10.3649
2018 10.3079
2019 10.1082
2020 10.4167
2021 10.8754
2022 11.2732
2023 10.4266
MacBook-Air-546:assignment1 datipapinashvili$ man join
MacBook-Air-546:assignment1 datipapinashvili$ wc -l prebrexit.txt
       9 prebrexit.txt
MacBook-Air-546:assignment1 datipapinashvili$ wc -l postbrexit.txt
       9 postbrexit.txt
MacBook-Air-546:assignment1 datipapinashvili$ tail -n +2 prebrexit.txt > full.txt
MacBook-Air-546:assignment1 datipapinashvili$ tail -n +2 postbrexit.txt >> full.txt
MacBook-Air-546:assignment1 datipapinashvili$ cat full.txt
2008 10.3799
2009 9.29932
2010 9.74092
2011 9.50547
2012 9.20385
2013 9.09757
2014 9.52594
2015 9.59224
2016 10.1433
2017 10.3649
2018 10.3079
2019 10.1082
2020 10.4167
2021 10.8754
2022 11.2732
2023 10.4266
MacBook-Air-546:assignment1 datipapinashvili$ sort full.txt
2008 10.3799
2009 9.29932
2010 9.74092
2011 9.50547
2012 9.20385
2013 9.09757
2014 9.52594
2015 9.59224
2016 10.1433
2017 10.3649
2018 10.3079
2019 10.1082
2020 10.4167
2021 10.8754
2022 11.2732
2023 10.4266
MacBook-Air-546:assignment1 datipapinashvili$ sort full.txt > fullsorted.txt
MacBook-Air-546:assignment1 datipapinashvili$ awk '$1==2015 {old=$2} $1==2023 {new=$2} END {printf "%.2f%%\n", ((new-old)/old)*100}' fullsorted.txt
8.70%
MacBook-Air-546:assignment1 datipapinashvili$ awk '$1==2015 {old=$2} $1==2023 {new=$2} END {printf "%.2f%%\n", ((new-old)/old)*100}' >> fullsorted.txt

^C
MacBook-Air-546:assignment1 datipapinashvili$ awk '$1==2015 {old=$2} $1==2023 {new=$2} END {printf "Percentage_Change %.2f%%\n", ((new-old)/old)*100}' fullsorted.txt > temp.txt
MacBook-Air-546:assignment1 datipapinashvili$ awk '$1==2015 {old=$2} $1==2023 {new=$2} {print} END {printf "Percentage_Change %.2f%%\n", ((new-old)/old)*100}' fullsorted.txt > temp.txt
MacBook-Air-546:assignment1 datipapinashvili$ tail -n 1 temp.txt
Percentage_Change 8.70%
MacBook-Air-546:assignment1 datipapinashvili$ mv temp.txt fullsorted.txt
MacBook-Air-546:assignment1 datipapinashvili$ cat fullsorted.txt
2008 10.3799
2009 9.29932
2010 9.74092
2011 9.50547
2012 9.20385
2013 9.09757
2014 9.52594
2015 9.59224
2016 10.1433
2017 10.3649
2018 10.3079
2019 10.1082
2020 10.4167
2021 10.8754
2022 11.2732
2023 10.4266
Percentage_Change 8.70%
MacBook-Air-546:assignment1 datipapinashvili$ fc -l > semifinalworkflow.txt
MacBook-Air-546:assignment1 datipapinashvili$ rm semifinalworkflow.txt 
MacBook-Air-546:assignment1 datipapinashvili$ touch semifinalworkflow.sh
MacBook-Air-546:assignment1 datipapinashvili$ nano semifinalworkflow.sh
